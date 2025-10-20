{
  pkgs,
  ...
}:

{
  languages.cplusplus.enable = true;

  # https://devenv.sh/packages/
  packages = with pkgs; [
    cmake
  ];

  files.".shared/cpp.just".text = builtins.readFile ./justfile;

  enterShell = ''
    echo "📦 CMake: $(cmake --version | head -n1)"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    cmake-format.enable = true;
    clang-format = {
      enable = true;
    };

    # Custom pre-commit hook to format justfile
    qmlformat = {
      enable = true;
      name = "qmlformat";
      entry = "${pkgs.qt6.qtdeclarative}/bin/qmlformat -i";
      language = "system";
      pass_filenames = true;
      stages = [ "pre-commit" ];
      files = "\\.qml$";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
