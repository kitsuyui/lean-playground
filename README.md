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
