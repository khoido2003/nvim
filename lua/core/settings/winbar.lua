-- lua/config/winbar.lua

-- List of filetypes and buftypes to ignore
local excluded_filetypes = {
	"NvimTree",
	"neo-tree",
	"Outline",
	"TelescopePrompt",
	"help",
	"terminal",
	"lspinfo",
	"noice",
	"qf",
	"lazy",
}

local excluded_buftypes = { "nofile", "prompt", "terminal", "quickfix" }

-- Create highlight group from current theme dynamically
local function set_dynamic_highlight()
	local base = vim.api.nvim_get_hl(0, { name = "StatusLine", link = false })
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })

	vim.api.nvim_set_hl(0, "WinBarFilename", {
		fg = base.bg,
		bg = base.fg,
		bold = true,
	})

	vim.api.nvim_set_hl(0, "WinBar", {
		fg = normal.fg,
		bg = normal.bg,
	})
end

-- Update the winbar (only for valid buffers)

local function get_icon_and_name()
	local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
	if filename == "" then
		return "", "[No Name]" -- fallback icon + text
	end

	local ok, devicons = pcall(require, "nvim-web-devicons")
	if not ok then
		return "", filename -- generic document icon
	end

	local icon, _ = devicons.get_icon(filename, nil, { default = true })
	return icon, filename
end
local function update_winbar()
	local ft = vim.bo.filetype
	local bt = vim.bo.buftype

	for _, v in ipairs(excluded_filetypes) do
		if ft == v then
			vim.wo.winbar = ""
			return
		end
	end
	for _, v in ipairs(excluded_buftypes) do
		if bt == v then
			vim.wo.winbar = ""
			return
		end
	end

	local icon, name = get_icon_and_name()
	local tag = "  " .. icon .. " " .. name .. "  "
	vim.wo.winbar = "%=" .. "%#WinBarFilename#" .. tag .. "%*"
end

-- Colorscheme-aware + event-driven update
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_dynamic_highlight,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "FileType", "WinNew" }, {
	callback = function()
		set_dynamic_highlight()
		update_winbar()
	end,
})
