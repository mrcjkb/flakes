# flakes

My collection of nix flake templates.

## Shells

### Haskell (Cabal)

```sh
nix flake init "github:mrcjkb/flakes#cabal"
```

### Haskell (Stack)

```sh
nix flake init "github:mrcjkb/flakes#stack"
```

> **Note**
>
> If `haskell-language-server-wrapper` can't find an executable
> for the `ghc` version, the resolver in `stack.yaml` needs to
> be changed.

### Lua

```sh
nix flake init "github:mrcjkb/flakes#lua"
```

### Rust

```sh
nix flake init "github:mrcjkb/flakes#rust"
```

### Zig

```sh
nix flake init "github:mrcjkb/flakes#zig"
```

### Java

```sh
nix flake init "github:mrcjkb/flakes#java"
```

### Python

```sh
nix flake init "github:mrcjkb/flakes#python"
```

### Basic Nix devShell

```sh
nix flake init "github:mrcjkb/flakes#nix"
```

### LaTeX

```sh
nix flake init "github:mrcjkb/flakes#tex"
```

## Other

### Basic nix flake

With only `nixpkgs` as an input.

```sh
nix flake init "github:mrcjkb/flakes#basic"
```

### `nixosTest`

```sh
nix flake init "github:mrcjkb/flakes#nixosTest"
```
