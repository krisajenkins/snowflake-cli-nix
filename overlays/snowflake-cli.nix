final: prev: {
  snowflake-cli = prev.snowflake-cli.overridePythonAttrs (oldAttrs: rec {
    version = "3.13.0-rc0";
    src = prev.fetchFromGitHub {
      owner = "snowflakedb";
      repo = "snowflake-cli";
      tag = "v${version}";
      hash = "sha256-QRuhntct5vTgNeuHGpK34gO2XtfScO0vxE13ZN/qvOc=";
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
