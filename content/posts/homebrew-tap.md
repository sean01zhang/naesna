+++
title = "Make a New Homebrew Tap"
date = 2025-04-09T11:12:08-05:00
draft = false
tags=["homebrew", "window-switcher"]
+++

The documentation from the [homebrew docs](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap) is sufficient to creating a new tap. I will add a bit of commentary in addition to the above to discuss the design choices I made when making my homebrew tap & cask for window-switcher.

First of all, I chose to create a repository on GitHub, since that is where my code is stored. Some bikeshedding - what should I name my tap?

> Note: [GitHub Only] The brew.sh docs recommended adding a prefix to your homebrew tap repo with `homebrew-` if you want users to take advantage of the `brew tap` comamnd. 
> However, when others install or tap from your repo, they do not include the prefix. For example, the repo `github.com/sean01zhang/homebrew-formulae` can be accessed by executing `brew tap sean01zhang/formulae`. 

My opinion is that since the tap contains formulas (and casks!), an apt name for the repo is "formulae". This seems to be a pretty common pattern. This tap can be used for other packages (though you don't have to) as well so naming it something package-specific may brew trouble for you in the future if you ever want to add another package to brew, as it may cause confusion.

## Repository Contents

A good starting point can be from the template that you get from the `brew tap-new` command.

Structure:
- Your formulas go under a directory called `Formula`. See [homebrew/core](https://github.com/homebrew/homebrew-core) for examples.
- Your casks go under a directory called `Casks`. See [homebrew/cask](https://github.com/homebrew/homebrew-cask) for an example cask tap.

If you do not have any formulas / casks, you do not need to include the empty folder. Note: Despite homebrew containing a different tap for formulae and casks, you can keep them in one repo.

### Cask File Contents

The brew docs are very well-documented. Here is the documentation for cask file contents: https://docs.brew.sh/Cask-Cookbook

To help you get an idea of what you want, here is an example from `window-switcher.rb`. It is a cask with no dependencies, and basically downloads the latest release from it's Github repository.

```ruby
cask "window-switcher" do
  version "0.3.3"
  sha256 "6c707f4d615d60e23ff2ce477e3f178f810bf12bd451084686982ab8c606252f"

  url "https://github.com/sean01zhang/window-switcher/releases/download/v#{version}/window-switcher-v#{version}.zip"
  name "window-switcher"
  desc "Simple searchable desktop window switcher"
  homepage "https://github.com/sean01zhang/window-switcher"

  livecheck do
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "window-switcher.app"
end
```

Here are some notes about some of the more interesting parts of this cask file:

1. Livecheck is an important parameter used by [`brew livecheck`](https://docs.brew.sh/Brew-Livecheck). This is primarily for tap maintainers, to assist with updating their cask files when new releases ship. See [Bump Workflow](#bump-workflow) to see how this works with automation. As for other examples of how to write the livecheck block, see the [docs](https://docs.brew.sh/Brew-Livecheck#example-livecheck-blocks).
2. If you want to update your cask with a new release, you must update the contents of the cask file with the new package hash, url, and version. If you do not have automation that checks for package updates, this will require manual work.

## Bump Workflow

If this tap is maintained on Github, bumping package versions can be automated using Github workflows. Homebrew/cask has a good reference workflow [here](https://github.com/Homebrew/homebrew-cask/blob/master/.github/workflows/autobump.yml).

You may notice that this workflow is calling other workflows. The one of importance is [Homebrew/actions/bump-packages](https://github.com/Homebrew/actions/tree/master/bump-packages).

This is my specific workflow. Casks and packages that you want to bump must be specified as an argument or else it will not be bumped.

```yml
name: Bump Packages

on:
  workflow_dispatch:
  schedule:
    - cron: "0 3 * * *"

jobs:
  autobump:
    runs-on: macos-latest
    permissions:
      contents: write
      pull-requests: write
    steps:
      - name: Tap formulae
        run: |
          brew tap sean01zhang/formulae
      - name: Bump packages
        uses: Homebrew/actions/bump-packages@master
        with:
          token: ${{secrets.GITHUB_TOKEN}}
          casks: >
            sean01zhang/formulae/window-switcher
          fork: false
```

