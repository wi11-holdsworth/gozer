{
  description = "Gozer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      packages = forAllSystems (
        { pkgs }:
        {
          default = pkgs.buildGoModule rec {
            pname = "gozer";
            version = "0.2.0";
            src = pkgs.fetchFromGitHub {
              owner = "dannyvankooten";
              repo = "gozer";
              tag = "${version}";
              sha256 = "sha256-TTZM5sKTuN3FMcLTmdnSQKXTp8iiExDylC9FxnTfM3c=";
            };
            vendorHash = "sha256-PueVqanp3dAuB1RCtlAXpDki5Bj0lQQKj30BGWcuDII=";
          };
        }
      );
    };
}
