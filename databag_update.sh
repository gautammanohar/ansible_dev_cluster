#!/bin/bash 
knife data bag from file network dns.json
knife data bag from file nagios environment.json
knife data bag from file hadoop cluster.json
knife data bag from file mongo replset.json
knife data bag from file cassandra cluster.json
knife data bag from file kafka cluster.json

