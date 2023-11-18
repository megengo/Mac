#----------------------#
#-- Mac Core Library --#
#----------------------#
# Purpose: Core zsh functionality for Mac
# Usage: source mcl
#
# Glossary:
# ts0 - True, successful, 0, i.e., default return value for a successful evaluation
# ff1 - False, failure, 1, i.e., opposite of ts0
# prv - Previous return value

#----------------------#
#-- Global Constants --#
#----------------------#

readonly MCL_VERSION="0.0.0"

#---------------#
#-- Functions --#
#---------------#

#-- Chronicle --#
# Outputs all arguments prepended with a date time string. Chronicle messages
# have 3 fields, i.e. date, time, level.
#
# Date format: 8-digit date, 6 digit time
# date is 4 digit year, 2 digit month, 2 digit day
# time is 2 digit hour, 2 digit minute, 2 digit second
#
# Call the log level functions defined below instead of chronicle directly
mclChronicle(){
    readonly log="$(date '+%Y%m%d %H%M%S') $@"
    [ -n "$MCL_LOG" ] && tee -a "$MCL_LOG" <<< "$log" || echo "$log"
}

#-- Chronicle Log Levels --#
# Prepends a string representing one of four log levels to a chronicle message.
# These functions should be called directly instead of chronicle.
#
# Debug:
# The default for all acts performed. Because of the incredibly high quantity of
# logs this generates, this level should be excluded from scripts triggered by
# argument.
mclDebug(){ mclChronicle "DEBUG: $@"; }
# Info:
# Generic status reporting messages
mclInfo(){ mclChronicle "INFO: $@"; }
# Warn:
# Harmful or otherwise particularly noteworthy messages which are not
# necessarily expected to correlate to a failure
mclWarn(){ mclChronicle "WARN: $@"; }
# Error:
# Messages which necessarily correlate to a failure
mclError(){ mclChronicle "ERROR: $@"; }

#-- Fail Messages --#
# Logs a message if the prv was not ts0
mclFDebug(){
    readonly prv="$?"
    readonly args=("-p" "$prv" "$@")
    mclFailChk "${args[@]}" && return 0
    mclDebug "$@" && return 1
}
mclFInfo(){
    readonly prv="$?"
    readonly args=("-p" "$prv" "$@")
    mclFailChk "${args[@]}" && return 0
    mclInfo "$@" && return 1
}
mclFWarn(){
    readonly prv="$?"
    readonly args=("-p" "$prv" "$@")
    mclFailChk "${args[@]}" && return 0
    mclWarn "$@" && return 1
}
mclFError(){
    readonly prv="$?"
    readonly args=("-p" "$prv" "$@")
    mclFailChk "${args[@]}" && return 0
    mclError "$@" && return 1
}

#-- Fail Check --#
# Compares the prv and ts0 (or any other optional return value) and returns ts0
# if that comparison returns true. Otherwise, this function returns ff1.
#
# Options
#   -p <number>
#       Specifies the previous return value so that other functions may call
#       this one after the previous
#   -e <number>
#       Manual override from the default expected success value (0)
mclFailChk(){
    local p="$?"
    local e="0"
    while [ -n "$1" ]; do
        case "$1" in
            "-p")   shift
                    mclIsNum "$1" && p="$1" ;;
            "-e")   shift
                    mclIsNum "$1" && e="$1" ;;
            *)      break ;;
        esac
        shift
    done
    [ "$p" = "$e" ]
}

#-- Is Number --#
# Returns true if the argument is a whole number
mclIsNum(){ grep -E '^[0-9]{1,}$' <<< "$1" &> /dev/null; }

mclConsoleUserName(){ scutil <<< "show State:/User/ConsoleUser" | awk -F 'Name : ' '/Name :/ && ! /loginwindow/ { print $2 }'; }
mclConsoleUserUID(){ scutil <<< "show State:/User/ConsoleUser" | awk -F 'UID : ' '/UID :/ && ! /loginwindow/ { print $2 }'; }
mclPMPresentActive(){ pmset -g useractivity | grep "Level = '.*PresentActive" &> /dev/null; }
mclConvertDateTimeToEpoch(){ date -jf "%Y%m%d %H%M%S" "$1" +"%s"; }
mclConvertEpochToDateTime(){ date -jf "%s" "$1" +"%Y%m%d %H%M%S"; }