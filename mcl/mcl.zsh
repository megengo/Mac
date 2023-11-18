#!/bin/sh

#  mcf.sh
#  
#
#  Created by Chris Cox on 11/17/23.
#  
# Example script which sources mcf to demonstrate capability
source mcl
mclDebug "This is the first debug message ever"
mclFailChk -p 0 "This message is a false negative demonstrating the -p option"