final: prev: {
  snowflake-cli = prev.snowflake-cli.overridePythonAttrs (oldAttrs: rec {
    version = "3.11.0";
    src = prev.fetchFromGitHub {
      owner = "snowflakedb";
      repo = "snowflake-cli";
      tag = "v${version}";
      hash = "sha256-dJc5q3vE1G6oJq9V4JSPaSyODxKDyhprIwBo39Nu/bA=";
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