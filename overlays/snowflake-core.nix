# Latest version: https://pypi.org/project/snowflake-core/
# Update hash: nix-prefetch-url https://pypi.org/packages/source/s/snowflake-core/snowflake_core-X.Y.Z.tar.gz (no --unpack for fetchPypi)
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      snowflake-core = pythonPrev.buildPythonPackage rec {
        pname = "snowflake-core";
        version = "1.10.0";
        pyproject = true;

        src = pythonPrev.fetchPypi {
          pname = "snowflake_core";
          inherit version;
          hash = "sha256-JC2WNa6gbcKl5UlM62B3x22pO9EC725bR31oIMfSCdk=";
        };

        build-system = with pythonPrev; [
          hatchling
        ];

        dependencies = with pythonPrev; [
          snowflake-connector-python
          pydantic
          python-dateutil
          pyyaml
        ];

        pythonImportsCheck = [ "snowflake.core" ];
      };
    })
  ];
}
