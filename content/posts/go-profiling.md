+++
title = "How do I make my Go program faster?"
date = 2024-11-14T20:14:50-05:00
draft = true
tags = ["golang"]
+++

As a new developer (not just in golang but in general), I do not have extensive experience in making high-performance programs. So, I want to document my journey into trying to make go programs that run fast!

I use go extensively at work, but I do not get to write
performance critical code, so I want to use this as an
opportunity to share what I learn from this dive.

# Testing Primer

To see the full potential of what you can do with `go test`, do:

```bash
# for flags that control test execution
go help testflag
# for flags related to go test command
go help test
```

Some things I already know about:
- The `-v` flag gives you information about test cases
- To specify that you want to test all test files in this directory (including it's subdirectories), use `go test ./...`
- To get coverage:
	- `-cover` gives you a file-by-file coverage percentage.
	- `-coverprofile cover.out` provides a report on line-by-line coverage.

The above is really useful when I want to build unit tests for the code I write. I can run all tests under the `internal` directory, get tests and subtest outcomes, and get information about what my unit tests did not cover. Putting it all together:

```bash
go test ./... -v -coverprofile=cover.out
```

# Testing for Performance

The above section covers some of my experience with the `go test` command for unit testing at work. This section will document some of the tools available within `go test` to help write performant go code.

To start, let's take some code
```go
package main

func main() {

}


```

