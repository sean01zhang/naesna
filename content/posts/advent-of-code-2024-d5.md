+++
title = "Advent of Code 2024, Day 5 Part 2"
date = 2024-12-08T13:53:55-05:00
draft = false
tags = ["Advent of Code 2024", "Advent of Code"]
+++

I wanted to write about this day, since I thought of a nice way to solve this, which is the first time I've actually used this algorithm outside of class.

I'll give a bit of a teaser: Topological Sort.

# Problem

Go check out the real website, https://adventofcode.com/2024/day/5 for a full picture, but I'll try to give as concise of a summary as possible.

## Your Input

1. You are given a set of rules, like `a|b`, meaning number `a` must come before number `b`
2. You are given a few arrays of numbers, and
	1. For Part 1, you must sum the middle number of all arrays that conform to the above set of rules.
	2. For Part 2, you must sort the invalid arrays and find the sum of their middle numbers.

# Solution

> **Context**
> You are only given the first problem until you solve the second one.

## Part 1: Naive Approach

With only the first problem in mind, the idea is that I can save the the rules as a `map[int][]int` where I map each number to a list of numbers that must come before it.

Then, I can go through the arrays and check for each number, `n`, in the array if all numbers that `n` must come before are actually before `n`.

There are some optimizations to this that you can make, for example you can create map from a number in your array to it's index so your lookups to each number can be fast.

When you get to part 2, this approach sort-of (no pun intended) falls apart. 

I guess the idea could be to insert a violating number ahead of the current number, but then you would need to re-do this until the array is completely sorted. In other words, you could attempt an insertion sort. However, there is a more clever way to get around this.

## Part 2: Topological Sort

I think it is fair to assume the ordering rules will be unambiguous. In other words, you wont have a "cycle" where `A` needs to come before `B` and `B` needs to come before `A`. The word "cycle" will be important later.

Since there must be a defined set of valid orderings, we can model these rules as a Directed Acyclic Graph (DAG), where if we have the rule `A|B` it is defined as an edge where node `A` has an outgoing edge to node `B`. 

Consider that the output of a topological sort can be ambiguous. For part 2, it is asking for the middle element of each array, which is heavily dependent on ordering of the array. I think it is safe to assume that these arrays have a solution that is unambiguous.

Once we topologically sort the array of rules, we can create an auxiliary data structure that maps each number in the sorted array to an index.

Then for each invalid array, we can map it to the indices in the topologically sorted array and sort the result of that. Finally, we map it back to the values and find the median value.

> **Update**
> 
> A key detail that I missed was that even though the arrays each have an unambiguous solution, the sort is still ambiguous. The case I did not account for was nonexistent elements in the array. I'll explain:
>
> Consider you have the two rules, `1|2` and `2|3`
> 
> ```mermaid
> flowchart LR
> 1((1))
> 2((2))
> 3((3))
> 1-->2
> 2-->3
> ```
> 
> From this, you may assume that 1 must come before 3. However, the following array is valid: 3, 1. 
> Both rules are vacuously true, and this causes use to improperly sort this as 1, 3.
>
> I think a way to get around this is to omit rules that involve nonexistent elements. This would involve reconstructing the graph for every incorrect array though.

Here is a link to the wikipedia page for topological sort: https://en.wikipedia.org/wiki/Topological_sorting

# The Code

- [Day 5 (src.naesna.es/aoc/blob/main/go/2024/day5.go)](https://src.naesna.es/aoc/blob/main/go/2024/day5.go)
- [DAG (src.naesna.es/aoc/blob/main/go/internal/util/graph.go)](https://src.naesna.es/aoc/blob/main/go/internal/util/graph.go)
