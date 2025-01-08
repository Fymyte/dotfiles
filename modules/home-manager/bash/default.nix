{...}: {
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
    historySize = 100000;
    historyFileSize = 100000;
    historyControl = ["ignoreboth"];
  };
}
