{
  description = "Flutter + Go + ConnectRPC Starter Template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            flutter
            buf
            protobuf
            protoc-gen-go
            go-tools
          ];
          
          shellHook = ''
            echo "Environment is ready! Go, Flutter and Buf are installed."
          '';
        };
      }
    );
}
