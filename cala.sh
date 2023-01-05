#!/bin/sh

CALAPATH=~/.cala

usage() {
  echo "cala"
}

ensurePath() {
  if [ ! -d $CALAPATH ]; then
    mkdir -p $CALAPATH
  fi
}

getCalaId() {
  declare -n _out=$1

  local idPath=${CALAPATH}/.id
  if [ ! -e $idPath ]; then
    touch $idPath
  fi

  local id=$(wc -l $idPath | awk '{print $1}')
  echo "$id" >> $idPath

  _out=$id
}

newCalaProcess() {
  declare -n _out=$1
  local calaId=$2
  local command="$3"

  local processPath="${CALAPATH}/${calaId}"
  if [ -e $processPath ]; then
    echo "process with calaId $calaId already exists"
    exit 1
  fi

cat << EOT > $processPath
status: New
PID: ?
command: '$command'
EOT

  _out=$processPath
}

setProcessStatus() {
  local calaId=$1
  local newStatus=$2

  local process="${CALAPATH}/${calaId}"
  if [ ! -e $process ]; then
    echo "process with calaId $calaId does not exist"
    exit 1
  fi

  sed -i "1c\status: $newStatus" $process
}

setProcessPid() {
  local calaId=$1
  local newPid=$2

  local process="${CALAPATH}/${calaId}"
  if [ ! -e $process ]; then
    echo "process with calaId $calaId does not exist"
    exit 1
  fi

  sed -i "2c\PID: $newPid" $process
}

command_add() {
  local command="$1"

  local calaId
  getCalaId calaId

  local process
  newCalaProcess process $calaId "$command"

  setProcessStatus $calaId "Active"
  bash -c "$command" >> "${process}.output" && setProcessStatus $calaId "Completed" &
  echo "cala process $calaId started"
  pid=$!
  setProcessPid $calaId $pid
}

case $1 in
add)
command_add "$2"
;;

*)
usage

esac

