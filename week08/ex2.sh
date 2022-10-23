#!/bin/bash

find ~/backups -name 'html_backup*' -exec rm {} \;

dir="$(pwd)"

mkdir -p ~/backups

cd ~/backups

name="html_backup_$(date -u +%b_%d_%Y_%H_%M_%S).tar.gz"
tar -czvf $name /var/www/html

cd $dir

