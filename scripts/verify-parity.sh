#!/usr/bin/env bash
set -euo pipefail

# Script de verificación de paridad de contrato OpenAPI
CONTRACTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_REPO="${1:-}"

if [[ -z "$TARGET_REPO" ]]; then
    echo "Uso: $0 <directorio-del-repositorio-a-verificar>"
    exit 1
fi

CANONICAL_HASH="$(sha256sum "$CONTRACTS_DIR/openapi.yaml" | awk '{print $1}')"

if [[ ! -f "$TARGET_REPO/openapi.yaml" ]]; then
    echo "❌ ERROR: No se encontró openapi.yaml en $TARGET_REPO"
    exit 1
fi

TARGET_HASH="$(sha256sum "$TARGET_REPO/openapi.yaml" | awk '{print $1}')"

if [[ "$CANONICAL_HASH" == "$TARGET_HASH" ]]; then
    echo "✅ PARIDAD CONFIRMADA: $TARGET_REPO tiene el contrato idéntico (SHA-256: $CANONICAL_HASH)"
    exit 0
else
    echo "❌ ERROR DE DIVERGENCIA DETECTADO:"
    echo "  Canónico ($CONTRACTS_DIR): $CANONICAL_HASH"
    echo "  Destino  ($TARGET_REPO):   $TARGET_HASH"
    exit 2
fi
