# Spack Upstreams Installation Utility
Repository containing a spack installation utility for the NCAR Gust Test System.

## Installation:
./spack-upstream.sh

By default the application will install a compatable version of spack with the upstream installation in the users work directory. Users can specify the installation directory with the `--prefix=<install-path>` flag. 

Once the installation has completed, spack-upstreams will attempt to modify the user's `.bashrc` to automatically load spack into the user's enviornment in login.
If the user chooses to skip this option, on login they will need to run:
`<install-directory>/share/spack/setup-env.sh`

## Know bugs:
- No tcsh or csh support yet.
- The script will fail if a folder named spack-<install-version> currently exists in your work or chosen directory. Error checking and overwriting will be implemented as options in the future.
