#!/bin/bash

stack_build () {
    stack build
}

site_rebuild () {
    stack exec site rebuild
}

site_serve () {
    stack exec site watch
}


main () {    
    if [[ $1 == "-s" ]]
    then
        stack_build
        site_rebuild
        site_serve
    else 
        stack_build
        site_rebuild
    fi
}

main $1