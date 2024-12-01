+++
title = "How to Make the Footer Go to the Bottom"
date = 2024-11-30T22:16:27-05:00
draft = false
tags = ["html-css"]
+++

Here's how I keep my website footer at the bottom. I need these footers to do a few things:
1. Always be at the bottom of the page
	- When a page is shorter than the height of the screen, then the footer should stick to the bottom of the screen.
	- When the page is longer than the height of the screen, then the footer should be at the bottom of the **page**. This means that I need to scroll in order to see the footer.

## The Approach

Ok so why is this so hard? IDK. Here is an easy approach:
1. Always make your outermost container be **at least** the height of the screen.
2. Then, make sure the footer is at the bottom of the container.
	- This can be done using flex and making sure the container above the footer expands.

## The Sauce

Suppose my page structure looks like this:

```html
<html>
	<head>...</head>
	<body>
		<header>...</header>
		<main>...</main>
		<footer>...</footer>
	</body>
</html>
```

Then my CSS to make the footer stick would be:

```css
body {
	display: flex;
	flex-direction: column;
	/* make the body AT LEAST the 
	   full height of the window */
	min-height: 100vh;
}

main {
	/*  make the main section expand to take up 
	 *  all unused space. This relies on other 
	 *  items not growing. */
	flex-grow: 1;
}
```

## I want to make my footer behave some different way

Sorry, wrong place!