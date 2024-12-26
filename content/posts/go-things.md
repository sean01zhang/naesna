+++
title = "idfk"
date = 2024-12-15T15:50:18-05:00
draft = true
+++

Here are a few things that I should remember more often when developing go code.
## Interface Checks

If I am writing a module type, maybe called `MyStruct` and it *should* implement some 
interface, maybe `io.Reader`.

```go
var _ io.Reader = (*MyStruct)(nil)
```

This should be used when there are no static type conversions in
## Embedding

### Interfaces

```go

type Reader interface { ... }

type Closer interface { ... }

// Embedded
type ReadCloser interface {
	Reader
	Closer
}
```

### Structs

```

```

## What does defer do on a low level


# CGO

C. 

embed headers

