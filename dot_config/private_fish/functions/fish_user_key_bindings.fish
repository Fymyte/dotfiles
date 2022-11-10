function fish_user_key_bindings
  bind \cy accept-autosuggestion and execute
  bind --mode insert \cy accept-autosuggestion and execute

  bind \ci beginning-of-line
  bind --mode insert \ca beginning-of-line

  bind \ca end-of-line
end
