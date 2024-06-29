{
  lib,
  stdenv,
  cmake,
  jrl-cmakemodules,
  example-robot-data,
  python3Packages,
}:

python3Packages.buildPythonPackage {
  pname = "hpp-universal-robot";
  version = "5.0.0";
  pyproject = false;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./CMakeLists.txt
      ./doc
      ./package.xml
      ./src
    ];
  };

  strictDeps = true;

  nativeBuildInputs = [
    cmake
    python3Packages.python
  ];
  propagatedBuildInputs = [
    jrl-cmakemodules
    example-robot-data
  ];

  doCheck = true;

  meta = {
    description = "Data specific to robots ur5 and ur10 for hpp-corbaserver";
    homepage = "https://github.com/humanoid-path-planner/hpp-universal-robot";
    license = lib.licenses.bsd2;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
