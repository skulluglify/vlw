#! /usr/bin/env bash

modules=/usr/share/lua/5.3/:/usr/local/share/lua/5.3/

args=$@

i=0

DEVMODE=0

#? ls -lh $(dirname $(pwd)) | grep $(basename $(pwd)) | cut -d ' ' -f1
#? drwxrwxr-x drwxr-xr-x

mkdir -p modules
touch modules/init.lua
echo "#! $(which env) lua" >modules/init.lua
cat << EOF >>modules/init.lua
package.path = package.path..';$(pwd)modules/?/init.o;$(pwd)modules/?.o'
package.path = package.path..';$(pwd)modules/?/init.lua;$(pwd)modules/?.lua'
package.path = package.path..';$(pwd)/?/init.o;$(pwd)/?.o'
package.path = package.path..';$(pwd)/?/init.lua;$(pwd)/?.lua'
EOF

function fstring () {
    fpath=$1
    lchar=${#fpath}
    lchar=$(($lchar - 1))
    lchar=${fpath:$lchar}
    if [ $lchar != \/ ]; then
        echo $fpath/
    else
        echo $fpath
    fi
}

function copy_paste () {
    echo -e "\033[1;30;42m copy \033[1;32;40m ${2} \033[0m"
    if [ $(readlink $1) ]; then
        cp -r $(readlink -f $1) modules/$2
    else
        cp -r $1 modules/$2
    fi
}

function lua_compiler () {
    if [ -f modules/$1 -a -n "$(echo $1 | grep -E '\.lua$')" ]; then
        echo -e "\033[1;30;43m compile \033[1;32;40m ${1} \033[0m"
        luac -o $(echo modules/$1 | sed 's/\.lua/\.o/g') modules/$1
    fi
}

function eraser_source () {
    if [ $DEVMODE -eq 0 ]; then
        echo -e "\033[1;36;41m erase \033[1;32;40m ${1} \033[0m"
        rm -rf modules/$1
    fi
}

function loaded_module () {
    n=${#1}
    if [ -z "$(echo $args | grep -E '\-L|\-load|\-\-load')" ]; then
        s=$(echo $args | cut -d ' ' -f$(($i + 2))- | sed 's/ /|/g')
    else
        s=$(echo $args | cut -d ' ' -f$(($i + 3))- | sed 's/ /|/g')
    fi
    if [ -n "$s" ]; then
        for x in $(find $1 -type f,l); do
            if [ -f $x -a -z "$(echo $x | grep 'luarocks')" -a -n "$(echo $x | grep -E "$s")" ]; then
                fname=$(basename $x)
                dirnames=$(dirname $x)
                dirnames=${dirnames:$n}
                if [ $dirnames ]; then
                    if [ -f modules/$dirnames/$fname -o -f modules/$dirnames/$(echo $fname | sed 's/\.lua/\.o/g') ]; then
                        echo -e "\033[1;30;43m already \033[1;32;40m ${dirnames}/${fname} \033[0m"
                    else
                        echo -e "\033[1;30;43m make \033[1;32;40m ${dirnames} \033[0m"
                        mkdir -p modules/$dirnames
                        copy_paste $x $dirnames/$fname
                        lua_compiler $dirnames/$fname
                        eraser_source $dirnames/$fname
                    fi
                else
                    if [ -f modules/$fname -o -f modules/$(echo $fname | sed 's/\.lua/\.o/g') ]; then
                        echo -e "\033[1;30;43m already \033[1;32;40m ${fname} \033[0m"
                    else
                        copy_paste $x $fname
                        lua_compiler $fname
                        eraser_source $fname
                    fi
                fi
            fi
        done
    fi
    findall=$(find modules/ -type f,l)
    for x in $(echo $s | sed 's/|/ /g'); do
        if [ -z "$(echo $findall | grep "$x")" ]; then
            echo -e "\033[1;37;41m unknown \033[1;32;40m ${x} \033[0m"
        fi
    done
}

function main () {
    for x in $(echo $modules | sed 's/:/ /g'); do
        if [ -d $x ]; then
            loaded_module $(fstring $x)
        fi
    done
}

for x in $args; do
    case $x in
        -d|-dev|--dev)
            echo "development mode" && DEVMODE=1
        ;;
        -h|--help)
            echo "loaded_module lua in local source"
            echo 
            echo "bash loaded_module.sh [option] [option] pkgs"
            echo 
            echo " -d -dev --dev "
            echo "    enable development mode"
            echo 
            echo " -h --help "
            echo "    helper"
            echo 
            echo " -L -load --load "
            echo "    [option] [src] load source with path"
            echo 
            echo " -s -source --local-source "
            echo "    default path /usr/share/lua/5.3/:/usr/local/share/lua/5.3/"
            echo 
            break
        ;;
        -L|-load|--load)
            src=$(echo $args | cut -d ' ' -f$(($i + 2)))
            if [ $src ]; then
                modules=$src && main
                break
            else
                echo -en "\033[1;31m try again. \033[0m\n" && exit 1
            fi
        ;;
        -s|-source|--local-source)
            main && break
        ;;
        *)
            echo -en "\033[1;33m unknown format arguments input! \033[0m\n" && exit 1
        ;;
    esac
    i=$(($i + 1))
done
