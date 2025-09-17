final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      snowflake-core = pythonPrev.buildPythonPackage rec {
        pname = "snowflake-core";
        version = "1.7.0";
        pyproject = true;

        src = pythonPrev.fetchPypi {
          pname = "snowflake_core";
          inherit version;
          hash = "sha256-hlWpTCEa4E0dgD28h2JJ3m0/gCHMVzjWia6oQtG2an8=";
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