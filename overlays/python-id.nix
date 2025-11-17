# Latest version: https://pypi.org/project/id/
# Update hash: nix-prefetch-url https://pypi.org/packages/source/i/id/id-X.Y.Z.tar.gz (no --unpack for fetchPypi)
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