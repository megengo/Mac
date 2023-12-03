#!/bin/zsh

# Plist Buddy
readonly "$PB"="/usr/libexec/PlistBuddy"

ldbUnload(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  if [ -f "$plist" ]; then
    launchctl bootout system "$PLIST" && return 0 || return 1
  else
    return 1
  fi
}


ldbLoad(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  if [ -f "$plist" ]; then
    launchctl bootstrap system "$plist" && return 0 || return 1
  else
    return 1
  fi
}

ldbWrite(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  if [ -f "$plist" ]; then
    defaults write "$plist" "$key" "$value" && return 0 || return 1
  else
    return 1
  fi
}

ldpDelete(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  if [ -f "$plist" ]; then
    defaults delete "$plist" "$key" && return 0 || return 1
  else
    return 1
  fi
}

ldbMakeArray(){

}