{ config, pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "jdlkkmamiaikhfampledjnhhkbeifokk"; } # PDF Viewer
    ];
  };
}
