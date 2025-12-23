{
  lib,
  ...
}:

{
  # https://devenv.sh/supported-languages/javascript/
  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;

  enterShell = ''
    echo "📦 Node version: $(node --version | head -n 1)"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    prettier.enable = lib.mkDefault true;
    eslint.enable = lib.mkDefault true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
