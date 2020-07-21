unset -f cd
function cd () {
    local -i maxnrDirs=7
    local -i nrDirs=0     # index of dirs as shown to user
    local visited=()
    local -i founddir=0

    # if argument is directory , change directory
    if [ -d "$1" ]; then
        pushd "$1" > /dev/null;
    else
        for ((i=0; i < ${#DIRSTACK[@]}; i++)); do
            # skip the first one $i == 0 current directory
            if (( $i > 0 )); then
                # keep track of already listed directories,
                # Note, should be done with associative array
                # this was on my TODO list for 20 years
                local -i found=0
                for ((j=0; j < ${#visited[@]}; j++)); do
                    if [[ ${visited[$j]} == ${DIRSTACK[${i}]} ]]
                    then
                        found=17
                        break
                    fi
                done
                # handle directory option if not found
                if [ $found == 0 ] ; then
                    ((nrDirs+=1))
                    # if there is no argument to cd, list previous dirs
                    if [ -z "$1" ]; then
                        founddir=17
                        echo " $nrDirs ${DIRSTACK[$i]}";
                    # if there is a number argument, check against DIRSTACK
                    else
                        if [ "$1" == ${nrDirs} ]; then
                            if [ "${DIRSTACK[${i}]}" ]; then
                                if [ -d "`dirs -l +${i}`" ]; then
                                    pushd "`dirs -l +${i}`" > /dev/null ;
                                    founddir=${i};
                                fi;
                            fi;
                        fi;
                    fi
                    local dir=${DIRSTACK[$i]}
                    visited+=("$dir")          # visited+=("${DIRSTACK[$i]}") does not work
                    if [ $nrDirs == $maxnrDirs ]; then
                        break;
                    fi
                fi;
            fi
        done;
        if [ ${founddir} == 0 ]; then
            # Handle special characters, invent new ones ....?
            if [ "$1" == - ]; then
                pushd `dirs -l +1` > /dev/null;
            elif [ "$1" == ... ]; then
                if [ -d "../../" ]; then
                    pushd "../../" > /dev/null ;
                fi
            elif [ "$1" == .... ]; then
                if [ -d "../../../" ]; then
                    pushd "../../../" > /dev/null ;
                fi
            elif [ ! -z "$1" ]; then
                # error message, TODO check \ ??
                echo ${1} not a valid directory;
            fi;
        fi;
    fi
}
