+++
title = "My Ghostty Config"
date = 2026-07-10T11:47:26-04:00
draft = false
+++

Coming from `tmux` + iTerm, I thought I'd give `ghostty` a try. I've made it as close to my tmux config as possible.

```
window-padding-x = 10
window-padding-y = 10

window-decoration = auto

macos-option-as-alt = true

command = /opt/homebrew/bin/fish

background = 050505
background-opacity = 0.95
background-blur-radius = 5

# Quick Terminal
quick-terminal-position = top
quick-terminal-animation-duration = 0.1

# Allow remote applications to write to your system clipboard
clipboard-write = allow

# Ensure inactive panes don't dim
unfocused-split-opacity = 0.9


# ---------
# Keybinds
# ---------

# Split panes using custom keys (v for vertical split, s for horizontal/down).
keybind = ctrl+b>v=new_split:right
keybind = ctrl+b>s=new_split:down

# Switch panes using Alt-arrow without prefix.
keybind = alt+left=goto_split:left
keybind = alt+right=goto_split:right
keybind = alt+up=goto_split:top
keybind = alt+down=goto_split:bottom

# Equalize pane sizes.
keybind = ctrl+b>==equalize_splits

# Quick Terminal toggle.
keybind = global:cmd+grave_accent=toggle_quick_terminal

# Rename tab.
keybind = ctrl+b>,=prompt_surface_title
```
