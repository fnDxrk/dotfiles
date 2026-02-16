local wezterm = require("wezterm")
local config = wezterm.config_builder()
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

config.use_fancy_tab_bar = false

wezterm.add_to_config_reload_watch_list(wezterm.config_dir .. "/colors")

-- Themes
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
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

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
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
  -- {
  --   key = "r",
  --   mods = "CMD|SHIFT",
  --   action = wezterm.action.ReloadConfiguration,
  -- },
  {
    key = "-",
    mods = "LEADER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "=",
    mods = "LEADER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  -- {
  --   key = "l",
  --   mods = "CTRL",
  --   action = wezterm.action.Multiple({
  --     wezterm.action.ClearScrollback("ScrollbackAndViewport"),
  --     wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
  --   }),
  -- },
}

config.ssh_domains = {
  {
    name = "work-remote",
    remote_address = "filipp.andruschenko.wl.eltex.loc",
    username = "dev",
    multiplexing = "WezTerm",
  },
}

return config
