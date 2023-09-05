#!/bin/bash
echo "Enter IP address:"
read ip
echo "Generating ssh key pair"
# Generate an ssh key pair if one doesn't already exist
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096
fi
echo "Copying public key to remote machine"
# Copy the public key to the remote machine with -f option
ssh-copy-id -i ~/.ssh/id_rsa.pub -f root@"$ip"
echo "Uploading remote script"
# SCP the remote script to the remote machine
scp remote_script.sh root@"$ip":~/
echo "Uploading local squid.conf file"
# SCP the local squid.conf file to the remote machine
scp -v squid.conf root@"$ip":/etc/squid/squid.conf
echo "Running remote script"
# SSH into the remote machine using the key pair for authentication
ssh root@"$ip" 'bash ~/remote_script.sh'