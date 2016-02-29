# MasternodeService

DASH masternode service - version 0.1.1

* Starts dashd daemon
* Checks his run and if it crashes, then starts again
* The test period is 10 minutes

## Install

To download do :

    sudo apt-get install git
    git clone https://github.com/bojos/mnservice.git
    cd nmservice
    chmod +x mn.sh
    
To modification mn.sh any editor
    
    nano mn.sh
    ......
    
You must change these variables for your computer
    
    export IP=xx.xx.xx.xx               #IP masternode
    export WORK_DIR=$HOME               #dashd ,dash-cli directory
    export BIN_DIR=$HOME/mnservice/bin  #mnservice program directory

    
# Usage and commands
    
Call script mn.sh with parameter
    
"eg: ./mn.sh on|off|re|info|pid|log"

* on      - start dashd and mnservice
* off     - close mnservice and dashd
* re      - restart dashd
* info    - information about masternode
* pid     - return pid dashd and mnservice
* log     - list mnservice logfile

    ./mn.sh on
    ./mn.sh log
    
Proper log looks like this

    2016-02-29 15:41:29 ................................
    2016-02-29 15:41:29 >> mnservice run - pid = 6155
    2016-02-29 15:41:29 ................................
    2016-02-29 15:41:29 -> dashd find - pid = 5963

    
# Dependencies
    
* python3
* dashd, dash-cli 0.12.*    

## Versions

### 0.1.1 
- independent of file .dash/dashd.pid
