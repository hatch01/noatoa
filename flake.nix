{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        devShells.default = with pkgs;
          mkShell rec {
            # things only needed at compile time
            nativeBuildInputs = [
              # List of packages to be available in the shell
            ];

            # things which will get the program linked to
            buildInputs = [
              # List of packages to be available in the shell
              godot_4
              emscripten
              libxkbcommon
              libGL
              xorg.libX11
              xorg.libXcursor
              xorg.libXext
              xorg.libXinerama
              xorg.libXrandr
              xorg.libXi
              fontconfig
              libpulseaudio
              alsa-lib
              dbus
            ];
            LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
          };
        formatter = pkgs.alejandra;
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
      };
    };
}
