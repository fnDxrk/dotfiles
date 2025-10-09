local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.use_fancy_tab_bar = false

wezterm.add_to_config_reload_watch_list(wezterm.config_dir .. "/colors")

-- Themes
config.color_scheme = "matugen"
config.font = wezterm.font("JetBrains Mono NL", { weight = "Medium" })
config.font_size = 12
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true

-- Disable notification
config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
  left = "10px",
  right = "10px",
  top = "10px",
  bottom = "10px",
}

config.keys = {
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = wezterm.action.ReloadConfiguration,
  },
}

return config
