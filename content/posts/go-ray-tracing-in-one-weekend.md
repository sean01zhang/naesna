+++
title = "Ray Tracing in One Weekend using Go"
date = 2024-11-15T19:36:55-05:00
draft = true
tags = ["golang"]
+++
# Introduction

Yeah, so I've done this [before](archive/in-one-weekend), but in C++. I did this almost two years ago, but I would like to see how easy it would be to do it in go.

I will also try to do this from memory only -- so let's see how well this goes!

## Why am I doing this?

I wanted to write a post about profiling and improving performance of my go programs, but I haven't written anything yet. So the most trivial thing I can write off of the top of my memory is a brute-force ray tracer.

# What I remember

Please be warned, this may not paint a complete picture (no pun intended).

- We should have a camera
- We shoot rays out of this camera and see what objects we intersect in our world, which contains objects.
	- From those objects, we shoot out more rays and average the light coming in.
	- We do this recursively

# Ray Intersection

To start, let's get some object intersection working, meaning we will also need to get image output and some objects. We should:

- Create a shapes package
- Create a vector package
- Create a tracer object

## Shapes


```go
package vector

import (
	"math"
)

// Vec3 is a 3D vector with 3 components.
type Vec3 struct {
	X float64
	Y float64
	Z float64
}
type Point = Vec3

// Add adds the three components of two vectors together.
func (v0 *Vec3) Add(v1 *Vec3) Vec3 {
	return Vec3{
		X: v0.X + v1.X,
		Y: v0.Y + v1.Y,
		Z: v0.Z + v1.Z,
	}
}

// Scalar multiplies each component of Vec3 by a
// scalar value.
func (v0 *Vec3) Scalar(c float64) {
	return Vec3{
		X: c * v0.X,
		Y: c * v0.Y,
		Z: c * v0.Z,
	}
}

// Neg multiplies the three components of the two vectors 
// by -1.
func (v0 *Vec3) Neg() Vec3 {
	return v0.Scalar(-1)
}

// Sub subtracts v1 from this vector.
func (v0 *Vec3) Sub(v1 *Vec3) Vec3 {
	return v0.Add(v1.Neg())
}

// Len2 returns the squared length of a vector.
func (v0 *Vec3) Len2() {
	return v0.Dot(v0)
}

// Len returns the length of a vector
func (v0 *Vec3) Len() {
	return math.Sqrt(v0.Len2())
}

// Unit returns a unit vector.
func (v0 *Vec3) Unit() Vec3 {
	return v0.Scalar(1.0 / v0.Len())
}

//
func (v0 *Vec3) Dot(v1 *Vec3) float64 {
	return v0.X * v1.X + v0.Y * v1.Y + v0.Z * v1.Z
}

func (v0 *Vec3) Cross() Vec3 {

}

```

```go
package geometry3d

type Shape interface {
	Hit(Ray r)
}

type Ray struct {
	// Origin is where the Ray originates from
	Origin Point
	// Dir is a unit vector for where the point
	Dir   Vec3
}



```

```go
package main

func main() {
	fmt.Println("hello world")

}

```


