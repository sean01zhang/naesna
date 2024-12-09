+++
title = "Heap Escape Analysis in Go"
date = 2024-12-08T22:49:43-05:00
draft = false
tags=["rough", "golang"]
+++

> **Warning**
> 
> This page is extremely rough and **will contain incorrect code and lack of explanation.**

I want to figure out if my go program is making any allocations to the heap.

```
go test -run none -bench . -benchtime 10s -benchmem
```

Output:
```
goos: darwin
goarch: arm64
pkg: src.naesna.es/aoc/go/2024
cpu: Apple M1 Pro
BenchmarkDay1Part1-10              56686             62211 ns/op           83192 B/op         26 allocs/op
PASS
ok      src.naesna.es/aoc/go/2024       4.405s
```

You can also get a memory profile
```
-memprofile mem.out
```

Then use `go tool pprof` to check allocation space.

```bash
go tool pprof -alloc_space program_name.test mem.out
```

then do `list <funcname>`

Another log of where things are escaping to heap is from is using gcflags:

```
go build -gcflags "-m -m"
```

