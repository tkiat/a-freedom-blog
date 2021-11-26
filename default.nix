{}:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  shell = pkgs.mkShell
    {
      buildInputs = [
        pkgs.nodejs-14_x
        # pkgs.nodePackages.purty
        pkgs.nodePackages.purescript-language-server
        pkgs.purescript
        pkgs.spago
      ];
      shellHook = ''
        export PATH="$PWD/node_modules/.bin/:$PATH"
      '';
    };
in
{
  inherit shell;
}
