#!/bin/bash
knife bootstrap 54.213.23.223 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name nagios.bigstream.dev.com
knife ssh 54.213.23.223 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem
