#!/bin/bash
\curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm requirements
rvm install 2.1.4
rvm use 2.1.4 --default

