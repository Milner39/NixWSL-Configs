{
  pkgs,
  ...
} @ args:

{
  # Smartcard reader service
  services.pcscd.enable = true;

  # More yubikey customisation options
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # yubikey login / sudo
  security.pam = {
    # Let users use yubikey to SSH
    # sshAgentAuth.enable = true;

    # 2FA
    u2f = {
      enable = true;

      settings = {
        # Tells user they need to press the yubikey button
        cue = false;  # Customise at the user level
      };
    };

     # Set services that can use 2FA
    services = {
      login = {
        u2fAuth = true;
        # sshAgentAuth = false;
      };
      sudo = {
        u2fAuth = true;
        # sshAgentAuth = true;
      };
    };
  };
}

# https://github.com/EmergentMind/nix-config/blob/dev/modules/hosts/common/yubikey.nix