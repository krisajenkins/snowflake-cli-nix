# Latest version: https://pypi.org/project/snowflake-snowpark-python/
# Update hash: nix-prefetch-url https://pypi.org/packages/source/s/snowflake-snowpark-python/snowflake_snowpark_python-X.Y.Z.tar.gz (no --unpack for fetchPypi)
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      snowflake-snowpark-python = pythonPrev.buildPythonPackage rec {
        pname = "snowflake-snowpark-python";
        version = "1.42.0";
        pyproject = true;

        src = pythonPrev.fetchPypi {
          pname = "snowflake_snowpark_python";
          inherit version;
          hash = "sha256-6ZSzhgyBbRtf3wxicvjZ5BUF5HAUCwY/+UGNI0/YzAA=";
        };

        build-system = with pythonPrev; [
          setuptools
          wheel
          mypy-protobuf
          protoc-wheel-0
        ];

        dependencies = with pythonPrev; [
          snowflake-connector-python
          typing-extensions
          pyyaml
          cloudpickle
          protobuf
          python-dateutil
          tzlocal
        ];

        # Relax protobuf version constraint - nixpkgs has 6.33.1 which works fine
        pythonRelaxDeps = [ "protobuf" ];

        pythonImportsCheck = [ "snowflake.snowpark" ];

        # Skip tests as they require a Snowflake account
        doCheck = false;
      };
    })
  ];
}
