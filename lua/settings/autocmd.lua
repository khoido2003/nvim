-- Large file optimizations
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local lines = vim.fn.line("$")
		if lines > 15000 then
			vim.opt_local.syntax = "off"
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
		end
	end,
})

-- Enable cursorline only in active buffer
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

-- /////////////////////////////////////////////////////////

-- Roslyn file watcher for C# projects (Unity + general .NET)
local uv = vim.uv or vim.loop

-- ///////////////////////////////////////////////////////////
-- SETTINGS
-- ///////////////////////////////////////////////////////////

-- enable batching? (default = false for stability)
local enable_batching = true
-- batch flush interval in milliseconds (only used if batching is enabled)
local batch_interval = 100

-- junk folders we don’t care about
local ignore_dirs = {
	"Library",
	"Temp",
	"Logs",
	"Obj",
	"Bin",
	".git",
	".idea",
	".vs",
}

-- ///////////////////////////////////////////////////////////
-- CORE HELPERS
-- ///////////////////////////////////////////////////////////

local function notify_roslyn(changes)
	local clients = vim.lsp.get_clients({ name = "roslyn_ls" })
	for _, client in ipairs(clients) do
		client.notify("workspace/didChangeWatchedFiles", {
			changes = changes,
		})
	end
end

-- filter to only watch useful files
local function should_watch(path)
	for _, dir in ipairs(ignore_dirs) do
		if path:find("[/\\]" .. dir .. "[/\\]") then
			return false
		end
	end
	return path:match("%.cs$") or path:match("%.csproj$") or path:match("%.sln$")
end

-- ///////////////////////////////////////////////////////////
-- WATCHER LOGIC
-- ///////////////////////////////////////////////////////////

local watchers = {}
local batch_queues = {}

local function start_watching(client)
	if watchers[client.id] then
		return
	end

	local root = client.config.root_dir
	if not root then
		return
	end

	local handle = uv.new_fs_event()

	handle:start(root, { recursive = true }, function(err, filename, events)
		if err then
			return
		end

		-- watcher got invalidated (common on Linux after deletes)
		if not filename then
			handle:stop()
			watchers[client.id] = nil
			vim.schedule(function()
				if client.is_stopped() then
					return
				end
				start_watching(client)
			end)
			return
		end

		local fullpath = root .. "/" .. filename
		if not should_watch(fullpath) then
			return
		end

		local evs = {}
		if events.change then
			table.insert(evs, { uri = vim.uri_from_fname(fullpath), type = 2 })
		elseif events.rename then
			-- rename can be create + delete
			table.insert(evs, { uri = vim.uri_from_fname(fullpath), type = 1 })
			table.insert(evs, { uri = vim.uri_from_fname(fullpath), type = 3 })
		end

		if #evs == 0 then
			return
		end

		if enable_batching then
			-- lazy-init batch queue
			if not batch_queues[client.id] then
				batch_queues[client.id] = { events = {}, timer = nil }
			end
			local queue = batch_queues[client.id]

			-- append events
			vim.list_extend(queue.events, evs)

			-- start timer if not running
			if not queue.timer then
				queue.timer = uv.new_timer()
				queue.timer:start(batch_interval, 0, function()
					local changes = queue.events
					queue.events = {}
					queue.timer:stop()
					queue.timer:close()
					queue.timer = nil

					if #changes > 0 then
						vim.schedule(function()
							notify_roslyn(changes)
						end)
					end
				end)
			end
		else
			-- no batching → send immediately
			notify_roslyn(evs)
		end
	end)

	watchers[client.id] = handle

	-- cleanup on detach
	vim.api.nvim_create_autocmd("LspDetach", {
		once = true,
		callback = function(args)
			if args.data.client_id == client.id then
				handle:stop()
				watchers[client.id] = nil
				if batch_queues[client.id] then
					if batch_queues[client.id].timer then
						batch_queues[client.id].timer:stop()
						batch_queues[client.id].timer:close()
					end
					batch_queues[client.id] = nil
				end
			end
		end,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
			start_watching(client)
		end
	end,
})
