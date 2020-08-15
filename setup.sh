#!/bin/bash

set -eu

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
while getopts ":cb" opt; do
    case ${opt} in
        c )
        	INSTALL_OR_UPDATE=true
          	;;
        b )
        	BUILD=true
            ;;
        \? )
        	echo "Usage: bash setup.sh [-c] [-b]"
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
