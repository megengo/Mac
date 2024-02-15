#!/bin/zsh

# Plist Buddy
readonly "$PB"="/usr/libexec/PlistBuddy"

ldbUnload(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  [ -f "$plist" ] || return 1
  launchctl bootout system "$plist"
}


ldbLoad(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  [ -f "$plist" ] || return 1
  launchctl bootstrap system "$plist"
}

ldbWrite(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  [ -f "$plist" ] || return 1
  defaults write "$plist" "$key" "$value"
}

ldpDelete(){
  [ -n "$1" ] && readonly plist="$1" || return 1
  [ -f "$plist" ] || return 1
  defaults delete "$plist" "$key" && return 0 || return 1
}

ldbMakeArray(){

}