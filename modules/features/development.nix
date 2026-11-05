{
  flake.nixosModules.development = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Rust
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
#       rustPlatform.rustLibSrc

      # C / C++
      gcc
      gnumake
      gdb

      # Build tools
      cmake
      pkg-config
    ];

    environment.variables.RUST_SRC_PATH =
      "${pkgs.rustPlatform.rustLibSrc}/lib/rustlib/src/rust/library";

#     programs.vscode = {
#       enable = true;
#       profiles = {
#         default = {
#           extensions = with pkgs.vscode-extensions; [
#             rust-lang.rust-analyzer
#           ];
#
#         };
#       };
#     };
  };
}
