{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkDefault
    ;
in
{
  # https://devenv.sh/packages/
  packages = with pkgs; [
    just # Task runner
  ];

  files.".shared/common.just".text = builtins.readFile ./justfile;

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    prettier = {
      enable = mkDefault true;
      files = "\\.(js|json|md|yaml|yml|vue)$";
    };

    shfmt = {
      enable = mkDefault true;
      files = "\\.(sh|bash|envrc|envrc\\..*)$";
      # Format with two spaces indent, instead of tabulator
      entry = "${pkgs.shfmt}/bin/shfmt -i 2 -w";
    };

    nixfmt-rfc-style.enable = true;
    statix.enable = true;

    gitlint = {
      # Ignore empty body (B6) and allow titles up to 100 characters
      # We also need to ignore T8 (body line length) and B4 (Second line is not empty),
      # because of https://github.com/jorisroovers/gitlint/issues/499
      # Using args didn't work, because of https://github.com/cachix/git-hooks.nix/issues/641
      # If we need more config we could also pull in a shared config file and set it with "-C"
      entry = "${pkgs.gitlint}/bin/gitlint -c general.ignore=B6,B4,T8 -c title-max-length.line-length=100 --staged --msg-filename";
    };

    # https://devenv.sh/reference/options/#git-hookshooksdeadnix
    # https://github.com/astro/deadnix
    deadnix = {
      enable = true;
      settings = {
        edit = true; # Allow to edit the file if it is not formatted
      };
    };

    # Custom pre-commit hook to format justfile
    just = {
      enable = true;
      name = "just";
      entry = "${pkgs.just}/bin/just --fmt --unstable";
      language = "system";
      pass_filenames = false;
      stages = [ "pre-commit" ];
      files = "(^|/)(justfile|Justfile)$";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
