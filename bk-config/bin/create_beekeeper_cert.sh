#!/bin/bash -e

mkdir -p /usr/lib/sage/bk-server


if [ -e /usr/lib/sage/bk-server/id_rsa_sage_beekeeper-cert.pub ] ; then
    echo "beekeeper cert already exists"
    exit 0
fi

# create key pair
if [ ! -e /usr/lib/sage/bk-server/id_rsa_sage_beekeeper ]  ; then
    set -x
    ssh-keygen -f /usr/lib/sage/bk-server/id_rsa_sage_beekeeper -t rsa -b 4096 -N ''
    set +x
fi

# sign key (creates id_rsa_sage_beekeeper-cert.pub)
set -x
ssh-keygen -I sage_beekeeper_server -s /usr/lib/sage/certca/sage_beekeeper_ca -h /usr/lib/sage/bk-server/id_rsa_sage_beekeeper.pub
set +x