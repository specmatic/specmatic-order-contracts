#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LICENSE_DIR="${HOME}/.specmatic"
LINTER_CONFIG="specmatic-linter.yaml"

cd "$ROOT_DIR"

OPENAPI_SPECS=()

if [ "$#" -gt 0 ]; then
  SPEC_CANDIDATES=("$@")
else
  while IFS= read -r spec_path; do
    SPEC_CANDIDATES+=("$spec_path")
  done < <(find io -type f -path '*/openapi/*' \( -iname '*.yaml' -o -iname '*.yml' \) | sort)
fi

for spec_path in "${SPEC_CANDIDATES[@]}"; do
  if grep -Eq '^(openapi|swagger):' "$spec_path"; then
    OPENAPI_SPECS+=("$spec_path")
  fi
done

if [ "${#OPENAPI_SPECS[@]}" -eq 0 ]; then
  echo "No OpenAPI spec files found under io/**/openapi."
  exit 0
fi

echo "Running Specmatic linter on ${#OPENAPI_SPECS[@]} OpenAPI specs with the recommended ruleset."

docker run --rm \
  -v "$ROOT_DIR:/usr/src/app" \
  -v "$LICENSE_DIR:/root/.specmatic:ro" \
  -w /usr/src/app \
  specmatic/enterprise \
  lint "${OPENAPI_SPECS[@]}" --config "$LINTER_CONFIG"
