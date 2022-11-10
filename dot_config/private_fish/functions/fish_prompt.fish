function fish_prompt
  set -l cwd (prompt_pwd)

  set -l normal_color     (set_color normal)
  set -l arrows_color     (set_color 8787FF)
  set -l directory_color  (set_color 0087D7)
  set -l last_color

  echo -n -s $directory_color $cwd $normal_color

  switch $fish_bind_mode
    case default
      echo -n -s (set_color --bold red) " » " $normal_color
    case insert
      echo -n -s $arrows_color " » " $normal_color
    case replace_one
      echo -n -s (set_color --bold green) " » " $normal_color
    case visual
      set_color --bold brmagenta
      echo -n -s (set_color --bold brmagenta) " » " $normal_color
    case '*'
      echo -n -s (set_color --bold red) " » " $normal_color
  end
  set_color normal
end
