{ den, ... }:
{
  den.aspects.apps.discord = {
    includes = [
      (den.batteries.unfree [
        "discord"
        "discord-unwrapped"
      ])
    ];
    homeManager = {
      programs = {
        concord.enable = true;
        discord.enable = true;
      };

    };
  };
}
