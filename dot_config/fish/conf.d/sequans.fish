if test "$hostname" = 'minibian' || test "$hostname" = 'pandora' || test "$hostname" = 'snorlax'
  set -gx GL_HOST gitlab-shared.sequans.com
  # fish_add_path "/opt/soft/toolchains64/aarch64-none-linux-gnu/bin/"
  # fish_add_path "/opt/soft/toolchains64/aarch64-unknown-elf/bin/"
  # fish_add_path "/opt/soft/toolchains64/arm-none-eabi/bin/"

  set -gx COSERVER snorlax
  set -gx MY_PORT 60083

  bass source ~/dev/source-ARM-FM.sh > /dev/null

  set -gx ZEPHYR_BASE "$HOME/dev/sqn/sqn-sdk/zephyr/"
  bass source "$HOME/dev/sqn/sqn-sdk/tools/scriptkit/python/python-env.sh"

  fish_add_path "$HOME/dev/sqn/sqn-sdk/tools/scriptkit/bash/"
  # fish_add_path "$HOME/x-tools/aarch64-sqn50xxnofp-elf/bin"
end
