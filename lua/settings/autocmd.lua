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

local function notify_roslyn(event, path)
	local uri = vim.uri_from_fname(path)
	local clients = vim.lsp.get_clients({ name = "roslyn_ls" })
	for _, client in ipairs(clients) do
		client.notify("workspace/didChangeWatchedFiles", {
			changes = {
				{
					uri = uri,
					type = event, -- 1 = created, 2 = changed, 3 = deleted
				},
			},
		})
	end
end

local watchers = {}

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

-- only watch files we care about
local function should_watch(path)
	-- skip ignored directories
	for _, dir in ipairs(ignore_dirs) do
		if path:find("[/\\]" .. dir .. "[/\\]") then
			return false
		end
	end

	-- allow .cs, .csproj, .sln
	if path:match("%.cs$") or path:match("%.csproj$") or path:match("%.sln$") then
		return true
	end

	return false
end

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

		if events.change then
			notify_roslyn(2, fullpath)
		elseif events.rename then
			-- rename can be either create or delete
			notify_roslyn(1, fullpath)
			notify_roslyn(3, fullpath)
		end
	end)

	watchers[client.id] = handle

	vim.api.nvim_create_autocmd("LspDetach", {
		once = true,
		callback = function(args)
			if args.data.client_id == client.id then
				handle:stop()
				watchers[client.id] = nil
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
