# Spack Upstreams Installation Utility
Repository containing a spack installation utility for the NCAR Gust Test System.

## Basic usage:
./spack-upstream.sh

By default the application will install a compatible version of spack with the upstream installation in the users work directory. Users can specify the installation directory with the `--prefix=<install-path>` flag. 

Once the installation has completed, spack-upstreams will attempt to modify the user's `.bashrc` to automatically load spack into the user's environment in login.
If the user chooses to skip this option, on login they will need to run:
`<install-directory>/share/spack/setup-env.sh`

## Optional flags:
```
       -v | --verbose                   : print out each installation step to the terminal
            --prefix=<install-path>     : specify spack installation location. Default: /glade/work/mtrahan/spack_version  
            --modify-rc=<True|False>.   : modify .bashrc to load Spack at startup
            --version=<ncarenv-version> : specify ncarenv version. Default: default
       -h | --help                      : print this message
```

## Know bugs:
- No tcsh or csh support yet.

