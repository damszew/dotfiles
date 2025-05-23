-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

config.check_for_updates = false
config.show_update_window = false

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Dracula (Gogh)'
config.color_scheme = 'Dracula (Official)'
config.hide_tab_bar_if_only_one_tab = true

-- Disable lingatures
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Use ubuntu default font
-- config.font = wezterm.font 'Ubuntu Mono'
-- config.font_size = 13.0
-- config.font = wezterm.font_with_fallback {
--   { family="CommitMono", weight=450, style="Normal"},
--   { family="CommitMono", weight=450, style="Italic"},
--   { family="CommitMono", weight="Bold", style="Normal"},
--   { family="CommitMono", weight="Bold", style="Italic"},
-- }

config.keys = {
  -- Change QuickCopyMode due to conflicting key-binding with 1Password
  {
    key = '>',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelect,
  },
}

-- and finally, return the configuration to wezterm
return config

