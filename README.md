# flakes

My collection of nix flake templates.

## Basic nix flake

With only `nixpkgs` as an input and boilerplate for iterating over systems.

```sh
nix flake init -t "github:mrcjkb/flakes#basic"
```

## Shells

### Haskell (Cabal)

```sh
nix flake init -t "github:mrcjkb/flakes#cabal"
```

### Haskell (Stack)

```sh
nix flake init -t "github:mrcjkb/flakes#stack"
```

> **Note**
>
> If `haskell-language-server-wrapper` can't find an executable
> for the `ghc` version, the resolver in `stack.yaml` needs to
> be changed.

### Lua (basic)

```sh
nix flake init -t "github:mrcjkb/flakes#lua"
```

### Lua (neovim)

```sh
nix flake init "github:mrcjkb/flakes#nvim"
```

### Rust

```sh
nix flake init -t "github:mrcjkb/flakes#rust"
```

### Zig

```sh
nix flake init -t "github:mrcjkb/flakes#zig"
```

### Java

```sh
nix flake init -t "github:mrcjkb/flakes#java"
```

### Python

```sh
nix flake init -t "github:mrcjkb/flakes#python"
```

### Basic Nix devShell

```sh
nix flake init -t "github:mrcjkb/flakes#nix"
```

### LaTeX

```sh
nix flake init -t "github:mrcjkb/flakes#tex"
```

### Typst

```sh
nix flake init -t "github:mrcjkb/flakes#typst"
```

## Other

### `nixosTest`

```sh
nix flake init -t "github:mrcjkb/flakes#nixosTest"
```

### `nix-unit`

```sh
nix flake init -t "github:mrcjkb/flakes#nix-unit"
```
