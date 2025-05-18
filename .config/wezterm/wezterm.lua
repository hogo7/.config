local wezterm = require("wezterm")
local config = {}
print("loaded")
config.window_background_opacity = 0.95
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")
config.font_size = 14
config.enable_tab_bar = false
config.font_shaper = "Harfbuzz"
config.bidi_enabled = true
config.bidi_direction = "AutoLeftToRight"
return config
