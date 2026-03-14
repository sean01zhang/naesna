+++
title = "Go: Directional Channel Types"
date = 2026-03-13T21:46:14-04:00
draft = false
tags = ["golang"]
+++

Golang's concurrency features are super easy to understand and use. One of the key features is a **channel**, used to share data across different goroutines (think of this as a lightweight user-space pthread). 

You have built a system on `go` that is super performant and *web scale*. One day, you push a change and now your service is crash-looping. You check the logs, and you realize that one of your goroutines sent on a closed channel, and your program panicked.

Now, you have hours of debugging ahead of you as you dive into your codebase and look for which channel was accidentally closed. How could you have avoided this in the first place?

## Channel Direction Types

As a go readability expert, it is known that receivers should not close channels. But this can actually be enforced at compile-time with **directional channels**. Receive only channels cannot be closed, and will result in a compilation error:

```go
func Receiver[T any](data <-chan T) {
	foo := <-data	
	
	// This will not compile!
	close(data)	
}
```

*However*, directional channels doesn't stop a sender from closing a channel other senders are sending to.

## Additional Reading

- [Go By Example: Channels](https://gobyexample.com/channels)
- [Go By Example: Channel Direction Types](https://gobyexample.com/channel-directions)
- [Go spec: `Close`](https://go.dev/ref/spec#Close)


