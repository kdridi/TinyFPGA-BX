#!/usr/bin/env bash

cd $(dirname $(realpath $0))

if [ ! -d .env ]; then
    python3 -m venv --prompt 'TinyFPGA BX' .env

    source .env/bin/activate

    pip install --upgrade pip
    pip install apio==0.4.0b5 tinyprog
    apio install system scons icestorm iverilog
    apio drivers --serial-enable

    sudo apt-get install --silent -y arachne-pnr fpga-icestorm yosys
fi