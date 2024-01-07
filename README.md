# nix-shells

My collection of nix flake templates for various devShells

## Templates

### Haskell (Cabal)

```console
nix flake init -t github:mrcjkb/nix-shells#cabal
```

### Haskell (Stack)

```console
nix flake init -t github:mrcjkb/nix-shells#stack
```

> **Note**
>
> If `haskell-language-server-wrapper` can't find an executable
> for the `ghc` version, the resolver in `stack.yaml` needs to
> be changed.

### Lua

```console
nix flake init -t github:mrcjkb/nix-shells#lua
```

### Rust

```console
nix flake init -t github:mrcjkb/nix-shells#rust
```

### Zig

```console
nix flake init -t github:mrcjkb/nix-shells#zig
```

### Java

```console
nix flake init -t github:mrcjkb/nix-shells#java
```

### Python

```console
nix flake init -t github:mrcjkb/nix-shells#python
```

### Basic Nix devShell

```console
nix flake init -t github:mrcjkb/nix-shells#nix
```

### LaTeX

```console
nix flake init -t github:mrcjkb/nix-shells#tex
```

