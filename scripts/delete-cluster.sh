#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="k8s-dev-101"

echo "Kind 클러스터 삭제 확인: ${CLUSTER_NAME}"

if ! kind get clusters | grep -Fxq "${CLUSTER_NAME}"; then
  echo "삭제할 클러스터가 없습니다: ${CLUSTER_NAME}"
  exit 0
fi

kind delete cluster --name "${CLUSTER_NAME}"

echo "클러스터 삭제 완료"
