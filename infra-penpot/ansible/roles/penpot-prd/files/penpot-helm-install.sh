#!/usr/bin/env bash

# Variables
helm="/usr/local/bin/helm"
values_yml="penpot-helm-values.yml"
app="penpot"
namespace="$app"
kubeconf="/etc/rancher/k3s/k3s.yaml"

# main
$helm install $app -n $namespace --create-namespace $app/$app -f $values_yml --kubeconfig $kubeconf
