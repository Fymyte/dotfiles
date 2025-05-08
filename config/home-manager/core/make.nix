{...}: {
  home.sessionVariables = {
    MAKEFLAGS = "$MAKEFLAGS --no-print-directory -j$(nproc)";
  };
}
