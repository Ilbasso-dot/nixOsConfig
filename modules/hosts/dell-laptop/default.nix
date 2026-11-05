{ self, inputs, ... }: {
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myMachineConfiguration
      self.nixosModules.development
      inputs.home-manager.nixosModules.home-manager
    ];
  };
}
