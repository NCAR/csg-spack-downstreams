# Spack Upstreams Installation Utility
Repository containing a spack installation utility for NCAR Systems.

## Basic usage:
./spack-upstream.sh <subcommand>

Spack upstreams has several subcommands that can be used to install and remove a downstream instance of spack. The subcommands for spack upstreams are the following:
```
install
remove
```

The __install__ subcommand will install a compatable version of spack with the upstream installation in the users work directory. Users can specify the installation directory with the `--prefix=<install-path>` flag. 

Once the installation has completed, spack-upstreams will attempt to modify the user's `.bashrc` to automatically load spack into the user's enviornment in login.
If the user chooses to skip this option, on login they will need to run:
`<install-directory>/share/spack/setup-env.sh`

The __remove__ subcommand will remove the users spack upstream installation as well as clear out any references to the installation in the user's `.bashrc`. Prefixed installations can be specified with the --install-path flag.

## Optional flags:
```
install:
       -v | --verbose                     : print out each installation step to the terminal
            --prefix=<install-path>       : specify spack installation location. Default: /glade/work/mtrahan/spack_version  
            --modify-rc=<True|False>.     : modify .bashrc to load Spack at startup
            --version=<ncarenv-version>   : specify ncarenv version. Default: default
       -h | --help                        : print this message
remove:
       -v | --verbose                     : print out each installation step to the terminal"
            --install-path=<install-path> : target spack installation location. Default: /glade/work/$USER/ncarenv-$VERSION"
       -h | --help                        : print this message"
```

## Known Issues:
- No tcsh or csh support

