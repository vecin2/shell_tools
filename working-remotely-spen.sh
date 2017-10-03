#!/bin/bash

echo "Redirecting url"
 ssh dgarcia@10.77.41.26 -p 22 -N -f -L 9999:10.10.188.144:80
 
 cd ..

echo "Switching svn url"
svn switch --relocate http://10.10.188.144/svn/ScottishPower/EnergyNetworks/CSBluePrint/branches/FP3  http://localhost:9999/svn/ScottishPower/EnergyNetworks/CSBluePrint/branches/FP3/

