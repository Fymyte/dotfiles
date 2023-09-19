function fish_right_prompt
  set -l last_status $status

  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄ "
  set -l dirty    "*"
  set -l clean     "✓"

  set -l normal_color (set_color normal)
  set -l error_color (set_color red)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)
  set -l repo_ditry_color (set_color brRed)
  set -l repo_clean_color (set_color green)
  set -l paren_color  (set_color blue)

  if [ $last_status -ne 0 ]
    echo -n -s $error_color $last_status " ↵ " $normal_color
  end

  if git_is_repo

    echo -n -s $paren_color "("
    echo -n -s $repository_color (git_branch_name)
    if git_is_touched
      echo -n -s $repo_ditry_color $dirty
    else
      echo -n -s $repo_clean_color $clean
    end
    echo -n -s $paren_color ")" $normal_color

    set_color normal
  end
end
