{ den, ... }:
{
  den.aspects.dragonfly = {
    includes = [
      den.aspects.base-host
    ];
  };
  den.hosts.x86_64-linux.dragonfly = {
    hardware = { cpu = "intel"; storage = [ "ssd" ]; };
    users.andrec = { };
  };
}
