myDir=$(dirname $0)
myDir=$(cd ${myDir};pwd)
electroshotRootDir=$(cd ${myDir}/../;pwd)

function cleanConfig(){
  find /tmp/ -maxdepth 1 -mtime +1 -name electroshot-config-\*.json |\
  while read line;do
    rm ${line};
  done
}

function cleanProcesses(){
  ps -ef |grep "${electroshotRootDir}" |\
  while read user pid ppid other;do
    if [ ${ppid} -eq 1 ];then
      pkill --signal SIGKILL --parent ${pid}
      kill -9 ${pid}
    fi
  done
}

function main(){
  case "$1" in
    "config")
      cleanConfig
      ;;
    "process")
      cleanProcesses
      ;;
  esac
}

# ===== main =====
if [[ "${BASH_SOURCE[0]}" == "$0" ]];then
  main $*
fi
