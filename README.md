# AR.IO Gateway deployment via NixOS

## Convert Cloud Instancee to NixOS

If you don't have NixOS installed on your instance,
you can convert it to NixOS with the `install` script,
which will use nixos-anywhere/kexec to convert your instance.

### Prerequisites

- A cloud instance that runs a reasonably modern Linux distribution.
- Root SSH access to said cloud instance
- [Kexec](https://en.wikipedia.org/wiki/Kexec)

### Setup

Create a `vars.nix` file that contains your public keys and environment variables.

```nix
{
  sshKeys = [
    "..."
  ];
  environment = {
    ARNS_ROOT_HOST = "example.com";
    AR_IO_WALLET = "...";
  };
}
```

### Install NixOS

Run the following command:

    scripts/install root@hostname

This will install NixOS and the AR.IO gateway.

## Update Gateway
