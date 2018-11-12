#!/bin/bash

for x in pdf epub mobi ; do gitbook $x ./ ebooks/ansible-system-network-automation.$x ; done
#git add * ; git commit -m "updated" ; git push
