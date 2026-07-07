{...}: {
  programs.niri.monitors = [
    ''
      output "PNP(AOC) 2460G4 0x000028EA" {
        mode "1920x1080@144.001"
        position x=0 y=0
        variable-refresh-rate on-demand=true
        transform "270"
        layout {
          preset-column-widths {
              proportion 0.5
              proportion 1.0
          }
          default-column-width { proportion 1.0; }
        }
      }''

    ''
      output "PNP(BNQ) BenQ EX3501R 85K00663019" {
        mode "3440x1440@99.982"
        variable-refresh-rate on-demand=true
        position x=1080 y=250
        focus-at-startup
      }
    ''
  ];
}
