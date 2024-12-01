+++
title = "What should I name my go mod?"
date = 2024-12-01T13:16:00-05:00
draft = false
tags = ["golang"]
+++

When I do `go mod init`, what should I init my module as? It seems like convention is to set the go mod name to the page of your repo in GitHub. But why?

Looking at the [gomod docs](https://go.dev/doc/modules/gomod-ref):

> The module path must uniquely identify your module. For most modules, the path is a URL where the `go` command can find the code (or a redirect to the code). For modules that won’t ever be downloaded directly, the module path can be just some name you control that will ensure uniqueness. The prefix `example/` is also reserved for use in examples like these.
>
> For more details, see [Managing dependencies](https://go.dev/doc/modules/managing-dependencies#naming_module).
>
> In practice, the module path is typically the module source’s repository domain and path to the module code within the repository. The go command relies on this form when downloading module versions to resolve dependencies on the module user’s behalf.
>
> Even if you’re not at first intending to make your module available for use from other code, using its repository path is a best practice that will help you avoid having to rename the module if you publish it later.

And under the [developing and publishing modules page](https://go.dev/doc/modules/developing#decentralized):

> In Go, you publish your module by tagging its code in your repository to make it available for other developers to use. You don’t need to push your module to a centralized service because Go tools can download your module directly from your repository (located using the module’s path, which is a URL with the scheme omitted) or from a proxy server.

This is interesting, so as long as `go` can find your source code, your go modules can be resolved. So, I can use a domain I own (i.e. `naesna.es`) to point to a repository and this would be discoverable by go's package manager!

> **Update**
> 
> `src.naesna.es` now redirects to my GitHub! I'll try to reference projects using this link so it is easy to move providers in the future :)
