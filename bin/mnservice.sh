#!/bin/sh

SERV_VER=1.0

case "$1" in
    on )
    #Starting dashd and mnservice
        $WORK_DIR/dashd && sleep 2
        python3 $BIN_DIR/mnservice.py start $WORK_DIR $DASH_DIR/dashd.pid
        echo "waiting for information ..."
        sleep 40
        $0 info
    ;;
    off )
    #stop mnservice and dashd
        python3 $BIN_DIR/mnservice.py stop $WORK_DIR $DASH_DIR/dashd.pid
        $WORK_DIR/dash-cli stop
    ;;
    re )
    #restart service daemon and dashd
        $0 off
        sleep 2
        $0 on
    ;;
    up )
    #update new dashd version
        echo "update not iplemented"
    ;;
    info )
    #information about masternode
        echo -e "\e[36mdash-cli getinfo\e[0m"
        $WORK_DIR/dash-cli getinfo
        sleep 1
        echo -e "\e[36mdash-cli masternode status\e[0m"
        $WORK_DIR/dash-cli masternode status
        sleep 1
        echo -e "\e[36mdash-cli masternode list full| grep $IP\e[0m"
        echo
        $WORK_DIR/dash-cli masternode list full| grep $IP
        echo "--------------------------------------------"
    ;;
    pid )
    #dashd and mnservice pid
        echo -e "\e[36mdash pid\e[0m"
        pgrep dashd
        echo -e "\e[36mnservice pid\e[0m"
        cat /tmp/mnservice.pid
    ;;
    log )
    #mnservice logfile
        cat /tmp/mnservice.log
    ;;
    help )
        echo "----------------------------------------"
        echo -e "\e[36mService masternode - v$SERV_VER by bojos\e[0m"
        echo "----------------------------------------"
        echo "eg: $0 on|off|re|up|info|pid|log"
        echo "..........................................."
        echo "  on      - start dashd and mnservice"
        echo "  off     - close mnservice and dashd"
        echo "  re      - restart dashd"
        echo "  up      - update new version"
        echo "  info    - information about masternode"
        echo "  pid     - return pid dashd and mnservice"
        echo "  log     - list mnservice logfile"
        echo "..........................................."
    ;;
    * )
        echo "'$1' - bad first parameter!"
        echo
        $0 help
    ;;
esac
