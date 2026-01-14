# shellcheck shell=bash

dotdata_dir="$HOME/.local/share/dotfiles"
vars_file="$dotdata_dir/vars"
# shellcheck disable=SC2034
templates="$dotdata_dir/templates"
# shellcheck disable=SC2034
hostneim="$(hostnamectl hostname)"

printerr() {
	local red='\033[0;31m'
	local nc='\033[0m' # No Color
	local type="${1^^}"
	shift
	printf '%b%s: %s%b\n' "$red" "$type" "$*" "$nc" >&2
}

printinfo() {
	local green='\033[0;32m'
	local nc='\033[0m' # No Color
	printf '%b%s%b\n' "$green" "$*" "$nc" >&2
}

check_var() {
	local var="$1"
	[[ -f "$vars_file" ]] && grep -q "^<${var}>" "$vars_file"
}

create_var() {
	local var="$1"
	local value="$2"

	if [[ ! -f "$vars_file" ]] || ! check_var "$var"; then
		printf "<%s> %s\n" "$var" "$value" >>"$vars_file"
	else
		local temp_file
		temp_file="$(mktemp)"
		awk -v var="$var" -v value="$value" \
			'$1 == "<" var ">" {$2 = value} {print}' "$vars_file" \
			>"$temp_file"
		mv "$temp_file" "$vars_file"
	fi
}

get_var() {
	local var="$1"
	if [[ -f "$vars_file" ]]; then
		awk -v var="$var" \
			'$1 == "<" var ">" {print $2; exit}' "$vars_file"
	fi
}

replace_template() {
	local placeholder="$1"
	local value="$2"
	local template="$3"
	local location

	if [[ ! -f "$template" ]]; then
		printerr "WARNING" "Template file not found: $template"
		return 1
	fi

	location="$HOME/$(awk '/<location>/{print $2; exit}' "$template" 2>/dev/null)"

	if [[ -z "$location" ]]; then
		printerr "WARNING" "No location found in template: $template"
		return 1
	fi

	mkdir -p "${location%/*}"

	if grep -q "$placeholder" "$template"; then
		sed '/<location>/,+1 d' "$template" \
			| sed "s/${placeholder}/${value}/g" >"$location"
	fi
}
