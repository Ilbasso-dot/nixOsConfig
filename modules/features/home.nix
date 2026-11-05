{ ... }: {
  flake.homeManagerModules.home =
    {
      self,
      config,
      pkgs,
      ...
    }:

    {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      home.username = "nixus";
      home.homeDirectory = "/home/nixus";

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "26.05"; # Please read the comment before changing.

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = [
        self.packages.${pkgs.system}.myNoctalia
      ];

      xdg.configFile."niri/config.kdl".source = ../config/niri/config.kdl;

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      #     home.file = {
      #       ".config/niri/config.kdl" = {
      #         source = ../config/niri/config.kdl;
      #         force = true;
      #       };
      #       # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      #       # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      #       # # symlink to the Nix store copy.
      #       # ".screenrc".source = dotfiles/screenrc;
      #
      #       # # You can also set the file content immediately.
      #       # ".gradle/gradle.properties".text = ''
      #       #   org.gradle.console=verbose
      #       #   org.gradle.daemon.idletimeout=3600000
      #       # '';
      #     };

      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/nixus/etc/profile.d/hm-session-vars.sh
      #
      home.sessionVariables = {
        EDITOR = "nvim";
        TERMINAL = "kitty";
#         PATH="$HOME/.cargo/bin:$PATH"
        RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
      };

      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
        ];
      };


      programs.git = {
        enable = true;
        settings.user = {
          name = "Ilbasso-dot";
          email = "baxiandri@gmail.com";
        };
        settings.alias = {
          pu = "push";
          co = "checkout";
          cm = "commit";
        };
      };
      /*
          gtk = {
            enable = true;
            theme.name = "adw-gtk3";
        #     cursorTheme.name = "Bibata-Modern-Ice";
            iconTheme.name = "GruvboxPlus";
          };
      */

      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;

      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
