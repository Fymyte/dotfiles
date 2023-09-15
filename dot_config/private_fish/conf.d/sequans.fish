if test "$hostname" = 'minibian' || test "$hostname" = 'pandora' || test "$hostname" = 'snorlax'
  set -gx GL_HOST gitlab-shared.sequans.com
  fish_add_path "/opt/soft/toolchains64/aarch64-none-linux-gnu/bin/"
  fish_add_path "/opt/soft/toolchains64/aarch64-unknown-elf/bin/"

  set -gx COSERVER snorlax
  set -gx MY_PORT 60083

  bass source ~/dev/source-ARM-FM.sh > /dev/null
end
