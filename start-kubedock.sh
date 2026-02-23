#!/bin/sh

export VERBOSE="${KUBEDOCK_VERBOSE:-3}"
export REQ_LIM_CPU="${KUBEDOCK_REQ_LIM_CPU:-1000m,2000m}"
export REQ_LIM_MEM="${KUBEDOCK_REQ_LIM_MEM:-2048Mi,4096Mi}"
export ENABLE_INSPECTOR="${KUBEDOCK_ENABLE_INSPECTOR:-}"
export ENABLE_REVERSE_PROXY="${KUBEDOCK_ENABLE_REVERSE_PROXY:---reverse-proxy}"
export PULL_POLICY="${KUBEDOCK_PULL_POLICY:-always}"
export REAP_MAX="${KUBEDOCK_REAP_MAX:-30m}"
export ENABLE_PRE_ARCHIVE="${KUBEDOCK_ENABLE_PRE_ARCHIVE:---pre-archive}"

env

/usr/local/bin/kubedock server \
  -n $JENKINS_SHORTNAME \
  -v $VERBOSE \
  $ENABLE_INSPECTOR \
  $ENABLE_REVERSE_PROXY \
  $ENABLE_PRE_ARCHIVE \
  --request-cpu $REQ_LIM_CPU \
  --request-memory $REQ_LIM_MEM \
  --pull-policy $PULL_POLICY \
  --reapmax $REAP_MAX \
  --node-selector=compute=general \
  $@
