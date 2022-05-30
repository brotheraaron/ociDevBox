#!/bin/bash

# Uploads SSH Public Key to authorized keys.
cp /home/opc/.ssh/authorized_keys /home/opc/.ssh/authorized_keys.bak
echo "${ssh_public_key}" >> /home/opc/.ssh/authorized_keys
chown -R opc /home/opc/.ssh/authorized_keys

echo "export OCI_CLI_AUTH=instance_principal" >> /home/opc/.bash_profile