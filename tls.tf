## Copyright © 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "tls_private_key" "public_private_key_pair" {
  algorithm   = "RSA"
}

# resource "local_file" "private_key" {
#   content         = tls_private_key.public_private_key_pair.private_key_pem
#   filename        = "keys/devbox.pem"
#   file_permission = "0600"
# }