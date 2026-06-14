{ config, lib, ... }: {

  options.colors = lib.mkOption {
    type = lib.types.attrs;
    default = {
      # primary
      black = "#000000";
      white = "#ffffff";
      # secondary
      afghani-blue = "#4d6fb7";
      argentinian-blue = "#5fb8f2";
      # accent
      italian-violet = "#aaa1f6";
      indian-gold = "#cbaa4b";
      chinese-magenta = "#d991d2";
      persian-orange = "#e99861";
      zambia-green = "#6fc488";
      norwegian-pink = "#f08d94";
      # tints
      bright-black = "#0b0b0b";
      bright-white = "#eeeeee";
      bright-afghani-blue = "#b7cefd";
      bright-argentinian-blue = "#a4d5f7";
      bright-italian-violet = "#cbc7fa";
      bright-indian-gold = "#dfcc99";
      bright-chinese-magenta = "#e9bee4";
      bright-persian-orange = "#f3c2a3";
      bright-zambia-green = "#acdcb8";
      bright-norwegian-pink = "#f8bcbe";
    };
  };

}
