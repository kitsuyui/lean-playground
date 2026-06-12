# Security Policy

日本語: 脆弱性は公開 issue に書かず、下記の「Report a vulnerability」から
非公開で報告してください。

## Reporting a vulnerability

Please do **not** open a public issue or pull request containing exploit
details.

Use GitHub's private vulnerability reporting: on the repository page, go to
**Security → Report a vulnerability**. This reaches the maintainer privately.

What to include:

- The affected repository and version (or commit).
- Steps to reproduce, or a proof of concept.
- The impact you believe it has.

These are personal projects maintained in spare time. I will acknowledge
reports as soon as I can — typically within two weeks — and coordinate a fix
and disclosure with you. If a repository ships a published package, a fixed
release and an advisory will follow once the fix lands.

## Supply chain note

The CI workflow pins `leanprover/lean-action` to a commit SHA. The Lean
toolchain binary is fetched by lean-action based on the version in
`lean-toolchain` and is not independently hash-verified. The `lean-action`
commit pin protects the action code itself; toolchain binary integrity relies
on the upstream `leanprover/lean4` release integrity.
