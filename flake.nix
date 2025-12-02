{
  description = "Snowflake CLI for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Apply overlays internally to get upgraded packages
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import ./overlays/python-id.nix)
            (import ./overlays/snowflake-connector-python.nix)
            (import ./overlays/snowflake-core.nix)
            (import ./overlays/snowflake-cli.nix)
          ];
        };
      in
      rec {
        # Expose packages for easy consumption
        packages = {
          default = pkgs.snowflake-cli;
          snowflake-cli = pkgs.snowflake-cli;
          snowflake-core = pkgs.python3Packages.snowflake-core;
          snowflake-connector-python = pkgs.python3Packages.snowflake-connector-python;
          id = pkgs.python3Packages.id;
        };

        # Provide overlays for advanced users who want to compose with other overlays
        overlays = {
          default = nixpkgs.lib.composeManyExtensions [
            (import ./overlays/python-id.nix)
            (import ./overlays/snowflake-connector-python.nix)
            (import ./overlays/snowflake-core.nix)
            (import ./overlays/snowflake-cli.nix)
          ];
          snowflake-complete = self.overlays.default;
        };

        apps.default = {
          type = "app";
          meta = packages.snowflake-cli.meta;
          program = "${self.packages.${system}.snowflake-cli}/bin/snow";
        };

        # Development shell with snowflake-cli available
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            snowflake-cli
          ];
          shellHook = ''
            echo "Snowflake CLI ${pkgs.snowflake-cli.version} is available"
            snowflake --version
          '';
        };
      }
    );
}

