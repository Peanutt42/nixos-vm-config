{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          nix.settings.experimental-features = [ "nix-command" "flakes" ];

          users.users.root = {
            initialPassword = "";
			shell = pkgs.fish;
          };
		  security.pam.services.login.allowNullPassword = true;
          services.getty.autologinUser = "root";

          nixpkgs.config.allowUnfree = true;

          programs = {
			  neovim.enable = true;
			  fish.enable = true;
		  };

		  environment.systemPackages = with pkgs; [
            git
			just
			gcc
			python3
		  ];

		  programs.nix-ld.enable = true;
          programs.nix-ld.libraries = with pkgs; [
            # Add any missing dynamic libraries for unpackaged programs
            # here, NOT in environment.systemPackages
          ];

          virtualisation.vmVariant = {
            virtualisation.graphics = false;
			virtualisation.memorySize = 6144; # 6 GB
			virtualisation.diskSize = 10240; # 10 GB
			virtualisation.writableStoreUseTmpfs = false;
          };
		  
		  system.stateVersion = "25.11";
        })
      ];
    };
  };
}
