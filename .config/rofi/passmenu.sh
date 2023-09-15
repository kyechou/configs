#!/bin/bash

shopt -s nullglob globstar

# switch for autotyping
typeit=0
if [[ $1 == "--type" ]]; then
    typeit=1
    shift
fi

dotool="dotoolc"

# get all the saved password files
prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=("$prefix"/**/*.gpg)
password_files=("${password_files[@]#"$prefix"/}")
password_files=("${password_files[@]%.gpg}")

# shows a list of all password files and saved the selected one in a variable
password=$(printf '%s\n' "${password_files[@]}" | rofi -dmenu "$@")
[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
    # pass -c copied the password in clipboard. The additional output from pass
    # is piped in to /dev/null
    pass show -c "$password" 2>/dev/null
else
    pass show "$password" | {
        IFS= read -r pass
        printf "type %s\n" "$pass"
    } | $dotool
fi
