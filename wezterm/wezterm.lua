local wezterm = require("wezterm")

local is_windows = os.getenv("OS") and os.getenv("OS"):lower():find("windows")

local paths = {
  'C:\\Users\\mason\\Documents\\Projects',
  'C:\\Users\\mason\\.config\\wezterm',
  'C:\\Users\\mason\\AppData\\Local\\nvim',
}

local config = wezterm.config_builder()

local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then return title end
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local LEFT  = wezterm.nerdfonts.pl_right_hard_divider
  local RIGHT = wezterm.nerdfonts.pl_left_hard_divider
  local bar   = "#232136"
  local bg, fg
  if tab.is_active then
    bg, fg = "#c4a7e7", "#232136"
  elseif hover then
    bg, fg = "#393552", "#908caa"
  else
    bg, fg = "#2a273f", "#6e6a86"
  end
  local title = tab_title(tab)
  local index = tab.tab_index + 1
  return {
    { Background = { Color = bar } }, { Foreground = { Color = bg } }, { Text = LEFT },
    { Background = { Color = bg  } }, { Foreground = { Color = fg } }, { Text = " " .. index .. ": " .. title .. " " },
    { Background = { Color = bar } }, { Foreground = { Color = bg } }, { Text = RIGHT },
  }
end)

config.automatically_reload_config = true
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "rose-pine-moon"
config.max_fps = 120
config.font = wezterm.font("Hack Nerd Font", { weight = "Regular" })
config.window_frame = {
	font = wezterm.font("Hack Nerd Font", { weight = "Bold" }),
}
config.use_fancy_tab_bar = false
config.colors = {
  tab_bar = {
    background = "#232136",
    new_tab       = { bg_color = "#232136", fg_color = "#6e6a86" },
    new_tab_hover = { bg_color = "#2a273f", fg_color = "#908caa" },
  },
}

if is_windows then
	config.win32_system_backdrop = "Acrylic"
	config.window_background_opacity = 0.8
	config.window_frame.font_size = 10.0
end

config.keys = {
  { key = ':', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right', size = { Percent = 15 }, command = { args = { 'claude' } } } },
  { key = '"', mods = 'CTRL|SHIFT', action = wezterm.action.SplitPane { direction = 'Right', command = { args = { 'claude' } } } },
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = wezterm.action_callback(function(window, pane)
      local _, new_pane, _ = window:mux_window():spawn_tab {
        args = { 'claude' },
        cwd = paths[1],
      }
      new_pane:split {
        direction = 'Right',
        args = { 'claude' },
        cwd = paths[2],
      }
    end),
  },
  { key = '?', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '>', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = false } },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  { key = "1", mods = "CTRL|ALT", action = wezterm.action.SendString("cd " .. paths[1] .. "\r") },
  { key = "2", mods = "CTRL|ALT", action = wezterm.action.SendString("cd " .. paths[2] .. "\r") },
  { key = "3", mods = "CTRL|ALT", action = wezterm.action.SendString("cd " .. paths[3] .. "\r") },
}

config.background = {
  	{
    		source = { File = "C:/Users/mason/Documents/wztmbg.jpg" },
    		hsb = { brightness = 0.25 },
	}
}

return config
