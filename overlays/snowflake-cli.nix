# Latest version: https://github.com/snowflakedb/snowflake-cli/releases/latest
# Update hash: nix-prefetch-url --unpack https://github.com/snowflakedb/snowflake-cli/archive/refs/tags/vX.Y.Z.tar.gz
final: prev: {
  snowflake-cli = prev.snowflake-cli.overridePythonAttrs (oldAttrs: rec {
    version = "3.15.0";
    src = prev.fetchFromGitHub {
      owner = "snowflakedb";
      repo = "snowflake-cli";
      tag = "v${version}";
      hash = "sha256-c0o23clm3Qrq4YoZd0N0aW7UntGmRhNY09WYgk9MIzA=";
    };
    dependencies = (oldAttrs.dependencies or [ ]) ++ (with prev.python3Packages; [
      prompt-toolkit
      snowflake-core
      snowflake-snowpark-python
      id
    ]);
    # Disable shell completion installation as it fails
    postInstall = "";
    # Skip tests as they fail due to missing workload_identity module
    doCheck = false;
  });
}
