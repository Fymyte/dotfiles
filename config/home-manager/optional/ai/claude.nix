{pkgs, ...}: {
  programs.mcp.servers = {
    Gitlab = {
        url = "https://gitlab-shared.sequans.com/api/v4/mcp";
    };
  };

  programs.claude-code = {
    enable = true;
    package = pkgs.nixpkgs-master.claude-code;
    enableMcpIntegration = true;
  };
}
