{lib}: {
  relativeToRoot = lib.path.append ../.;

  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          # include all directories and nix file except default.nix
          path: _type:
            (_type == "directory")
            || ((lib.strings.hasSuffix ".nix" path) && (path != "default.nix"))
        ) (builtins.readDir path)
      )
    );
}
