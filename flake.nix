{
  description = "Data specific to robots ur5 and ur10 for hpp-corbaserver";

  inputs.gepetto.url = "github:gepetto/nix";

  outputs =
    inputs:
    inputs.gepetto.lib.mkFlakoboros inputs (
      { lib, ... }:
      {
        overrideAttrs.hpp-universal-robot = {
          src = lib.fileset.toSource {
            root = ./.;
            fileset = lib.fileset.unions [
              ./CMakeLists.txt
              ./doc
              ./package.xml
              ./src
            ];
          };
        };
      }
    );
}
