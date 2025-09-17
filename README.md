# Snowflake CLI for Nix

This repository provides [Snowflake CLI](https://docs.snowflake.com/en/developer-guide/snowflake-cli/index) version 3.11.0 as a Nix package, along with all required dependencies.

## What's Included

- **snowflake-cli** 3.11.0 - Main Snowflake CLI tool
- **snowflake-core** 1.7.0 - Core Snowflake Python library
- **snowflake-connector-python** 3.17.3 - Updated Snowflake Python connector
- **id** 1.5.0 - Required Python package for authentication

All packages are upgraded from the versions available in nixpkgs 25.05 to ensure compatibility.

## Installation

> **Note**: All examples use `inputs.nixpkgs.follows = "nixpkgs"` to ensure snowflake-cli-nix uses your chosen nixpkgs version. This prevents multiple nixpkgs evaluations and ensures consistency across your entire project.

### Quick Try (No Installation)

```bash
# Run snowflake CLI directly
nix run github:krisajenkins/snowflake-cli-nix/v3.11.0 -- --version

# Test in a shell
nix shell github:krisajenkins/snowflake-cli-nix/v3.11.0 --command snow --version
```

### Install to Profile

```bash
# Install snowflake CLI to your profile
nix profile install github:krisajenkins/snowflake-cli-nix/v3.11.0

# Check installation
snow --version
```

### Use in Flake

Add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Your preferred nixpkgs
    flake-utils.url = "github:numtide/flake-utils";

    snowflake-cli-nix = {
      url = "github:krisajenkins/snowflake-cli-nix/v3.11.0";
      inputs.nixpkgs.follows = "nixpkgs";  # Use your nixpkgs version
    };
  };

  outputs = { nixpkgs, flake-utils, snowflake-cli-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        snowflake-cli = snowflake-cli-nix.packages.${system}.snowflake-cli;
      in {
        packages.default = pkgs.buildEnv {
          name = "my-tools";
          paths = [
            snowflake-cli
            # your other packages...
          ];
        };
      });
}
```

### Development Shell

Create a `shell.nix` or add to your `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Your preferred nixpkgs
    flake-utils.url = "github:numtide/flake-utils";

    snowflake-cli-nix = {
      url = "github:krisajenkins/snowflake-cli-nix/v3.11.0";
      inputs.nixpkgs.follows = "nixpkgs";  # Use your nixpkgs version
    };

  outputs = { nixpkgs, flake-utils, snowflake-cli-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # config.allowUnfree = true;  # If you need unfree packages
        };
        snowflake-cli = snowflake-cli-nix.packages.${system}.snowflake-cli;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            snowflake-cli
            # your other development tools...
          ];
        };
      });
}
```

Or use the provided development shell:

```bash
nix develop github:krisajenkins/snowflake-cli-nix/v3.11.0
```

### Traditional Nix

For non-flake usage, you can import the overlay:

```nix
let
  snowflake-src = builtins.fetchGit {
    url = "https://github.com/krisajenkins/snowflake-cli-nix";
    ref = "main";
  };
  pkgs = import <nixpkgs> {
    overlays = [ (import "${snowflake-src}/overlays/snowflake-cli.nix") ];
  };
in
pkgs.snowflake-cli
```

## Available Packages

| Package | Version | Description |
|---------|---------|-------------|
| `snowflake-cli` (default) | 3.11.0 | Main Snowflake CLI tool |
| `snowflake-core` | 1.7.0 | Core Snowflake Python library |
| `snowflake-connector-python` | 3.17.3 | Snowflake Python connector |
| `id` | 1.5.0 | Authentication utility |

Access individual packages:

```bash
nix run github:krisajenkins/snowflake-cli-nix/v3.11.0#snowflake-core
nix run github:krisajenkins/snowflake-cli-nix/v3.11.0#snowflake-connector-python
```

## Usage

After installation, check with:

```bash
# Show version
snow --version

# Show help
snow --help
```

## Supported Platforms

- x86_64-linux
- aarch64-linux
- x86_64-darwin
- aarch64-darwin

## Advanced Usage

### Using Overlays

For advanced users who want to compose with other overlays:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Your preferred nixpkgs
    flake-utils.url = "github:numtide/flake-utils";

    snowflake-cli-nix = {
      url = "github:krisajenkins/snowflake-cli-nix/v3.11.0";
      inputs.nixpkgs.follows = "nixpkgs";  # Use your nixpkgs version
    };

  outputs = { nixpkgs, flake-utils, snowflake-cli-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            snowflake-cli-nix.overlays.default
            # your other overlays...
          ];
        };
      in
      {
        packages.default = pkgs.snowflake-cli;
      });
}
```

## Building from Source

```bash
git clone https://github.com/krisajenkins/snowflake-cli-nix
cd snowflake-cli-nix
nix build
```

## Troubleshooting

### Common Issues

1. **Import errors**: Ensure all dependencies are properly installed by using the complete package
1. **Version conflicts**: This flake pins specific compatible versions to avoid conflicts
1. **Platform support**: Check that your platform is supported above

### Getting Help

- [Snowflake CLI Documentation](https://docs.snowflake.com/en/developer-guide/snowflake-cli/index)
- [File an issue](https://github.com/krisajenkins/snowflake-cli-nix/issues)

## Contributing

Contributions are welcome! Please:

1. Test your changes with `nix build`
1. Update version numbers in both overlay files and README
1. Ensure all platforms build successfully

## License

This repository contains Nix expressions for packaging existing software. See individual software licenses:

- [Snowflake CLI License](https://github.com/snowflakedb/snowflake-cli)
- [Snowflake Connector License](https://github.com/snowflakedb/snowflake-connector-python)
