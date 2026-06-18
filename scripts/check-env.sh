#!/usr/bin/env bash
set -euo pipefail

check_cmd() {
  local name="$1"
  local cmd="$2"

  echo "[CHECK] ${name}"
  if command -v "${cmd}" >/dev/null 2>&1; then
    echo "  OK: ${cmd} found"
  else
    echo "  FAIL: ${cmd} not found"
    exit 1
  fi
}

check_cmd "Docker" docker
check_cmd "Git" git
check_cmd "kubectl" kubectl
check_cmd "Kind" kind
check_cmd "Make" make

echo ""
echo "[CHECK] Docker daemon"
if docker ps >/dev/null 2>&1; then
  echo "  OK: Docker is running"
else
  echo "  FAIL: Docker command exists, but Docker daemon is not running or not accessible"
  exit 1
fi

echo ""
echo "[CHECK] kubectl client"
kubectl version --client

echo ""
echo "[CHECK] Kind"
kind version

echo ""
echo "[CHECK] GitHub CLI optional"
if command -v gh >/dev/null 2>&1; then
  gh --version | head -n 1
  gh auth status || true
else
  echo "  SKIP: gh is not installed"
fi

echo ""
echo "기본 도구 확인 완료"
