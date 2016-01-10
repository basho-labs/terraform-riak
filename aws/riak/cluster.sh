#!/bin/bash

echo "Planning and committing..."

sleep 20
sudo riak-admin cluster plan
sudo riak-admin cluster commit
sudo riak-admin member_status
