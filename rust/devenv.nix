_:

{
  # https://devenv.sh/languages/
  languages = {
    rust.enable = true;
  };

  enterShell = ''
    echo "🦀 Rust version: $(rustc --version | head -n 1)"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
