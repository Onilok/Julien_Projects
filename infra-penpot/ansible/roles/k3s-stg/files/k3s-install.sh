#!/usr/bin/env bash
set -e

# IP privée du master1 (ou hostname interne)
MASTER1_IP=$(hostname -I | awk '{print $1}')
export MASTER1_IP

# Token généré automatiquement (on peut aussi définir un token fixe)
TOKEN=$(openssl rand -hex 16)
export TOKKEN

echo "==== Installing K3s Master 1 (cluster-init) ===="

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --token $TOKEN --node-ip $MASTER1_IP --advertise-address $MASTER1_IP --tls-san $MASTER1_IP" sh -

echo "==== Master 1 installé ===="
