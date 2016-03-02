#!/bin/bash

export IP=33.59.109.100         #IP masternode
export WORK_DIR=$HOME/aldred    #dashd ,dash-cli directory
export BIN_DIR=$HOME/PycharmProjects/mnservice/bin #mnservice program directory

$BIN_DIR/mnservice.sh $1 $2 $3 $4
