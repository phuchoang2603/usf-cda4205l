{ pkgs, ... }:

{
  packages = [
    pkgs.rars
  ];

  scripts.rarsrun.exec = ''
    if [ -z "$1" ]; then
      echo "Usage: rarsrun <file.s>"
      exit 1
    fi
    rars nc "$1"
  '';
}
