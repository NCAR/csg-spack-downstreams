# Spack Downstream Installation Utility
Repository containing a chained Spack installation setup utility for the NCAR HPC Systems.

## Basic usage:
./spack-downstream

By default the application will install a compatable version of Spack with the upstream installation in the users work directory. Users can specify the installation directory with the `--downstream-root=PATH` flag.

Once the installation has completed, spack-downstreams will attempt to modify the user's `.bashrc` to automatically load Spack into the user's enviornment in login.
If the user chooses to skip this option, on login they will need to run:
`. $SPACK_ROOT/share/spack/setup-env.sh`

## Optional flags:
```
    -h, --help                      print this message
    --downstream-root=PATH          specify installation location for downstreams.
                                    (default: /glade/work/$USER/spack-downstreams)
    --modify-rc=<True|False>        modify your startup script to automatically load Spack at startup
    --upstream-version=VERSION      specify alternate ncarenv version. (default: $NCAR_ENV_VERSION)"
    -v, --verbose                   print out each installation step to the terminal
```

## Known bugs and limitations:
- RC modification can only be done when the downstream is created.
