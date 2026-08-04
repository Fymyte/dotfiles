# Fuzzy switch between the tabs of the current zellij session.
#
# Launched from a keybind into a floating pane, see the `normal` mode `f` bind
# in config.kdl.
#
# Each fzf line is "<tab_id>\t<name>" but only field 2 is ever displayed
# (--with-nth=2), which also restricts matching to the tab name. Field 1 stays
# reachable through {1} and --accept-nth, which resolve against the
# untransformed line.

# Absolute, so that fzf's preview subprocess can re-exec us regardless of how we
# were invoked (installed on PATH, or run straight from the repo).
self=${BASH_SOURCE[0]}
[[ $self == /* ]] || self=$PWD/$self

# Re-entered by fzf to render the preview of the highlighted tab: the command
# currently running in each of its panes, over its working directory.
#
# The `list-panes` snapshot is inherited through the environment, so drawing a
# preview costs no zellij round trip.
if [[ ${1:-} == --preview ]]; then
  jq -rn \
    --argjson panes "${ZELLIJ_TAB_SWITCHER_PANES:-[]}" \
    --argjson tab "${2:-null}" \
    --arg home "$HOME" \
    --arg dim "$(printf '\033[2m')" \
    --arg bold "$(printf '\033[1m')" \
    --arg accent "$(printf '\033[35m')" \
    --arg reset "$(printf '\033[0m')" '
    def tilde: if startswith($home) then "~" + .[($home | length):] else . end;

    $panes
    | map(select(.tab_id == $tab and .is_suppressed == false and .is_selectable == true))
    | sort_by([.is_floating, .id])
    | if length == 0 then
        $dim + "(no panes)" + $reset
      else
        map(
          (if .is_focused then $accent + "▸ " + $reset else "  " end)
          + $bold + (.title // "?") + $reset
          + (if .is_floating then $dim + " (floating)" + $reset else "" end)
          + (if (.pane_cwd // "") == "" then ""
             else "\n    " + $dim + (.pane_cwd | tilde) + $reset end)
        )
        | join("\n")
      end
  '
  exit 0
fi

if [[ -z ${ZELLIJ_SESSION_NAME:-} ]]; then
  echo "zellij_tab_switcher: not inside a zellij session" >&2
  exit 1
fi

tabs=$(zellij action list-tabs --json)

export ZELLIJ_TAB_SWITCHER_PANES
ZELLIJ_TAB_SWITCHER_PANES=$(zellij action list-panes --json --tab --state --command)

candidates=$(jq -r 'sort_by(.position) | .[] | [(.tab_id | tostring), .name] | @tsv' <<<"$tabs")

# The active tab stays in the list; it is called out in the header so that every
# line remains nothing but a searchable tab name.
current=$(jq -r 'map(select(.active)) | .[0].name // ""' <<<"$tabs")

# Catppuccin Mocha, matching theme.kdl. The preview sits on `crust`, one shade
# below the `base` the rest of the pane uses.
crust="#11111b"
surface0="#313244"
surface2="#585b70"
text="#cdd6f4"

selected=$(fzf \
  --delimiter=$'\t' \
  --with-nth=2 \
  --accept-nth=1 \
  --no-multi \
  --layout=reverse \
  --prompt='tab> ' \
  --header="current: $current" \
  --preview="$self --preview {1}" \
  --preview-window='right,50%,wrap,border-left' \
  --color="preview-bg:$crust,preview-fg:$text,preview-border:$surface0" \
  --color="preview-scrollbar:$surface2" \
  <<<"$candidates") || exit 0

[[ -n $selected ]] || exit 0

# Stable id, so this survives tabs being reordered while fzf is open.
zellij action go-to-tab-by-id "$selected"
