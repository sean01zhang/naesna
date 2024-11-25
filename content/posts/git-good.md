+++
title = "Notes on Git"
date = 2024-11-24T22:59:00-05:00
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


> **Related: Git Subcommand Aliases**
> 
> You can also alias git subcommands using your git config. From the git book: https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases

# Git's Config

## Auto Setup Remote

Automatically creates a branch upstream to track this local branch.

```toml
[push]
	autoSetupRemote=true
```
