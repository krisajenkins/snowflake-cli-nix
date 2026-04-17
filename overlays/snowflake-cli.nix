# Latest version: https://github.com/snowflakedb/snowflake-cli/releases/latest
# Update hash: nix-prefetch-url --unpack https://github.com/snowflakedb/snowflake-cli/archive/refs/tags/vX.Y.Z.tar.gz
final: prev: {
  snowflake-cli = prev.snowflake-cli.overridePythonAttrs (oldAttrs: rec {
    version = "3.16.0";
    src = prev.fetchFromGitHub {
      owner = "snowflakedb";
      repo = "snowflake-cli";
      tag = "v${version}";
      hash = "sha256-0n1h7zg0mUyCKRsunP5mlV8pNx9YS5CHup6wSyJvlVQ=";
    };
    dependencies = (oldAttrs.dependencies or [ ]) ++ (with prev.python3Packages; [
      prompt-toolkit
      snowflake-core
      snowflake-snowpark-python
      id
      keyring
    ]);
    # Disable shell completion installation as it fails
    postInstall = "";
    # Skip tests as they fail due to missing workload_identity module
    doCheck = false;
  });
}
