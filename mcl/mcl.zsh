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

mclChronicle(){
    readonly log="$(date '+%Y%m%d %H%M%S') $@"
    [ -n "$MCL_LOG" ] && tee -a "$MCL_LOG" <<< "$log" || echo "$log"
}

mclDebug(){ mclChronicle "DEBUG: $@"; }
mclInfo(){ mclChronicle "INFO: $@"; }
mclWarn(){ mclChronicle "WARN: $@"; }
mclError(){ mclChronicle "ERROR: $@"; }

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

mclIsNum(){ grep -E '^[0-9]{1,}$' <<< "$1" &> /dev/null; }

#-- mclConsoleUserName
# TODO: Pass in args for name, etc.
# Args
#   uid
#   name
mclConsoleUserName(){ scutil <<< "show State:/User/ConsoleUser" | awk -F 'Name : ' '/Name :/ && ! /loginwindow/ { print $2 }'; }
mclConsoleUserUID(){ scutil <<< "show State:/User/ConsoleUser" | awk -F 'UID : ' '/UID :/ && ! /loginwindow/ { print $2 }'; }
mclConvertDateTimeToEpoch(){ date -jf "%Y%m%d %H%M%S" "$1" +"%s"; }
mclConvertEpochToDateTime(){ date -jf "%s" "$1" +"%Y%m%d %H%M%S"; }
mclPMPresentActive(){ pmset -g useractivity | grep "Level = '.*PresentActive" &> /dev/null; }
mclSleepOff(){ pmset -a displaysleep 0 disksleep 0 sleep 0; }
mclSleepOn(){ pmset -a displaysleep 1 disksleep 2 sleep 3; }

#-- Sleep --#
slep(){
    case "$1" in
        "off")  pmset -a displaysleep 0 disksleep 0 sleep 0 ;;
        "min")  pmset -a displaysleep 1 disksleep 2 sleep 3 ;;
        *)      pmset -b displaysleep 1 disksleep 2 sleep 5
                pmset -c displaysleep 15 disksleep 15 sleep 30
                pmset -u displaysleep 0 disksleep 0 sleep 30 ;;
    esac
}