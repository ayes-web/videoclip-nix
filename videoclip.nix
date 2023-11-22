{
  pkgs,
  lib,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "videoclip";
  version = "unstable-2023-11-01";

  src = pkgs.fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "videoclip";
    rev = "509b6b624592dbac6f2d7e0c4bc92a76460e7129";
    hash = "sha256-fMuoBWM0bmRhdRoGxLYsqBjy2H+AVwOvVeva3SBR/EA=";
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
