#!/usr/bin/env bash

# Commonly Supported Style Codes
# https://prnt.sc/v-GFBk1q0_TL

# Variables can be bound for style codes
style_fg_black=30
style_fg_red=31
style_fg_green=32
style_fg_yellow=33
style_fg_blue=34
style_fg_magenta=35
style_fg_cyan=36
style_fg_white=37
style_fg_bright_black=90
style_fg_bright_red=91
style_fg_bright_green=92
style_fg_bright_yellow=93
style_fg_bright_blue=94
style_fg_bright_magenta=95
style_fg_bright_cyan=96
style_fg_bright_white=97
style_bg_black=40
style_bg_red=41
style_bg_green=42
style_bg_yellow=43
style_bg_blue=44
style_bg_magenta=45
style_bg_cyan=46
style_bg_white=47
style_bg_bright_black=100
style_bg_bright_red=101
style_bg_bright_green=102
style_bg_bright_yellow=103
style_bg_bright_blue=104
style_bg_bright_magenta=105
style_bg_bright_cyan=106
style_bg_bright_white=107
style_reset=0
style_bright=1
style_dim=2
style_italic=3
style_underlined=4
style_blinking=5
style_inverted=7
style_strikethrough=9

# Function returns format string with codes for future echo-ing
get_styled_text() {
    # Grab the text to style
    # local text="$1"
    # shift 1;
    # Format the codes to use
    # printf lets you pass an array to join
    local joined_semicolon=$(printf ";%s" $@)
    # Strip first semicolon
    joined_semicolon="${joined_semicolon:1}"
    # Return the unevaluated text
    while read line; do
        echo "\033[${joined_semicolon}m${line}\033[0m"
    done </dev/stdin
}

# Function directly echoes the styled text
echo_styled_text() {
    # Make sure to keep args @ in double quotes so strings stay together and are not split
    while read line; do
        echo "${line}" | get_styled_text "$@" | echo -e $(</dev/stdin)
    done </dev/stdin
}

# Reads from stdin and returns all values for a given key. Allows specifying the delimiter. Defaults to a colon.
get_by_key() {
    local reassigned_at=("$@")
    local key="${reassigned_at[0]}"
    local delimiter="${reassigned_at[1]-:}"
    local awk_string='BEGIN{FS=OFS="'${delimiter}'"} {gsub(/^[ \t]+|[ \t]+$/, "", $1); gsub(/^[ \t]+|[ \t]+$/, "", $2); if($1 == "'${key}'") print $2; }'
    while read line; do
        :
        echo ${line} | awk "${awk_string}"
    done </dev/stdin
}

# Find commands which output useful system info

## Hostname
get_hostname() {
    local answer=""
    if command -v hostname >/dev/null 2>&1; then
        :
        answer=$(hostname)
    fi
    printf "${answer}"
}

## Linux distro or OS
get_os() {
    local answer=""
    if [ -f /etc/os-release ]; then
        :
        answer="$(cat /etc/os-release | get_by_key "PRETTY_NAME" "=")"
    elif command -v system_profiler >/dev/null 2>&1; then
        :
        answer="$(system_profiler SPSoftwareDataType | get_by_key "System Version")"
    fi
    printf "${answer}"
}

## Architecture
get_architecture() {
    local answer=""
    if command -v uname > /dev/null 2>&1; then
        :
        answer="$(uname -m)"
    fi
    printf "${answer}"
}

## IP address
get_ipv4_addresses() {
    local answer=""
    if command -v ip > /dev/null 2>&1; then
        :
        answer=$(ip addr show | get_by_key "inet" " " | cut -d' ' -f1)
    elif command -v ifconfig > /dev/null 2>&1; then
        :
        answer=$(ifconfig | get_by_key "inet" " " | cut -d' ' -f1)
    fi
    printf "${answer}"
}

## cpu cores
get_cpus() {
    local answer=""
    if command -v lscpu > /dev/null 2>&1; then
        :
        answer=$(lscpu | get_by_key "CPU(s)")
    elif command -v sysctl > /dev/null 2>&1 && sysctl -n hw.ncpu > /dev/null 2>&1; then
        :
        answer=$(sysctl -n hw.ncpu)
    fi
    printf "${answer}"
}

kibibytes_to_bytes() {
    while read KB; do
        :
        echo $(((KB * 1024) - 512))
    done </dev/stdin
}

# https://stackoverflow.com/questions/19059944/convert-kb-to-mb-using-bash
human_size() {
    # The + 512 is only for rounding purposes
    # Please note these are conversions to kibi, mebi, gibi, etc - which are 1024 instead of 1000 (kilo, mega, giga)
    # This matches format used by the `free` command
    while read B; do
        [ $B -lt 1024 ] && echo ${B} B && break
        KB=$(((B + 512) / 1024))
        [ $KB -lt 1024 ] && echo ${KB} Ki && break
        MB=$(((KB + 512) / 1024))
        [ $MB -lt 1024 ] && echo ${MB} Mi && break
        GB=$(((MB + 512) / 1024))
        [ $GB -lt 1024 ] && echo ${GB} Gi && break
        echo $(((GB + 512) / 1024)) Ti
    done </dev/stdin
}

## total memory
# https://serverfault.com/a/1025189
# https://askubuntu.com/questions/223759/how-to-interpret-output-of-free-m-command
# https://www.redhat.com/sysadmin/dissecting-free-command
get_memory_total() {
    local answer=""
    if [ -f /proc/meminfo ]; then
        :
        answer=$(cat /proc/meminfo | get_by_key "MemTotal" | cut -d' ' -f 1 | kibibytes_to_bytes)
    elif command -v sysctl > /dev/null 2>&1 && sysctl -n hw.memsize > /dev/null 2>&1; then
        :
        answer="$(sysctl -n hw.memsize)"
    fi
    printf "${answer}"
}

## available memory
# https://serverfault.com/a/1025189
# https://askubuntu.com/questions/223759/how-to-interpret-output-of-free-m-command
# https://www.redhat.com/sysadmin/dissecting-free-command
get_memory_available() {
    local answer=""
    if [ -f /proc/meminfo ]; then
        :
        answer=$(cat /proc/meminfo | get_by_key "MemAvailable" | cut -d' ' -f 1 | kibibytes_to_bytes)
    elif command -v vm_stat > /dev/null 2>&1; then
        :
        local page_size=$(pagesize)
        local pages_free=$(vm_stat | get_by_key "Pages free" | sed 's/\.//')
        local pages_inactive=$(vm_stat | get_by_key "Pages inactive" | sed 's/\.//')
        local pages_speculative=$(vm_stat | get_by_key "Pages speculative" | sed 's/\.//')
        answer=$(((pages_free + pages_inactive + pages_speculative) * page_size))
    fi
    printf "${answer}"
}

get_disk_total_root() {
    local answer=""
    if command -v df > /dev/null 2>&1; then
        answer=$(df -k / | awk '{ if (NR > 1) print $2}' | kibibytes_to_bytes)
    fi
    printf "${answer}"
}

get_disk_available_root() {
    local answer=""
    if command -v df > /dev/null 2>&1; then
        answer=$(df -k / | awk '{ if (NR > 1) print $4}' | kibibytes_to_bytes)
    fi
    printf "${answer}"
}

## Current SHELL

## Bash version

## Datetime

## Current username

## Current usergroups

## available disk space

## SSH is listening on

## http is listening on

## vhosts are located at

## nginx is listening at

## logs are located at

x_is_percentage_of_y() {
    local x="$1"
    local y="$2"
    local result=$((x * 100 / y))
    printf "${result}"
}

get_system_report_key_value_info() {
    local key="$1"
    local value="$2"
    printf "%s: %s\n" "$(echo "$key" | echo_styled_text ${style_fg_magenta} ${style_bright})" "$(echo "${value}" | echo_styled_text ${style_fg_green})"
}

get_system_report_key_value_warn() {
    local key="$1"
    local value="$2"
    printf "%s: %s\n" "$(echo "$key" | echo_styled_text ${style_fg_bright_yellow} ${style_bg_bright_black} ${style_bright})" "$(echo "${value}" | echo_styled_text ${style_fg_bright_yellow} ${style_bg_bright_black} ${style_blinking})"
}

get_system_report_key_value_error() {
    local key="$1"
    local value="$2"
    printf "%s: %s\n" "$(echo "$key" | echo_styled_text ${style_fg_bright_red} ${style_bg_bright_black} ${style_bright})" "$(echo "${value}" | echo_styled_text ${style_fg_bright_red} ${style_bg_bright_black} ${style_blinking})"
}

get_system_report() {
    get_system_report_key_value_info "Hostname" "$(get_hostname)"
    get_system_report_key_value_info "OS" "$(get_os)"
    get_system_report_key_value_info "CPU Architecture" "$(get_architecture)"
    get_system_report_key_value_info "CPU(s)" "$(get_cpus)"
    get_system_report_key_value_info "IP Address" "$(get_ipv4_addresses | xargs)"
    local memory_total="$(get_memory_total)"
    local memory_available="$(get_memory_available)"
    get_system_report_key_value_info "Total Memory" "$(echo ${memory_total} | human_size)"
    get_system_report_key_value_info "Available Memory" "$(echo ${memory_available} | human_size)"
    local memory_available_is_percentage_of_total="$(x_is_percentage_of_y ${memory_available} ${memory_total})"
    if [[ $memory_available_is_percentage_of_total -lt 10 ]]; then
        get_system_report_key_value_error "Percent Available Memory" "${memory_available_is_percentage_of_total}%"
    elif [[ $memory_available_is_percentage_of_total -lt 20 ]]; then
        get_system_report_key_value_warn "Percent Available Memory" "${memory_available_is_percentage_of_total}%"
    else
        get_system_report_key_value_info "Percent Available Memory" "${memory_available_is_percentage_of_total}%"
    fi
    local disk_total="$(get_disk_total_root)"
    local disk_available="$(get_disk_available_root)"
    local disk_available_is_percentage_of_total="$(x_is_percentage_of_y ${disk_available} ${disk_total})"
    get_system_report_key_value_info "Total Disk" "$(echo ${disk_total} | human_size)"
    get_system_report_key_value_info "Available Disk" "$(echo ${disk_available} | human_size)"
    if [[ $disk_available_is_percentage_of_total -lt 10 ]]; then
        get_system_report_key_value_error "Percent Available Disk" "${disk_available_is_percentage_of_total}%"
    elif [[ $disk_available_is_percentage_of_total -lt 20 ]]; then
        get_system_report_key_value_warn "Percent Available Disk" "${disk_available_is_percentage_of_total}%"
    else
        get_system_report_key_value_info "Percent Available Disk" "${disk_available_is_percentage_of_total}%"
    fi
    #printf "%s: %s\n" "$(echo "IP Address" | echo_styled_text ${style_fg_magenta} ${style_bright})" "$(echo "${my_ipv4_addresses[@]}" | echo_styled_text ${style_fg_green} ${style_dim})"
}
