{
  lib,
  config,
  ...
}: let
  litellm-sops-secret = "litellm-api-key";
  litellm-api-key-file = "litellm-api-key.txt";
in {
  sops.secrets."${litellm-sops-secret}" = {sopsFile = lib.custom.relativeToRoot "secrets/hosts/snorlax.yaml";};
  sops.templates."${litellm-api-key-file}".content = config.sops.placeholder."${litellm-sops-secret}";

  programs.opencode = {
    settings = {
      provider = {
        sequans-litellm = {
          npm = "@ai-sdk/openai-compatible";
          name = "LiteLLM Sequans";
          options = {
            baseURL = "https://litellm.sequans.com/v1";
            apiKey = "{file:${config.sops.templates."${litellm-api-key-file}".path}}";
          };
          models = {
            "gemini-3.1-pro" = {
              name = "Gemini 3.1 Pro";
            };
            "gemini-3.1-flash" = {
              name = "Gemini 3.1 Flash";
            };
            "gemini-3.1-flash-lite" = {
              name = "Gemini 3.1 Flash (Lite)";
            };
          };
        };
      };
      model = "sequans-litellm/gemini-3.1-flash";
    };
  };
}
