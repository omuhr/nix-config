{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "djvu2pdf";
      runtimeInputs = with pkgs; [ docker ];
      text = ''
        docker run --rm -u "$(id -u)":"$(id -g)" -v "$(pwd)":/opt/work ilyabystrov/djvu2pdf
      '';
    })
  ];
}
