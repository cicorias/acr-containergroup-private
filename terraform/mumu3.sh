#!/bin/bash
set -x

mumu3() {
# see https://github.com/naknak-/mumu3 This code implements MurmurHash3's 32-bit hashing function in pure bash.
# this is same as what uniqueString in ARM templates provides.
# this is deterministic and repeatable. TF cannot take varied names as it will destroy and recreate resources 
# every time it runs. This is a workaround to get a unique name for each resource.
  local -r key="${1?usage: mumu key [seed] [fmt]}" len=${#1} mask=$((0xffffffff))
  local h=$(( ${2:-0} )) i=0 k
  while (( i < len )); do
    printf -v k %02x "'${key:(i+3):1}" "'${key:(i+2):1}" "'${key:(i+1):1}" "'${key:(i):1}"
    (( k=0x$k * 0xcc9e2d51 & mask, h=(h ^ ((k "<<" 15 | k>>17)*0x1b873593) ) & mask ))
    (( (i+=4) <= len )) && (( h=( (h "<<" 13 | h>>19) * 5 + 0xe6546b64 ) & mask ))
  done  
  (( h^=len, h^=h>>16, h*=0x85ebca6b, h^=(h&mask)>>13, h=h*0xc2b2ae35 & mask, h^=h>>16 ))
  hash=$h
  [[ "${#@}" -gt 2 && -z "$3" ]] || printf ${3:-"%08x\n"} $h
}

rv=$(mumu3 $@) 

echo $rv