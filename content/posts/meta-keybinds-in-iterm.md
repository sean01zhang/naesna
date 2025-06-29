+++
title = "Freeing alt keys in your terminal"
date = 2025-06-29T17:23:51-04:00
draft = false
tags = ["My Config"]
+++

In my terminal, I have `Option-C` bound to fzf's fuzzy cd. However, when I press this, I get `ç` typed instead of triggering the keybind. I thought this was a system-wide issue with my US keyboard, but a more elegant solution lies inside of your terminal's settings!

# Solution

Here is the fix for few terminal emulators that I know of.

## Terminal.app

Go to `Settings > Profiles`,  and check the box, "Use Option as Meta key".
## Ghostyy

By default, this behaviour is sane (who would want to input unicode??). If you do want to toggle this setting, setting the config option [`macos-option-as-alt`](https://ghostty.org/docs/config/reference#macos-option-as-alt) to `false` will allow you to input special unicode characters with alt.
## iTerm2

Go to `Settings > Profiles`, and click the dropdown next to `Left option (⌥) key:` and select "Esc+". The same can be done for the right option key if needed. Keeping it normal would still allow you to input unicode into the terminal.

