+++
title = "My Obsidian Setup"
date = 2024-11-30T15:26:10-05:00
draft = false
tags = ["My Config"]
+++

Obsidian is great. Besides its' wonderful Knowledge Management features, it is insanely great for just this one thing: Feature-rich WYSIWYG markdown file editing.

For writing things slightly less trivial than a few words in a file (like images, math, or links), it would be really nice to **see** what it looks like without having another pane open to preview it. You know, real estate is pretty expensive these days!

Here is a guide to my configuration of my obsidian workspace.

> **Newb Alert**
> 
> I am new to obsidian! The purpose of this post is more of an informal show-and-tell rather than an authoritative guide. Feel free to share with me how you use obsidian :)

## Copying

My obsidian configuration is intentionally checked-in to my git repo. Feel free to copy this as a starting point for your own configuration!

- [github.com/sean01zhang/naesna](https://github.com/sean01zhang/naesna/tree/main)
	- `.obsidian.vimrc` contains some configurations for my obisidian `vim` config.
	- `.obsidian` contains the plugins I use and other general settings
	- `templates.obsidian` contains some templates I use to help bootstrap a new pages on my website.

## Settings

Honestly, I don't really remember what I set. 
### Editor

Here are a few things I probably set if they aren't already enabled:

- Default Editing Mode: Live Preview
- Show Line Numbers: Yes
- Show Indent Guides: Yes
- Spellcheck: Yes
- Vim motions: Of course

### Keybinds

As a `vim` motions fan, there were a few obsidian keybinds that interfered with my vim motions. I believe it was either `C-d` or `C-u`. If you use Windows or Linux, make sure you check this!

### Templates

For my website, I have a templates folder called `templates.obsidian`. In my Obsidian settings, I set the templates folder to that.

## Plugins

Obsidian is *almost* the perfect markdown editor. My extra plug-ins are mainly to plug the feature gaps of vim motions in obsidian.

### Relative Line Numbers

**[Link](obsidian://show-plugin?id=obsidian-relative-line-numbers) to plugin**

Relative line numbers is self-explanatory. When using vim, it is very helpful to know how far lines are relative to your current one so that it is easier to jump to them (i.e. `13k` goes up 13 lines).
### Vimrc Support

**[Link](obsidian://show-plugin?id=obsidian-vimrc-support) to plugin**

Vimrc support adds a few extra features that are missing to obsidian's vim motions. Here is my [.vimrc file](https://github.com/sean01zhang/naesna/blob/main/.obsidian.vimrc). And here's a preview:

```vimrc
" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Yank to system clipboard
set clipboard=unnamed

" jk/kj sets you back to normal mode
inoremap jk <Esc>
inoremap kj <Esc>

" Chording
unmap <Space>
exmap rclick obcommand editor:context-menu
nnoremap <Space>cm :rclick
```
