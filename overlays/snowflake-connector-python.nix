final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      snowflake-connector-python = pythonPrev.snowflake-connector-python.overridePythonAttrs (oldAttrs: rec {
        version = "3.17.3";
        src = prev.fetchFromGitHub {
          owner = "snowflakedb";
          repo = "snowflake-connector-python";
          tag = "v${version}";
          hash = "sha256-fvVYL9NUe/01Q22KETWZpOig9zyk2iF9n0beI/hqFIM=";
        };
        dependencies = (oldAttrs.dependencies or []) ++ (with pythonPrev; [
          boto3
          botocore
        ]);
        # Skip tests as they have failures in this version
        doCheck = false;
      });
    })
  ];
}
