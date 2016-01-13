#!/bin/bash
set -e

javac -cp ./riak-client-2.0.3-jar-with-dependencies.jar:./slf4j-1.7.12/slf4j-jdk14-1.7.12.jar ./scripts/java/TSInsert.java
javac -cp ./riak-client-2.0.3-jar-with-dependencies.jar:./slf4j-1.7.12/slf4j-jdk14-1.7.12.jar ./scripts/java/TSQuery.java
