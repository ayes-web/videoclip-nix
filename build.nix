{
  pkgs,
  lib,
  ...
}:
pkgs.stdenvNoCC.mkDerivation rec {
  name = "mpv-videoclip";
  pname = name;

  src = pkgs.fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "videoclip";
    rev = "master";
    sha256 = "sha256-VP+NlGRltGeeXRxhoDUZEp/xF9MEl0zu7g8AfeuNByc";
  };

  dontBuild = true;

  patchPhase =
    ''
      substituteInPlace platform.lua \
      --replace \'curl\' \'${lib.getExe pkgs.curl}\' \
    ''
    + lib.optionalString pkgs.stdenv.isLinux ''
      --replace xclip ${lib.getExe pkgs.xclip} \
      --replace wl-copy ${lib.getBin pkgs.wl-clipboard}/bin/wl-copy
    '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/mpv/scripts/videoclip
    cp *.lua $out/share/mpv/scripts/videoclip
    runHook postInstall
  '';

  passthru.scriptName = "videoclip";

  meta = with lib; {
    description = "Easily create videoclips with mpv.";
    homepage = "https://github.com/Ajatt-Tools/videoclip";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
