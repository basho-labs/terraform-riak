#!/bin/bash

PRIMARY_IP=$(cat /tmp/primary_ip | tr -d '\n')

echo "Joining cluster..."
sleep 20
sudo riak-admin cluster join riak@$PRIMARY_IP
