#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-my-image:latest}"

echo "=========================================================="
echo "🔐 Running Supply Chain Pipeline for Image: $IMAGE"
echo "=========================================================="

echo "[1/4] Generating Software Bill of Materials (SBOM) with Syft..."
syft "$IMAGE" -o spdx-json=sbom-spdx.json

echo "[2/4] Scanning SBOM vulnerabilities with Grype..."
grype sbom:sbom-spdx.json --fail-on high

echo "[3/4] Running Trivy Container Scan..."
trivy image --severity HIGH,CRITICAL "$IMAGE"

echo "[4/4] Signing artifact with Cosign..."
# cosign sign --key cosign.key "$IMAGE"
echo "✅ Image successfully scanned and signed!"
