local wt = require 'wezterm'
local act = wt.action
-- local cb = wt.action_callback

-- Smart Splits: switch between wezterm and nvim splits without effort
local ss = wt.plugin.require 'https://github.com/mrjones2014/smart-splits.nvim'

local config = wt.config_builder()

config.front_end = 'WebGpu'
local gpus = wt.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[0]

config.color_scheme = 'Catppuccin Mocha'
local colors = wt.color.get_builtin_schemes()['catppuccin-mocha']
-- Use Catppuccin color palette for command palette as well
config.command_palette_bg_color = '#181825'
config.command_palette_bg_color = colors.ansi
config.command_palette_fg_color = colors.selection_fg

-- Font
config.font = wt.font 'Cascadia Code'
config.font_size = 13
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false

-- Cursor and animation
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 500
config.animation_fps = 30
config.alternate_buffer_wheel_scroll_speed = 2
config.scrollback_lines = 900000
config.audible_bell = 'Disabled'
-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 10000

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end
wt.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  if tab.is_active then
    return {
      -- { Background = { Color = 'blue' } },
      { Text = '| ' .. title .. ' |' },
    }
  end
  return '| ' .. title .. ' |'
end)

config.term = 'wezterm'

config.window_padding = {
  bottom = '5pt',
  top = '5pt',
}

-- Show which key table is active in the status area
wt.on('update-status', function(window, _)
  local leader
  if window:leader_is_active() then
    leader = 'LEADER'
  end

  local table_name = window:active_key_table()
  if table_name then
    table_name = 'TABLE: ' .. table_name
  end
  window:set_right_status(leader or table_name or '')
end)

config.leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 2000 }

local function key_with_alternative(target_key_table, keys)
  local insert_alternate = function(result, opts)
    local mods = opts.mods

    if type(mods) == 'table' then
      for _, v in ipairs(mods) do
        table.insert(result, {
          key = opts.key,
          action = opts.action,
          mods = v,
        })
      end
    else
      table.insert(result, {
        key = opts.key,
        action = opts.action,
        mods = mods,
      })
    end
  end

  for _, v in ipairs(keys) do
    insert_alternate(target_key_table, v)
  end

  return target_key_table
end

config.keys = {
  { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },
  { key = '!', mods = 'CTRL', action = act.ActivateTab(0) },
  { key = '!', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
  { key = '#', mods = 'CTRL', action = act.ActivateTab(2) },
  { key = '#', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
  { key = '$', mods = 'CTRL', action = act.ActivateTab(3) },
  { key = '$', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
  { key = '%', mods = 'CTRL', action = act.ActivateTab(4) },
  { key = '%', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
  { key = '&', mods = 'CTRL', action = act.ActivateTab(6) },
  { key = '&', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
  { key = '(', mods = 'CTRL', action = act.ActivateTab(-1) },
  { key = '(', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
  { key = ')', mods = 'CTRL', action = act.ResetFontSize },
  { key = ')', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
  { key = '*', mods = 'CTRL', action = act.ActivateTab(7) },
  { key = '*', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '+', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '-', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },
  { key = '0', mods = 'SHIFT|CTRL', action = act.ResetFontSize },
  { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '=', mods = 'SHIFT|CTRL', action = act.IncreaseFontSize },
  { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
  { key = '@', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
  { key = 'C', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'F', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'K', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'M', mods = 'SHIFT|CTRL', action = act.Hide },
  { key = 'N', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'P', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  { key = 'R', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  {
    key = 'U',
    mods = 'CTRL',
    action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' },
  },
  {
    key = 'U',
    mods = 'SHIFT|CTRL',
    action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' },
  },
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'V', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'X', mods = 'CTRL', action = act.ActivateCopyMode },
  { key = 'X', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'Z', mods = 'CTRL', action = act.TogglePaneZoomState },
  { key = 'Z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
  { key = '[', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
  { key = '^', mods = 'CTRL', action = act.ActivateTab(5) },
  { key = '^', mods = 'SHIFT|CTRL', action = act.ActivateTab(5) },
  { key = '_', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '_', mods = 'SHIFT|CTRL', action = act.DecreaseFontSize },
  { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
  { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'f', mods = 'SUPER', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'k', mods = 'SHIFT|CTRL', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'k', mods = 'SUPER', action = act.ClearScrollback 'ScrollbackOnly' },
  { key = 'm', mods = 'SHIFT|CTRL', action = act.Hide },
  { key = 'm', mods = 'SUPER', action = act.Hide },
  { key = 'n', mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
  { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
  { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = 'r', mods = 'SUPER', action = act.ReloadConfiguration },
  {
    key = 'u',
    mods = 'SHIFT|CTRL',
    action = act.CharSelect { copy_on_select = true, copy_to = 'ClipboardAndPrimarySelection' },
  },
  { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
  { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
  { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
  { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
  { key = '{', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
  { key = '{', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(-1) },
  { key = '}', mods = 'SUPER', action = act.ActivateTabRelative(1) },
  { key = '}', mods = 'SHIFT|SUPER', action = act.ActivateTabRelative(1) },
  { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageUp', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'PageUp', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
  { key = 'PageDown', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'PageDown', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'LeftArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'RightArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'UpArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ActivatePaneDirection 'Down' },
  { key = 'DownArrow', mods = 'SHIFT|ALT|CTRL', action = act.AdjustPaneSize { 'Down', 1 } },
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
  { key = 'Insert', mods = 'CTRL', action = act.CopyTo 'PrimarySelection' },
  { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
  { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
}

config.keys = key_with_alternative(config.keys or {}, {
  { key = 's', mods = { 'LEADER', 'LEADER|CTRL' }, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = { 'LEADER', 'LEADER|CTRL' }, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = { 'LEADER', 'LEADER|CTRL' }, action = act.ActivateKeyTable { name = 'wincmd', one_shot = true } },

  { key = 't', mods = { 'LEADER', 'LEADER|CTRL' }, action = act.ActivateKeyTable { name = 'tabcmd', one_shot = true } },

  {
    key = 'r',
    mods = { 'LEADER', 'LEADER|CTRL' },
    action = act.ActivateKeyTable { name = 'resizecmd', one_shot = false },
  },

  { key = 'q', mods = { 'LEADER', 'LEADER|CTRL' }, action = act.CloseCurrentTab { confirm = true } },
})

config.key_tables = {
  copy_mode = {
    { key = 'Tab', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    { key = 'Tab', mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'MoveToStartOfNextLine' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'Space', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = '$', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = ',', mods = 'NONE', action = act.CopyMode 'JumpReverse' },
    { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
    { key = ';', mods = 'NONE', action = act.CopyMode 'JumpAgain' },
    { key = 'F', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = false } } },
    { key = 'F', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
    { key = 'G', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H', mods = 'NONE', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'H', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'L', mods = 'NONE', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'L', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'M', mods = 'NONE', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'M', mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'O', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'O', mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'T', mods = 'NONE', action = act.CopyMode { JumpBackward = { prev_char = true } } },
    { key = 'T', mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
    { key = 'V', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = '^', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b', mods = 'CTRL', action = act.CopyMode 'PageUp' },
    { key = 'c', mods = 'CTRL', action = act.CopyMode 'Close' },
    { key = 'd', mods = 'CTRL', action = act.CopyMode { MoveByPage = 0.5 } },
    { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },
    { key = 'f', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = false } } },
    { key = 'f', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
    { key = 'f', mods = 'CTRL', action = act.CopyMode 'PageDown' },
    { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
    { key = 'g', mods = 'CTRL', action = act.CopyMode 'Close' },
    { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
    { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    { key = 'm', mods = 'ALT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'o', mods = 'NONE', action = act.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 't', mods = 'NONE', action = act.CopyMode { JumpForward = { prev_char = true } } },
    { key = 'u', mods = 'CTRL', action = act.CopyMode { MoveByPage = -0.5 } },
    { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },
    { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
    {
      key = 'y',
      mods = 'NONE',
      action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } },
    },
    { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PageUp' },
    { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'PageDown' },
    { key = 'End', mods = 'NONE', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = 'Home', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
    { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
    { key = 'LeftArrow', mods = 'ALT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },
    { key = 'RightArrow', mods = 'ALT', action = act.CopyMode 'MoveForwardWord' },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
  },

  search_mode = {
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
    { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
  },
}

config.key_tables.wincmd = key_with_alternative(config.key_tables.wincmd or {}, {
  { key = 'h', mods = { 'NONE', 'CTRL' }, action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = { 'NONE', 'CTRL' }, action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = { 'NONE', 'CTRL' }, action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = { 'NONE', 'CTRL' }, action = act.ActivatePaneDirection 'Down' },

  { key = 's', mods = { 'NONE', 'CTRL' }, action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = { 'NONE', 'CTRL' }, action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
})

config.key_tables.tabcmd = key_with_alternative(config.key_tables.tabcmd or {}, {
  { key = 'h', mods = { 'NONE', 'CTRL' }, action = act.ActivateTabRelative(-1) },
  { key = 'p', mods = { 'NONE', 'CTRL' }, action = act.ActivateTabRelative(-1) },

  { key = 'l', mods = { 'NONE', 'CTRL' }, action = act.ActivateTabRelative(1) },
  { key = 'n', mods = { 'NONE', 'CTRL' }, action = act.ActivateTabRelative(1) },

  { key = '1', action = act.ActivateTab(0) },
  { key = '2', action = act.ActivateTab(1) },
  { key = '3', action = act.ActivateTab(2) },
  { key = '4', action = act.ActivateTab(3) },
  { key = '5', action = act.ActivateTab(4) },
  { key = '6', action = act.ActivateTab(5) },
  { key = '7', action = act.ActivateTab(6) },
  { key = '8', action = act.ActivateTab(7) },
  { key = '9', action = act.ActivateTab(8) },

  { key = 'o', mods = { 'NONE', 'CTRL' }, action = act.SpawnTab 'CurrentPaneDomain' },
})

config.key_tables.resizecmd = key_with_alternative(config.key_tables.resizecmd or {}, {
  { key = 'Escape', action = act.PopKeyTable },
  { key = 'h', mods = { 'NONE', 'CTRL' }, action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'j', mods = { 'NONE', 'CTRL' }, action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'k', mods = { 'NONE', 'CTRL' }, action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'l', mods = { 'NONE', 'CTRL' }, action = act.AdjustPaneSize { 'Right', 5 } },
})

config.ssh_domains = {
  {
    name = 'snorlax',
    remote_address = 'snorlax',
    username = 'pguillaume',
  },
}

config.serial_ports = {
  {
    name = 'serial_0',
    port = '/dev/ttyUSB0',
    baud = 115200,
  },
}

return config
