+++
title = 'Previous Iterations'
date = 2024-11-09
draft = true
tags = ['blog']
+++

Since I keep changing the systems and design of my website, I decided to keep track of it.
## V0 - December 2022
This was when I first acquired the domain name, [naesna.es](https://naesna.es).

It started with plain HTML with no CSS at all.

When I started using org-mode and Emacs, I began exporting them to HTML pages within org-mode for more self-documenting types of writing.

### Screenshots

![The Last Version of my Homepage](v0_naesnaes_homepage.png)

![My Initial Motivations](goals_for_naesnaes.png)

## V1 - September 2023
After getting a job where I was going to work with Next.js, I decided to rewrite my website using that framework.

For theming, I was going through a honeymoon period with Typst. Font is CMU Modern. Layout was inspired by a friend's website. This will be the first and only website I prototype on Figma before I actually implement it.

![](image.png)

## V2 - January 2024
I was unhappy with how difficult it was to continuously deploy my website using Next.js, and decided that it would be better to go back to basics.

I also did not like its' markdown integration for CMS. I found it very limiting.

From Jan 2023 - May 2024, I have been using Emacs and Org mode to take notes.

I also picked up Tailwind.css and was pretty impressed by it's comprehensive styling options.

V2 started as a tailwind + HTML project, and incorporated org mode (exported to HTML) for some notes.

Later on, I would want a system that could automatically generate HTML files based on my org-mode files.

### Screenshots
**Beginning, Temporary Placeholder**
![](v2.0_homepage.png)

**Latest Version, Dark Mode**
![Latest version](v2_latest_homepage.png)
## V3 - November 2024

In May, I switched from Emacs back to neovim. I was tired of going bankrupt with my Emacs configurations, and wanted something easy to navigate around the terminal with.

*Aside: When I learned of the starter configuration, [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), I was blown away by how simple and well-documented it was. It explains every line of the configuration so that I can understand it. As someone who likes understanding something before running it, this was awesome.*

For each of these previous versions, I could not find a solution that could solve all of my needs:
- WYSIWG editor (writing raw markdown/html sucks! have you seen emacs+org-mode?)
	- Math preview
	- Image preview
- Vim Keybinds
- RSS generation
- Easy building to HTML

I discovered Obsidian recently, and have been playing around with Hugo (since my manager recommended it). This might be the most elite setup I have had to date. 