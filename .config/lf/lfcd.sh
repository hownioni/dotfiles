# shellcheck shell=sh

lf() {
	# shellcheck disable=SC2164
	cd "$(command lf -print-last-dir "$@")"
}
