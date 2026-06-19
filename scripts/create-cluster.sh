#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k8s-dev-101"
CONTEXT_NAME="kind-${CLUSTER_NAME}"

echo "Kind 클러스터 확인: ${CLUSTER_NAME}"

if kind get clusters | grep -Fxq "${CLUSTER_NAME}"; then
  echo "이미 클러스터가 존재합니다: ${CLUSTER_NAME}"
else
  echo "Kind 클러스터 생성: ${CLUSTER_NAME}"
  kind create cluster --name "${CLUSTER_NAME}"
fi

echo "kubeconfig 갱신: ${CLUSTER_NAME}"
kind export kubeconfig --name "${CLUSTER_NAME}" >/dev/null

echo "kubectl context 전환: ${CONTEXT_NAME}"
kubectl config use-context "${CONTEXT_NAME}"

echo "노드가 Ready 상태가 될 때까지 기다립니다..."
kubectl wait --for=condition=Ready node --all --timeout=120s

echo "클러스터 준비 완료"
kubectl get nodes

