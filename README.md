# Line-by-line script execution

Dependencies:
- fzf

***

## For zsh

```shell
print -z $(cat arch_install.sh | fzf)
```

## For bash

`script_prompt_write.sh`

```shell
prompt_write() {
	[[ -t 0 ]] || return 1
	local str=$1
	str=${str//\\/\\\\}
	str=${str//\"/\\\"}
	[[ $2 == 'clear' ]] && str='\e[1;5C\C-u'$str
	bind '"\e[0n":"'"$str"'"'
	printf '\e[5n'
}
```

### Example of use:

```shell
source ./script_prompt_write.sh

prompt_write "$(cat ./arch_install.sh | fzf )"
```
