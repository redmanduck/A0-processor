#!/bin/bash
make clean
asm asmFiles/test.loadstore.asm
make memory_control.$1
