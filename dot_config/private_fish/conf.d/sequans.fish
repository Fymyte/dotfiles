if test "$hostname" = 'minibian' || test "$hostname" = 'pandora'
  set -gx GL_HOST gitlab-shared.sequans.com
  fish_add_path --global "/opt/soft/toolchains64/aarch64-none-linux-gnu/bin/"
  fish_add_path "$HOME/.local/bin/cmake/bin"
  fish_add_path "/opt/soft/toolchains64/aarch64-unknown-elf/bin/"
end
