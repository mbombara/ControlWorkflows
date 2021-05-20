#!/usr/bin/env bash

# set -x;
set -e;
set -u;

WF_NAME=minimal-dpl

cd ..

# DPL command to generate the AliECS dump
o2-dpl-raw-proxy -b --session default --dataspec 'x:ZYX/RAWDATA;dd:FLP/DISTSUBTIMEFRAME/0' --readout-proxy '--channel-config "name=readout-proxy,type=pull,method=connect,address=ipc:///tmp/stf-builder-dpl-pipe-0,transport=shmem,rateLogging=10"' | o2-dpl-output-proxy -b --session default --dataspec 'x:ZYX/RAWDATA;dd:FLP/DISTSUBTIMEFRAME/0' --dpl-output-proxy '--channel-config "name=downstream,type=push,method=bind,address=ipc:///tmp/stf-pipe-0,rateLogging=10,transport=shmem"' --o2-control $WF_NAME

sed -i "s/ZYX/{{ detector }}/g" workflows/${WF_NAME}.yaml tasks/${WF_NAME}-*

# sed -i /defaults:/\ a\\\ \\\ "detector: TST" workflows/${WF_NAME}.yaml


