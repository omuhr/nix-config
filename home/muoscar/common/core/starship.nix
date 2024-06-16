{ pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    settings = {
      add_newline = false;
      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };
      fill.symbol = " ";
      directory = {
        style = "bold bright-yellow";
        truncation_length = 8;
      };
      git_branch.format = "[$branch(:$remote_branch)]($style)";

      nix_shell.format = "[$symbol$state( ($name))](bold blue) ";

      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        " "
        "$character"
      ];

      right_format = lib.concatStrings [
        "$nix_shell"
        "$c"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$gleam"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$quarto"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$typst"
        "$vlang"
        "$vagrant"
        "$zig"
        "$cmd_duration"
      ];
      # format = lib.concatStrings [
      #   "$username"
      #   "$hostname"
      #   "$directory"
      #   "$fill"
      #   "$git_branch"
      #   "$git_state"
      #   "$git_status"
      #   "$cmd_duration"
      #   "$c"
      #   "$cmake"
      #   "$cobol"
      #   "$daml"
      #   "$dart"
      #   "$deno"
      #   "$dotnet"
      #   "$elixir"
      #   "$elm"
      #   "$erlang"
      #   "$fennel"
      #   "$gleam"
      #   "$golang"
      #   "$guix_shell"
      #   "$haskell"
      #   "$haxe"
      #   "$helm"
      #   "$java"
      #   "$julia"
      #   "$kotlin"
      #   "$gradle"
      #   "$lua"
      #   "$nim"
      #   "$nodejs"
      #   "$ocaml"
      #   "$opa"
      #   "$perl"
      #   "$php"
      #   "$pulumi"
      #   "$purescript"
      #   "$python"
      #   "$quarto"
      #   "$raku"
      #   "$rlang"
      #   "$red"
      #   "$ruby"
      #   "$rust"
      #   "$scala"
      #   "$solidity"
      #   "$swift"
      #   "$terraform"
      #   "$typst"
      #   "$vlang"
      #   "$vagrant"
      #   "$zig"
      #   "$line_break"
      #   "$character"
      # ];
      bun.format = "[$symbol]($style)";
      buf.format = "[$symbol]($style)";
      cmake.format = "[$symbol]($style)";
      cobol.format = "[$symbol]($style)";
      crystal.format = "[$symbol]($style)";
      daml.format = "[$symbol]($style)";
      dart.format = "[$symbol]($style)";
      deno.format = "[$symbol]($style)";
      dotnet.format = "[$symbol(🎯 $tfm )]($style)";
      elixir.format = "[$symbol]($style)";
      elm.format = "[$symbol]($style)";
      erlang.format = "[$symbol]($style)";
      fennel.format = "[$symbol]($style)";
      gleam.format = "[$symbol]($style)";
      golang.format = "[$symbol]($style)";
      gradle.format = "[$symbol]($style)";
      haxe.format = "[$symbol]($style)";
      helm.format = "[$symbol]($style)";
      java.format = "[$symbol]($style)";
      julia.format = "[$symbol]($style)";
      kotlin.format = "[$symbol]($style)";
      lua.format = "[$symbol]($style)";
      meson.format = "[$symbol]($style)";
      nim.format = "[$symbol]($style)";
      nodejs.format = "[$symbol]($style)";
      ocaml.format = "[$symbol(($switch_indicator$switch_name) )]($style)";
      opa.format = "[$symbol]($style)";
      perl.format = "[$symbol]($style)";
      php.format = "[$symbol]($style)";
      pulumi.format = "[$symbol$stack]($style)";
      purescript.format = "[$symbol]($style)";
      python.format = "[$symbol]($style)";
      quarto.format = "[$symbol]($style)";
      raku.format = "[$symbol]($style)";
      red.format = "[$symbol]($style)";
      rlang.format = "[$symbol]($style)";
      ruby.format = "[$symbol]($style)";
      rust.format = "[$symbol]($style)";
      solidity.format = "[$symbol]($style)";
      typst.format = "[$symbol]($style)";
      swift.format = "[$symbol]($style)";
      vagrant.format = "[$symbol]($style)";
      vlang.format = "[$symbol]($style)";
      zig.format = "[$symbol]($style)";
    };
  };
}
