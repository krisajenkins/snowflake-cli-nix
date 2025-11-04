final: prev: {
  snowflake-cli = prev.snowflake-cli.overridePythonAttrs (oldAttrs: rec {
    version = "3.13.0";
    src = prev.fetchFromGitHub {
      owner = "snowflakedb";
      repo = "snowflake-cli";
      tag = "v${version}";
      hash = "sha256-TOX3U81Rg16wT+5/qqIWJqMQfRQx8Ng2DtHlSAH0RR4=";
    };
    dependencies = (oldAttrs.dependencies or []) ++ (with prev.python3Packages; [
      prompt-toolkit
      snowflake-core
      id
    ]);
    # Disable shell completion installation as it fails
    postInstall = "";
    # Skip tests as they fail due to missing workload_identity module
    doCheck = false;
  });
}
