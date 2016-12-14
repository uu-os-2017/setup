#!/usr/bin/env bash

command_exists () {
    hash "$1" &> /dev/null ;
}

setup_stack () {
    echo -n "The (Haskell) stack build tool is "

    if command_exists stack ; then
        echo "already installed."
        stack --version
    else
        echo "not installed"
        echo
        echo "Installing stack ..."
        echo

        wget -qO- https://get.haskellstack.org/ | sh
    fi

}

setup_git () {
    echo -n "The git tool is "

    if command_exists git ; then
        echo "already installed"
        git --version
    else
        echo "not installed"
        echo
        echo "Installing git ..."
        echo

        sudo apt-get update
        sudo apt-get install git
    fi
}

setup_filter () {
    echo -n "The filter tool is "

    if command_exists filter ; then
        echo "already installed."
        which filter
    else
        echo "not installed."
        echo
        echo "Building and installing filter ..."
        echo

        # http://unix.stackexchange.com/a/84980
        tmpdir=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`

        echo
        echo "Building filter in $tmpdir"
        echo
        cd $tmpdir
        git clone https://github.com/kamar535/filter.git

        cd filter
        stack setup
        stack build
        stack install
        cd ../..
        rm -rf $tmpdir
    fi
}

setup_stack
setup_git
setup_filter
