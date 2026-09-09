{ den, ... }:
{
  den.aspects.development = {
    includes = builtins.attrValues {
      inherit (den.aspects)
        terminal
        shell
        cli
        nvim
        my-packages
        ;
    };
  };
}
