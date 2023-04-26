local wt = require 'wezterm'

local config = wt.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.font = wt.font 'Cascadia Code'
config.alternate_buffer_wheel_scroll_speed = 2
config.animation_fps = 30
config.audible_bell = 'Disabled'

config.enable_kitty_keyboard = true

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true

config.term = 'wezterm'
config.window_padding = {
  bottom = '5pt',
  top = '5pt',
}

return config
