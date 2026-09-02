{ den, lib, ... }:
let
  profileType = lib.types.submodule (
    { name, ... }:
    {
      freeformType = lib.types.attrsOf lib.types.anything;
      imports = [ den.schema.profile ];
      options.name = lib.mkOption {
        type = lib.types.str;
        default = name;
      };
    }
  );
in
{
  options.den.profiles = lib.mkOption {
    type = lib.types.attrsOf profileType;
    default = { };
  };
}
