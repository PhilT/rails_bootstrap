{ pkgs, lib, config, inputs, ... }:

{
  packages = with pkgs; [ 
    git 
    pkg-config
    libyaml.dev
    openssl.dev
    postgresql
    ruby_3_3
  ];

  enterShell = ''
    bundle check || bundle
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep "2.42.0"
  '';

  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    listen_addresses = "127.0.0.1";
    initialDatabases = [
      { name = "APP_NAME_development"; }
      { name = "APP_NAME_test"; }
    ];
  };

  # https://devenv.sh/languages/
  # languages.nix.enable = true;
  languages.ruby = {
    enable = true;
    versionFile = ./.ruby-version; 
  };

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";
  processes.rails.exec = "bin/rails server";

  # See full reference at https://devenv.sh/reference/options/
}
