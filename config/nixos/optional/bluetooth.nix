{...}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Name = "Internal";
      FastConnectable = "true";
      Experimental = "true";
    };
    Policy = {
      AutoEnable = "true";
    };
  };
}
