# videoclip mpv plugin nix flake package
Nix package for https://github.com/Ajatt-Tools/videoclip

## Using with home-manager

```nix
programs.mpv = {
    enable = true;
    scripts = [
        (builtins.getFlake "github:BatteredBunny/videoclip-nix").packages.${builtins.currentSystem}.default
    ];
};
```
