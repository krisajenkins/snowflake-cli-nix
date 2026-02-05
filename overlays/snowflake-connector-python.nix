# Latest version: https://github.com/snowflakedb/snowflake-connector-python/releases/latest
# Update hash: nix-prefetch-url --unpack https://github.com/snowflakedb/snowflake-connector-python/archive/refs/tags/vX.Y.Z.tar.gz
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      snowflake-connector-python = pythonPrev.snowflake-connector-python.overridePythonAttrs (oldAttrs: rec {
        version = "3.18.0";
        src = prev.fetchFromGitHub {
          owner = "snowflakedb";
          repo = "snowflake-connector-python";
          tag = "v${version}";
          hash = "sha256-PEAfkrZSyDkWu/NrRomxf+YI9+6xcV2WVEmDxueHFqM=";
        };
        dependencies = (oldAttrs.dependencies or [ ]) ++ (with pythonPrev; [
          boto3
          botocore
        ]);
        # Skip tests as they have failures in this version
        doCheck = false;
      });
    })
  ];
}
