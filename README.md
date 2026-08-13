# lean-playground

A playground repository for experimenting with [Lean 4](https://lean-lang.org/).

## Prerequisites

Install [elan](https://github.com/leanprover/elan) (the Lean version manager). [Lake](https://github.com/leanprover/lake) (the build system) and `lean` are bundled with the toolchain.

On macOS with Homebrew:

```sh
brew install elan-init
elan toolchain install stable
```

elan will use the Lean version specified in `lean-toolchain` when running inside this repository.

## Running

Build and run the Hello World example:

```sh
lake exe hello
```

Expected output:

```
Hello, World
Hello from ExampleA
Hello from ExampleB
Hello from ExampleC
```

## Development

This repository uses [lefthook](https://github.com/evilmartians/lefthook) to run local checks that mirror CI.

Install the hooks after cloning:

```sh
lefthook install
```

### Pre-push hook

`lake build` and `lake exe hello` run automatically on `git push`. The hook unsets all `GIT_*` environment variables before invoking Lake so that the build and runnable example check are not affected by Git's internal environment.

These checks are intentionally placed in the pre-push hook (not pre-commit) because they can take several seconds. This ensures your branch is buildable and that the documented Hello World path still runs before it reaches the remote.
