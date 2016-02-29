#!/bin/sh

export IP=33.59.109.100
export WORK_DIR=$HOME/aldred
export DASH_DIR=$HOME/.dash
export BIN_DIR=$HOME/aldred/mnservice/bin

$BIN_DIR/mnservice.sh $1 $2 $3 $4
