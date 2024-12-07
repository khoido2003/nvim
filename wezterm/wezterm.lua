local wezterm = require 'wezterm'
local config = {}

-- Set padding for the terminal to zero to avoid any unnecessary space around
-- Neovim
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Define the Rose Pine Moon palette
local rose_pine = {
  base = '#18191a',        -- Base background color
  overlay = '#393552',     -- Overlay background color for floating windows
  text = '#e0def4',        -- Text color
  accent = '#89d3c3',      -- Cyan accent color
  rose = '#ebbcba',        -- Yellow accent color
  love = '#eb6f92',        -- Red accent color
  foam = '#9ccfd8',        -- Green accent color
  pine = '#31748f',        -- Blue accent color
  iris = '#c4a7e7',        -- Purple accent color
  gold = '#f6c177',        -- Gold accent color
}

config.colors = {
  -- The default text color
  foreground = rose_pine.text,
  -- The default background color
  background = rose_pine.base,

  -- Overrides the cell background color when the current cell is occupied by the cursor and the cursor style is set to Block
  cursor_bg = rose_pine.rose,  -- Cyan for cursor background
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = rose_pine.base,  -- Background color of cursor
  -- Specifies the border color of the cursor when the cursor style is set to Block
  cursor_border = rose_pine.accent,

  -- the foreground color of selected text
  selection_fg = rose_pine.text,
  -- the background color of selected text
  selection_bg = rose_pine.overlay,  -- Yellow background for selection
  

  -- The color of the scrollbar "thumb"
  scrollbar_thumb = '#222222',  -- Dark scrollbar thumb

  -- The color of the split lines between panes
  split = rose_pine.overlay,

  -- ANSI colors, mapped to Rose Pine colors
  ansi = {
    rose_pine.base,   -- Black
    rose_pine.love,   -- Maroon
    rose_pine.foam,   -- Green
    rose_pine.rose,   -- Olive
    rose_pine.pine,   -- Navy
    rose_pine.iris,   -- Purple
    rose_pine.accent, -- Teal
    rose_pine.text,   -- Silver
  },

  -- Bright colors, mapped to Rose Pine colors
  brights = {
    rose_pine.base,   -- Grey
    rose_pine.love,   -- Red
    rose_pine.foam,   -- Lime
    rose_pine.rose,   -- Yellow
    rose_pine.pine,   -- Blue
    rose_pine.iris,   -- Fuchsia
    rose_pine.accent, -- Aqua
    rose_pine.text,   -- White
  },

  indexed = { [136] = rose_pine.rose },  

  -- IME compose cursor color
  compose_cursor = rose_pine.iris,  -- Purple

  -- Colors for copy_mode and quick_select
  copy_mode_active_highlight_bg = { Color = rose_pine.base },
  copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
  copy_mode_inactive_highlight_bg = { Color = rose_pine.foam },
  copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

  quick_select_label_bg = { Color = rose_pine.pine },
  quick_select_label_fg = { Color = rose_pine.text },
  quick_select_match_bg = { AnsiColor = 'Navy' },
  quick_select_match_fg = { Color = rose_pine.text },
}


local dimmer = { brightness = 0.2 }

config.background = {
  -- This is the deepest/back-most layer. It will be rendered first
  {
    source = {
      File = 'C:/Users/Lenovo/OneDrive/Pictures/arcane-11.jpg',
    },
    -- The texture tiles vertically but not horizontally.
    -- When we repeat it, mirror it so that it appears "more seamless".
    -- An alternative to this is to set `width = "100%"` and have
    -- it stretch across the display
    repeat_x = 'Mirror',
    hsb = dimmer,
    -- When the viewport scrolls, move this layer 10% of the number of
    -- pixels moved by the main viewport. This makes it appear to be
    -- further behind the text.
    attachment = { Parallax = 0.0 },
  },
 }




return config
