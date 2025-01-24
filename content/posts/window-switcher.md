+++
title = "Why I Built Window Switcher"
date = 2025-01-23T19:04:40-05:00
draft = false
tags = ['window-switcher']
+++

Since finishing my last internship, I've missed having massive monitors at work. No longer could I have two windows in split view without sacrificing content space.

This meant that I had many apps occupying one desktop at once. However, as a certified non-minimalist^TM, I have too many windows open. For example, I have multiple instances of Firefox open (one for each profile), multiple instances of Finder with different folders open, and if I wasn't a `vim` user, I would have many different instances of my favourite GUI-based code editor open (one for each repository I was working on).

So, I needed a solution so that I could quickly switch to the windows I want.

**Spotlight**

Spotlight (and other derivatives which may be powered by AI) are very powerful. However, you can only search for **Applications, not *Windows*** in an app. Thus, this tool becomes unreliable as soon as your 1:1 mapping between apps and windows breaks down.

**Cmd-tab**

Command-tab is deficient since you have to linearly scan through your apps to get the one you want. It is good but suffers the same problem as Spotlight. I need the granularity of windows.

**Alt-tab**

Alt-tab brings proper window switching to mac and it's free! It supports multiple different UI styles, but unfortunately [development of a search variant stalled out](https://github.com/lwouis/alt-tab-macos/pull/2278).

I thought about contributing to this project, but I didn't have the confidence to fully understand the workings of such a big project to start on this. Furthermore, the user experience is quite different from quickly switching between windows and searching for windows.

**Fine, I'll make it myself**

Surely it wouldn't be hard for someone with 0 hours of experience in macOS development to make a Mac application that integrates deeply with the OS? So I got to work experimenting with this over my holiday break. It turned out to be a really challenging experience, and I still am not confident in my ability to develop for macOS. However, I *do* have a working application.

> **Aside**
> 
> Well, with the exception that the notarization service is taking it's sweet time notarizing my signed binary (yes, I paid $130 for this great experience).
>
> By the way, there is this [forum thread about this issue](https://forums.developer.apple.com/forums/thread/739751). I suspect my issues have to do with me doing this for the first time ever, but I filed a support ticket with Apple anyways.

## Conclusion

I made it! I've also created my own tap so it's also available on `brew`.
The project page is here: [src.naesna.es/window-switcher](https://src.naesna.es/window-switcher). If you like it, please give it a star!

![Window Switcher Demo](demo.gif)

I will also be making a few follow-up posts about some interesting discoveries when making this app.