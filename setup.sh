#!/bin/bash

set -eu

function usage() {
	cat << EOF
Build a Conda environment and install awesome-package into it.

Usage:

./setup.sh [-b] [-c] [-a] [-h]

Flags
-----
-h    Print out usage information
-c    Build Conda environment (or update one if it exists)
-b    Install Python package including Rust extensions
-a    Equivalent to using both -b and -c

EOF

}

if [[ ${OSTYPE:-os} == *darwin* ]]; then
    # Implementation of `readlink` in macOS differs from Linux's
    function readlink() {
        python -c 'import os,sys;print(os.path.realpath(sys.argv[2]))' "$@"
    }
fi

THIS_DIR="$(dirname "$(readlink -f "$0")")"
ENV_DIR="${THIS_DIR}/.env"

INSTALL_OR_UPDATE=false
BUILD=false
while getopts ":cbha" opt; do
    case ${opt} in
        c )
            INSTALL_OR_UPDATE=true
            ;;
        b )
            BUILD=true
            ;;
        a )
            INSTALL_OR_UPDATE=true
            BUILD=true
            ;;
        h )
            usage
            exit 0
            ;;
        \? )
            echo "Invalid option: -${OPTARG}"
            usage
            exit 1
            ;;
    esac
done

if [[ ${INSTALL_OR_UPDATE} == "true" ]]; then
    conda="${CONDA_LOCATION:-conda}"
    action="create"
    if [[ -e "${ENV_DIR}" ]]; then
        action="update"
    fi
    ENVYAML="${THIS_DIR}/conda_environment.yaml"
    ${conda} env ${action} -p "${ENV_DIR}" --file "${ENVYAML}"
fi

if [[ ${BUILD} == "true" ]]; then
    pushd "${THIS_DIR}"/awesome_package_dev
    "${ENV_DIR}"/bin/python setup.py develop
    popd
fi
