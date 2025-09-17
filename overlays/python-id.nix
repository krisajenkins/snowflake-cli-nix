final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      id = pythonPrev.buildPythonPackage rec {
        pname = "id";
        version = "1.5.0";
        pyproject = true;

        src = pythonPrev.fetchPypi {
          inherit pname version;
          hash = "sha256-KSy4pJ6su9vOlyRPR6l7TGJUAWnJdlUuSX/VffBzTB0=";
        };

        build-system = with pythonPrev; [
          flit-core
        ];

        dependencies = with pythonPrev; [
          requests
        ];

        pythonImportsCheck = [ "id" ];
      };
    })
  ];
}