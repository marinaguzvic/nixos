# NixOS Configuration

## Quick Start

```bash
sudo nixos-rebuild switch --flake /etc/nixos#hp-linux
```

---

## Adding New Modules

### Home Manager module (user-level: packages, dotfiles, programs)

1. **Create** `modules/home-manager/my-module.nix`:

   ```nix
   { config, pkgs, ... }:

   {
     home.packages = [ pkgs.some-tool ];
     # or programs.foo = { enable = true; ... };
   }
   ```

2. **Import** in `hosts/<host>/home.nix`:

   ```nix
   imports = [
     # ...
     ../../modules/home-manager/my-module.nix
   ];
   ```

3. **(Optional)** Add to `flake.nix` under `flake.homeModules` for reuse:

   ```nix
   flake.homeModules = {
     # ...
     my-module = ./modules/home-manager/my-module.nix;
   };
   ```

### NixOS module (system-level: services, boot, networking)

1. **Create** `modules/nixos/my-module.nix`:

   ```nix
   { config, pkgs, ... }:

   {
     services.my-service.enable = true;
     # or boot., networking., etc.
   }
   ```

2. **Import** in `hosts/<host>/configuration.nix`:

   ```nix
   imports = [
     # ...
     ../../modules/nixos/my-module.nix
   ];
   ```

### Important: stage new files

Nix flakes only see tracked files. After adding new modules:

```bash
git add modules/
```

Then run `nixos-rebuild switch` again.
