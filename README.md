# flakes

My collection of nix flake templates for various devShells

## Shells

### Haskell (Cabal)

```console
nix flake init -t github:mrcjkb/flakes#cabal
```

### Haskell (Stack)

```console
nix flake init -t github:mrcjkb/flakes#stack
```

> **Note**
>
> If `haskell-language-server-wrapper` can't find an executable
> for the `ghc` version, the resolver in `stack.yaml` needs to
> be changed.

### Lua

```console
nix flake init -t github:mrcjkb/flakes#lua
```

### Rust

```console
nix flake init -t github:mrcjkb/flakes#rust
```

### Zig

```console
nix flake init -t github:mrcjkb/flakes#zig
```

### Java

```console
nix flake init -t github:mrcjkb/flakes#java
```

### Python

```console
nix flake init -t github:mrcjkb/flakes#python
```

### Basic Nix devShell

```console
nix flake init -t github:mrcjkb/flakes#nix
```

### LaTeX

```console
nix flake init -t github:mrcjkb/flakes#tex
```

## Other

### `nixosTest`

```console
nix flake init -t github:mrcjkb/flakes#nixosTest
```
