#!/bin/bash

for x in pdf epub mobi ; do gitbook $x ./ ebooks/aws-112018.$x ; done
#git add * ; git commit -m "updated" ; git push
