{
  nixosTest,
  curl,
}:
nixosTest {
  name = "nixos-test";
  nodes.machine = {...}: {
    services.gitea = {
      enable = true;
    };

    environment.systemPackages = [
      curl
    ];
  };
  testScript =
    /*
    python
    */
    ''
      machine.start()
      machine.wait_for_unit("multi-user.target")
      machine.wait_for_open_port(3000)
      machine.succeed("curl localhost:3000")
    '';
}
