#!/bin/bash

dir="$(pwd)"

mkdir -p ~/backups

cd ~/backups

name="Documents_backup$(date -u +%b_%d_%Y_%H_%M_%S).tar.gz"
tar -czvf $name ~/Documents

cd $dir

