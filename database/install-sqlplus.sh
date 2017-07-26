#!/bin/bash

sudo apt-get install alien
sudo apt-get install libaio1

sudo alien -i oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm 
sudo alien -i oracle-instantclient12.1-sqlplus-12.1.0.1.0-1.x86_64.rpm
sudo alien -i oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

