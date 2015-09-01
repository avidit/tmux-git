#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

git_branch="#($CURRENT_DIR/scripts/branch.sh)"
git_branch_interpolation="\#{git_branch}"

interpolate_variables() {
	local string=$1
	local interpolated=${string/$git_branch_interpolation/$git_branch}

	echo $interpolated
}

interpolate_tmux_option() {
	local option=$1
	local value=$(get_tmux_option "$option")
	local interpolated=$(interpolate_variables "$value")

	set_tmux_option "$option" "$interpolated"
}

main() {
	interpolate_tmux_option "status-right"
	interpolate_tmux_option "status-left"
}

main
