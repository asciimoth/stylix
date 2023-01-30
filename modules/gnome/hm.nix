{ pkgs, config, lib, ... }:

with lib;

{
  options.stylix.targets.gnome.enable =
    config.lib.stylix.mkEnableTarget "GNOME" true;

  config = mkIf config.stylix.targets.gnome.enable {
    dconf.settings = {
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file://${config.stylix.image}";
        picture-uri-dark = "file://${config.stylix.image}";
      };

      # We show the same colours regardless of this setting, and the quick
      # settings tile is removed. The value is still used by Epiphany to
      # request dark mode for websites which support it.
      "org/gnome/desktop/interface".color-scheme =
        if config.stylix.polarity == "dark"
        then "prefer-dark"
        else "default";
    };
  };
}
