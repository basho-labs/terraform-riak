#!/bin/bash

echo "Creating bucket $1..."

sudo riak-admin bucket-type create $1 '{"props":{"table_def": "CREATE TABLE '"$1"' (myfamily varchar not null, myseries varchar not null, time timestamp not null, weather varchar not null, temperature double, PRIMARY KEY ((myfamily, myseries, quantum(time, 2, 'h')), myfamily, myseries, time))"}}'

sudo riak-admin bucket-type activate $1
