{
  config,
  ...
}:

{
  # https://devenv.sh/supported-languages/php/
  languages.php.enable = true;

  enterShell = ''
    echo "🐘 PHP version: $(php --version | head -n 1)"
  '';

  # https://devenv.sh/git-hooks/
  git-hooks = {
    hooks = {
      php-cs-fixer = {
        enable = true;
        args = [
          "--config"
          "./.php-cs-fixer.dist.php"
        ];
        excludes = [ "config/bundles.php" ];
        # Don't spam so many messages
        require_serial = true;
        # Override the entry to use vendor version instead of Nix-provided version
        # The Nix version (3.87.2) is too old and incompatible with PHP 8.4
        # The vendor version (3.93.1) works correctly
        entry = "${config.languages.php.package}/bin/php vendor/bin/php-cs-fixer fix";
      };
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
