+++
title = "Boilerplate for Creating a Go CLI"
date = 2024-12-08T23:05:42-05:00
draft = true
tags = ["golang"]
+++

I sometimes write something in golang and I need it to interface with the terminal in some non-trivial way (i.e. not `./myprogram`).

So, here is a way to create a `go` CLI using cobra in as much of an idiomatic way as possible.

## Requirements

- We should not use any global variables
- Minimize coupling
- Allow for flags and subcommands
- Allow this command to be installed as a subcommand
- Minimize reliance on calling `init` functions, as these cause nondeterminism for testing.

## The file structure

[As recommended by cobra](https://cobra.dev/#getting-started), we should put all the CLI files under a `cmd/` folder. We can probably have the root command be called `root`.

**Folder Structure**
```
myproject/
  some-module/
	thing.go
  cmd/
    root.go
    sub1.go
    sub2.go
  main.go
```

**main.go**
```go
package main

import (
	"src.naesna.es/aoc/go/cmd"
)

func main() {
	cmd.Execute()
}
```

**cmd/root.go**
```



```


## Testability