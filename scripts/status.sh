#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k8s-dev-101"
CONTEXT_NAME="kind-${CLUSTER_NAME}"

echo "Kind 클러스터 목록"
kind get clusters

echo ""
echo "현재 kubectl context"
kubectl config current-context || true

echo ""
echo "실습 context 사용: ${CONTEXT_NAME}"
kubectl config use-context "${CONTEXT_NAME}" >/dev/null

echo ""
echo "노드 목록"
kubectl --context "${CONTEXT_NAME}" get nodes

echo ""
echo "네임스페이스 목록"
kubectl --context "${CONTEXT_NAME}" get namespaces

echo ""
echo "kube-system Pod 목록"
kubectl --context "${CONTEXT_NAME}" get pods -n kube-system
EOF
