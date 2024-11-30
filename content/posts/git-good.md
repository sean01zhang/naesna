+++
title = "Notes on Git"
date = 2024-11-30T15:46:00
draft = false
tags = ["My Config", "git"]
+++

Since `git` is a massive tool, I want to showcase some things I like using!

I assume the reader has some familiarity with Git in this article. For those new to Git or
want a good refresher, I recommend the [git book](https://git-scm.com/book/en/v2). 

# Git's Tools

> **Aside: Writing Commit Messages**
> 
> Writing good commit messages is important, even if you work on feature branches!
> It's good to get into the habit of writing helpful commit messages, 
> especially if someone later wants to go back and traverse the commit history.
>
> A personal way that I use commit history when reviewing PRs on feature branches is that I sometimes look at commit-level diffs if a PR is very large.
> 
> A good read is [Conventional Commits](https://conventionalcommits.org), even if you don't fully implement their spec.
> Personally, I have adopted `fix`, `feat`, and `style`, since it's very little overhead.

## Worktrees

Docs: [git-worktree](https://git-scm.com/docs/git-worktree)

Have you ever tried multitasking with multiple work-in-progress branches in a repo and cloned your repo again to deal with this problem? I certainly have, until a coworker introduced me to worktrees!

Compared to cloning the repo, they are a lot faster to create since their `.git` file is a link back to the main worktree. Here are a few examples:

**New Worktree + New branch with `$(basename <path>)` as branch name**
```bash
# This creates a new worktree at the specific path and 
# checks out a new branch with the basename of the path.
# In this case, the new branch is "worktree"
git worktree add path/to/worktree
```

**New Worktree + New branch with `<name>` as branch name**
```bash
# This creates a new worktree at the specific path and
# checks out a branch with the specified name.
git worktree add path/to/worktree -b <name>
```

**Remove Worktree**
```bash
git worktree remove path/to/worktree
```

I like putting my worktrees in a `.worktree` folder within my repo, though there is no arbitrary limitation on where this worktree is not allowed to live.

## Amending Last Commit

`git commit --amend`

This is good for:
1. Modifying your commit message
2. Adding new changes that you might have missed (like a typo, or a minor fix)

> **Note:** If you want to synchronize with a remote branch, you will need to force push it upstream!
## Rebasing

While writing this section, I found this section of the git-book very useful (so useful that I question the value of this section). It's worth a read: https://git-scm.com/book/en/v2/Git-Branching-Rebasing

Rebasing is great, as it leads to much more readable commit histories. In this section, a few playbooks that involve rebasing are outlined.
#### Making a temporary change & removing it from your commit tree

Suppose you want to experiment with something, and you must make a commit and push it upstream to test it. Maybe you need to make a temporary commit to make it easier to experiment and test code. Once you're done, how do you remove this commit that has been buried in your commit history?

`git rebase -i HEAD^<N>`

By interactively rebasing on a certain number of commits behind your head reference (assuming your head reference is at the same place as your branch), I will be taken to an
open editor where I can pick and drop commits!
#### Working on a feature branch that depends on another feature branch

I want to break up my changes into multiple branches for review. For example, I have branch `featureA` and branch `featureB`, which `featureB` builds upon `featureA`.

Suppose `featureA` gets rebased to `main`, and a few commits occur on the `main` branch before `featureB` is ready to be rebased into main.

> **Note:** 
> 
> I realize that the git book has said, 
> 
> > Do not rebase commits that exist outside your repository and **that people may have based work on**.
> 
> However, you would only anguish yourself, and that's ok.

When it comes time to rebase `featureB`, things might get complicated. If this cannot rebase automatically, do not fear!

You will need to identify which commits are unique to `featureB` and drop the work that is not unique to `featureB`.

## Pushing a Locally Created Branch Upstream

Have you ever tried pushing a branch you created locally upstream and gotten this message?

```
fatal: The current branch asdf has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin asdf

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.
```

One way to fix this is to set your `git` config to [automatically setup remote](#auto-setup-remote), but maybe you don't want to do this.

However, to type the full command to set upstream can get quite cumbersome. Especially if you have very long branch names. One branchname-agnostic way of pushing to remote and setting your upstream branch name to your current local branch name is:

```fish
git push -u origin HEAD
```

You can even alias it to something quick!
# Shell Aliases for Git

> **Related: Git Subcommand Aliases**
> 
> You can also alias git subcommands using your git config. From the git book: https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases

## Switching Branches

First of all, thank you to [Allen (algao1.github.io/blurb)](https://algao1.github.io/blurb) for this wonderful alias for fuzzy switching branches.

Note: This alias requires [`fzf`](https://github.com/junegunn/fzf).

**Bash**
```bash
alias gch='git checkout $(git for-each-ref --format="%(refname:short)" refs/heads/ | fzf)'
```

**Fish**
```fish
alias gch 'git checkout $(git for-each-ref --format="%(refname:short)" refs/heads/ | fzf)'
```

## Force Pushing

As a serial `git` history rewriter, I oftentimes have to force-push to my remote branch to erase my tracks.

**Bash**
```bash
alias gpf="git push --force"
```

**Fish**
```fish
alias gpf "git push --force"
```

## Navigating to Common Repos

At work, I usually frequent 2-3 repos. I usually store my `git` repos in `~/documents/git` or `~/git`, so this is not *necessarily required*. However, this alias has found itself more than just a shortcut to doing a quick `cd` from my home dir.

For example, 
- I use it a lot to backtrack to the root of the repository. 
- I use it to switch repositories (since I can't `fzf` my way out of there)

```fish
# for navigating to my website repo
alias naesna "cd ~/git/naesna"
```

# Git's Config

## Auto Setup Remote

Automatically creates a branch upstream to track this local branch.

```toml
[push]
	autoSetupRemote=true
```

