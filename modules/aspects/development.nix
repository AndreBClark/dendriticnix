{ den, ... }:
{
  den.aspects.development = {
    includes = builtins.attrValues {
      inherit (den.aspects)
        terminal
        cli
        nvim
        ;
    };
  };
}
