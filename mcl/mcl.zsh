#!/bin/zsh

#  mcf.sh
#  
#
#  Created by Chris Cox on 11/17/23.
#  
# Example script which sources mcf to demonstrate capability

source mcl
mclDebug "$0: source mcl: $?"
mclInfo "Mac Core Library Version: $MCL_VERSION"

false
mclFDebug "Fail Check Debug Message"
mclFInfo "Fail Check Info Message"
mclFWarn "Fail Check Warn Message"
mclFError "Fail Check Error Message"