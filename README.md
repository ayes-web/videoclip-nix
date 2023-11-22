# videoclip mpv plugin nix flake package
Nix package for https://github.com/Ajatt-Tools/videoclip

## Using with home-manager

```nix
programs.mpv = {
    enable = true;
    scripts = [
        (builtins.getFlake "github:ayes-web/videoclip-nix").packages.${builtins.currentSystem}.default
    ];
};
```
