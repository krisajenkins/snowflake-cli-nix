# protoc-wheel-0 is a binary package that provides the protoc compiler
# It's only available as wheels on PyPI, not as source
final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pythonFinal: pythonPrev: {
      protoc-wheel-0 = pythonPrev.buildPythonPackage rec {
        pname = "protoc-wheel-0";
        version = "21.1";
        format = "wheel";

        src =
          if prev.stdenv.isLinux && prev.stdenv.isx86_64 then
            prev.fetchurl
              {
                url = "https://files.pythonhosted.org/packages/f6/8d/8607727ec754391cc3a41aa4db074d0f3879d9252a353501ffb11257a7ba/protoc_wheel_0-21.1-py2.py3-none-manylinux1_x86_64.whl";
                hash = "sha256-JvvSrlUerOOWzopkRUaTl3WKJ73hZJz6uEEr5fMEmRU=";
              }
          else if prev.stdenv.isLinux && prev.stdenv.isAarch64 then
            prev.fetchurl
              {
                url = "https://files.pythonhosted.org/packages/ff/36/1102e10305968e1a162c36622b25c43192b728a1b381474fc3559477a9d6/protoc_wheel_0-21.1-py2.py3-none-manylinux2014_aarch64.whl";
                hash = "sha256-V1rO3EiT8sIe3iJsGc/sslV29YHDcTEI4rsSV/TdVmg=";
              }
          else if prev.stdenv.isDarwin && prev.stdenv.isx86_64 then
            prev.fetchurl
              {
                url = "https://files.pythonhosted.org/packages/f4/dc/c9446a14b7b12bb0e7ecb079ef279d8714d9fad2951871ca8b592892ed0d/protoc_wheel_0-21.1-py2.py3-none-macosx_10_6_x86_64.whl";
                hash = "sha256-XBg3SdVlKqgbeY4Peq2IpN1h4ZRr1Yh6E+IOfkpqyjk=";
              }
          else if prev.stdenv.isDarwin && prev.stdenv.isAarch64 then
            prev.fetchurl
              {
                url = "https://files.pythonhosted.org/packages/5d/ec/6e25628d28b06ba755b6b257c72b231daf938095e7d2ade1596f2302ab1e/protoc_wheel_0-21.1-py2.py3-none-macosx_11_0_arm64.whl";
                hash = "sha256-gsndGK7b1jSXmw5fuNaKAbR3xuFGVEX2kPJz0I2kxH4=";
              }
          else
            throw "Unsupported platform for protoc-wheel-0";

        pythonImportsCheck = [ ];

        # This is a binary package, no tests
        doCheck = false;
      };
    })
  ];
}
