#!/bin/zsh

# Exit if not run as root
[ "$EUID" = "0" ] || echo "Must run as root!"

# VARIABLES
readonly SCRIPT="/Library/Scripts/mcl/AutoWiFi.zsh"
readonly LABEL="com.mcl.autowifi"
readonly PLIST="/Library/LaunchDaemons/$LABEL.plist"

# FUNCTIONS
main(){

}

#-- Chronicle Logging Functions ---
mclChronicle(){
  readonly log="$(date '+%Y%m%d %H%M%S') $@"
  [ -n "$MCL_LOG" ] && tee -a "$MCL_LOG" <<< "$log" || echo "$log"
}

# Check if the previous return was a failure or other optional argument
mclFailChk(){
  local p="$?" e="0"
  while [ -n "$1" ]; do
    case "$1" in
      "-p") shift; mclIsNum "$1" && p="$1" ;;
      "-e") shift; mclIsNum "$1" && e="$1" ;;
      *) break ;;
    esac
    shift
  done
  [ "$p" = "$e" ]
}

# Check if the argument is a number
mclIsNum(){ grep -E '^[0-9]{1,}$' <<< "$1" &> /dev/null; }

#-- Basic Logging Messages ---
# Log message with prepended log level
# NOTE: Debug only works if global variable is initialized true
mclDebug(){ [ "$DEBUG" = "true" ] && mclChronicle "DEBUG: $@" || return 0; }
mclInfo(){ mclChronicle "INFO: $@"; }
mclWarn(){ mclChronicle "WARN: $@"; }
mclError(){ mclChronicle "ERROR: $@"; }

#-- Failure Logging Functions ---
# Log message if previous return was a failure
mclFDebug(){
  [ "$DEBUG" = "true" ] || return 0
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

writePlist(){
  # build plist

  defaults write "$PLIST" Label -string "$LABEL"
  defaults write "$PLIST" WatchPaths -array "/Library/Preferences/SystemConfiguration"
  defaults write "$PLIST" ProgramArguments -array "zsh" "$SCRIPT"
  defaults write "$PLIST" User -string "root"

  # Set file permissions
  chmod 644 "$PLIST"
  chown 0:0 "$PLIST"
}
# 
# Convert base64 to build script

chmod 755 "$SCRIPT"
chown 0:0 "$SCRIPT"

launchctl bootstrap system "$PLIST"

[ "$ZSH_EVAL_CONTEXT" = "toplevel" ] && main