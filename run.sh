#!/bin/bash
#knife bootstrap 54.200.20.252 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name y-master.bigstream.dev.com
#knife bootstrap 54.200.214.53 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name y-1.bigstream.dev.com
#knife bootstrap 54.191.148.155 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name y-2.bigstream.dev.com
#knife bootstrap 54.191.100.75 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name ns-1.bigstream.dev.com
#knife bootstrap 54.213.30.117 --ssh-user ec2-user --sudo --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem --node-name nagios.bigstream.dev.com

#knife ssh 54.191.100.75 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem
#knife ssh 54.213.30.117 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem
#knife ssh 54.200.20.252 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem
knife ssh 54.200.214.53 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem
knife ssh 54.191.148.155 'sudo chef-client' --manual-list --ssh-user ec2-user --identity-file ../chef-repo/chef-nodes-oregon-keypair.pem








