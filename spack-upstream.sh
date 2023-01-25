#!/bin/bash

# Spack Upstream installation script

print_usage () {
    echo "spack-upstream-setup.sh: Script to set up a local spack instance and link it to the upstream system spack"
    echo "usage:"
    echo "       -v | --verbose                  : print out each installation step to the terminal"
    echo "            --prefix                   : specify spack installation location. Default: /glade/work/$USER/spack_version"
    echo "            --version=<install-path>   : install a specific version of spack (default: latest)"
    echo "            --modify-rc=<True|False>   : modify your startup script to automatically load Spack at startup"
    # echo "            --modules"
    # echo "            --sync"
    echo "       -h | --help                     : print this message"
    
}

log () {
    if [ "$VERBOSE" = "True" ]; then
        echo "$@"
    fi
}

copy_yaml () {
     # Check to see if yaml files exist. If not clone them to the directory.
    for file in compilers.yaml mirrors.yaml packages.yaml repos.yaml; do
        if [ ! -f "$INSTALL_DIR/etc/spack/$file" ]; then
            log "cp /glade/u/apps/gust/default/config/$file $INSTALL_DIR/etc/spack"
            cp /glade/u/apps/gust/default/config/$file $INSTALL_DIR/etc/spack
        fi
    done

    # Check to see if upstreams has been created. If not create it and fill it with the following values.
    if [ ! -f "$INSTALL_DIR/etc/spack/upstreams.yaml" ]; then 

        log "echo 'upstreams:'  >> $INSTALL_DIR/etc/spack/upstreams.yaml"
        log "echo '  spack-instance-1:' >> $INSTALL_DIR/etc/spack/upstreams.yaml"
        log "echo '    install_tree: /glade/u/apps/gust/default/spack/opt/spack/' >> $INSTALL_DIR/etc/spack/upstreams.yaml"

        echo 'upstreams:'  >> $INSTALL_DIR/etc/spack/upstreams.yaml
        echo '  spack-instance-1:' >> $INSTALL_DIR/etc/spack/upstreams.yaml
        echo '    install_tree: /glade/u/apps/gust/default/spack/opt/spack/' >> $INSTALL_DIR/etc/spack/upstreams.yaml
    fi
}

modify_rc () {
    echo "Modifying bashrc..."

    log "echo '# SPACK UPSTREAMS INITIALIZE' >> ~/.bashrc"
    log "echo '. $INSTALL_DIR/share/spack/setup-env.sh' >> ~/.bashrc"
    log "echo '# SPACK UPSTREAMS DONE' >> ~/.bashrc"

    echo "# SPACK UPSTREAMS INITIALIZE" >> ~/.bashrc
    echo ". $INSTALL_DIR/share/spack/setup-env.sh" >> ~/.bashrc
    echo "# SPACK UPSTREAMS DONE" >> ~/.bashrc

    echo '...complete!'
}

# Simple flag parser
while [ "$#" -gt 0 ]
do
    case "${1}" in
        (--prefix?*)     PREFIX="${2}"; shift ;;
        (-v | --verbose) VERBOSE="True" ;;
        (-h | --help)    print_usage; exit 0 ;;
        (--modify-rc?*)  MODIFY_RC="${2}"; shift ;;
        (--version?*)    VERSION="${2}"; shift ;;
        (*)              echo "spack-upstream error: unrecognized option ${1}"; print_usage; exit 1 ;;
    esac
    shift
done

# Temporary Version Identifier
if [ -z $VERSION ]; then
    VERSION=$(echo "$(/glade/u/apps/gust/default/spack/bin/spack --version | grep -o '[0-9]*\.[0-9]*\.[0-9]*')") 
fi
echo "Spack version: $VERSION"

# Set install path
if [ -z $PREFIX ]; then
    INSTALL_DIR="/glade/work/$USER/spack-$VERSION"
else
    INSTALL_DIR=$PREFIX
fi
echo "Prefix: $INSTALL_DIR"

# Clone repo, copy yaml, and modify rc
log "git clone https://github.com/spack/spack.git --branch v$VERSION $INSTALL_DIR"
git clone https://github.com/spack/spack.git --branch v$VERSION $INSTALL_DIR
copy_yaml 

echo "Spack has been successfully installed and configure for upstream use in: $INSTALL_DIR"

if [ "MODIFY_RC" = "True" ]; then
    modify_rc
elif [ "MODIFY_RC" = "False" ]; then
    exit 0
else
    echo "Would you like this installer to automatically initialize spack on log in by modifying .bashrc?"
    echo "(y|n)"
    while true; do
        read MOD
        if [ $MOD == 'y' ]; then
            modify_rc
            exit 0
        elif [ $MOD == 'n']; then
            echo "To initialize your shell for spack use please run the command:"
            echo ". $INSTALL_DIR/share/spack/setup-env.sh"
            exit 0
        else
            echo "Please select (y)es|(n)o"
        done
fi

# https://github.com/NCAR/csg-spack-fork