#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-my-image:latest}"
echo "Verifying signature for $IMAGE..."
cosign verify --key cosign.pub "$IMAGE"
echo "✅ Signature verified! Artifact is authentic and untampered."
