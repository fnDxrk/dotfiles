local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.use_fancy_tab_bar = false

-- Themes
config.color_scheme = "wallust"
config.font = wezterm.font("JetBrains Mono NL", { weight = "Medium" })
config.font_size = 12
config.window_background_opacity = 0.9
config.hide_tab_bar_if_only_one_tab = true

-- Disable notification
config.window_close_confirmation = "NeverPrompt"

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
}

return config
