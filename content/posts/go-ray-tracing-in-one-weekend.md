+++
title = "Ray Tracing in One Weekend using Go"
date = 2024-11-15T19:36:55-05:00
draft = true
tags = ["golang"]
+++

Yeah, so I've done this [before](archive/in-one-weekend), but in C++. I did this almost two years ago, but I would like to see how easy it would be to do it in go.

I will also try to do this from memory only -- so let's see how well this goes!

## Why am I doing this?

I wanted to write a post about profiling and improving performance of my go programs, but I haven't written anything yet. So the most trivial thing I can write off of the top of my memory is a brute-force ray tracer.

### What I remember

Please be warned, this may not paint a complete picture (no pun intended).

- We should have a camera
- We shoot rays out of this camera and see what objects we intersect in our world, which contains objects.
	- From those objects, we shoot out more rays and average the light coming in.
	- We do this recursively

## Ray Intersection

To start, let's get some object intersection working, meaning we will also need to get image output and some objects. We should:

- Create a shapes package
- Create a vector package
- Create a tracer object

### Shapes


```go
package vector3

import "math"

type Vec3 struct {
	X, Y, Z float64
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

// Sub subtracts v1 from this vector.
func (v0 *Vec3) Sub(v1 *Vec3) Vec3 {
	return Vec3{
		X: v0.X - v1.X,
		Y: v0.Y - v1.Y,
		Z: v0.Z - v1.Z,
	}
}

// Scalar multiplies each component of Vec3 by a
// scalar value.
func (v0 *Vec3) Scalar(c float64) Vec3 {
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

// Len2 returns the squared length of a vector.
func (v0 *Vec3) Len2() float64 {
	return v0.Dot(v0)
}

// Len returns the length of a vector
func (v0 *Vec3) Len() float64 {
	return math.Sqrt(v0.Len2())
}

// Unit returns a unit vector.
func (v0 *Vec3) Unit() Vec3 {
	return v0.Scalar(1.0 / v0.Len())
}

// Dot returns the dot product of two vectors.
func (v0 *Vec3) Dot(v1 *Vec3) float64 {
	return v0.X*v1.X + v0.Y*v1.Y + v0.Z*v1.Z
}

// Cross returns the cross product of two vectors.
func (v0 *Vec3) Cross(v1 *Vec3) Vec3 {
	return Vec3{
		X: v0.Y*v1.Z - v0.Z*v1.Y,
		Y: v0.Z*v1.X - v0.X*v1.Z,
		Z: v0.X*v1.Y - v0.Y*v1.X,
	}
}

```

```go
package geometry3d

import (
	"github.com/sean01zhang/go-rt-in-one-weekend/vector3"
)

type Vec3 = vector3.Vec3
type Point = vector3.Point

// HitData represents the data returned when a Ray hits a hittable.
type HitData struct {
	TValue   float64
	IsInside bool
}

// Hittable implements method that returns whether a Ray will hit an object.
type Hittable interface {
	Hit(Ray) (HitData, error)
}

// Ray represents a ray in 3D space.
type Ray struct {
	// Origin is where the Ray originates from
	Origin Point
	// Dir is a unit vector for where the point
	Dir Vec3
}
```

### Sphere-Ray intersection

Below I provide some explanation into how to get whether a ray has intersected a sphere.

- A Sphere has a radius and centre.
- A ray has a centre and a direction, essentially a line.
- For a ray to hit a sphere, there must be points of intersection between the sphere and ray.

> I admit, I had to look this up. I would have spent more time trying to derive this but that's not the point of this exercise. :ship:

A sphere has an equation as follows:

$$
(P - C) \cdot (P - C) \lt r
$$

where 
- $P$  is the generic point vector $\begin{bmatrix}x \\ y \\ z\end{bmatrix}$
- $C$ is the centre point of the sphere.

A ray has the form:

$$
P(t) = A + bt
$$

where 

- $A$ is the origin of the ray
- $b$ is the unit direction of the ray
- $t > 0$ is the time.

If we replace the $P$ in the sphere equation with $P(t)$ and check for number of roots of $t$ , we will know whether or not the ray will hit the sphere as we just have to solve the resultant quadratic.

$$
\begin{align*}
	(P(t) - C)\cdot(P(t) - C) &< r \cr
	(A + bt - C)\cdot(A + bt - C) &< r \cr
	(bt + (A -C))\cdot(bt + (A-C)) &< r \cr
	t^2(b \cdot b) + t (2b \cdot (A- C)) + (A - C) \cdot (A - C) &< r \cr
	t^2(b \cdot b) + t (2b \cdot (A- C)) + ((A-C) \cdot (A-C)-r) &< 0 \cr
\end{align*}
$$

Then, the ray hits the sphere if

$$
\begin{align*}
	(2b\cdot(A-C))^2 - 4(b\cdot b) ((A-C)\cdot(A-C)-r) &> 0 \cr
	(2b\cdot(A-C))^2 - 4||b||^2 (||A-C||^2 -r) &> 0 \cr
\end{align*}
$$

So, for the sphere, it should look implement `Hittable` as follows:

```go
package geometry3d

import (
	"fmt"
	"math"
)

// Sphere represents a sphere in 3D space.
type Sphere struct {
	// Centre is the centre point of the sphere.
	Centre Point
	Radius float64
}

// Hit returns whether a Ray will hit a Sphere.
func (s *Sphere) Hit(r Ray) (data HitData, err error) {
	oc := r.Origin.Sub(&s.Centre)

	a := r.Dir.Len2()
	b := 2 * r.Dir.Dot(&oc)
	disc := math.Exp2(2*r.Dir.Dot(&oc)) - 4*r.Dir.Len2()*(oc.Len2()-math.Exp2(s.Radius))

	// If the discriminant is less than 0, then the ray does not hit the sphere.
	if disc < 0 {
		return data, fmt.Errorf("no hit")
	}

	// Get both t-values
	t0 := (-b - math.Sqrt(disc)) / (2 * a)
	if t0 < 0 {
		return HitData{
			TValue:   t0,
			IsInside: true,
		}, nil
	}

	t1 := (-b + math.Sqrt(disc)) / (2 * a)
	return HitData{
		TValue: t1,
	}, nil
}


```

# Materials & Lighting

Materials can be implemented in many ways. This is also where the scope of this can explode out infinitely.

# Ray Tracing

```go

interface HittableMt {
	Hittable
	Material
}

func Thing(Ray r, mats ...HittableMat) {
	// for each material, check if ray hits
		// if ray hits, then get brdf and 
}


```

