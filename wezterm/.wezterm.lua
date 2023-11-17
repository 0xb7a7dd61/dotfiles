-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.window_background_opacity = 0.6
config.text_background_opacity = 0.7

-- config.color_scheme = "Batman"

config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.25,
  brightness = 1.25,
}

config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font("FiraCode Nerd Font", { weight = 450 })
config.font_size = 12.2

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.keys = {
  -- Disable <C-l> so it can be used by nvim to pop up the integrated terminal
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Disable C-S-Left and C-S-Right so they can be used by tmux to switch between panes
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Open tmux-sessionizer without having a tmux server running
  {
    key = "f",
    mods = "CTRL",
    action = wezterm.action.Multiple({
      wezterm.action.SendString("~/.local/bin/tmux-sessionizer"),
      wezterm.action.SendKey({ key = "Enter" }),
    }),
  },
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action({ SendString = "\x1bb" }),
  },
  -- Make Option-Right equivalent to Alt-f; forward-word
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action({ SendString = "\x1bf" }),
  },
}

-- and finally, return the configuration to wezterm
return config
