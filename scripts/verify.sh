#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
export PATH="${ROKIT_ROOT:-$HOME/.rokit}/bin:$PATH"

if ! command -v git >/dev/null; then
  echo 'Git is required; see docs/TESTING.md.' >&2
  exit 1
fi

echo "==> Git whitespace checks"
git diff --check
git diff --cached --check

# CI supplies the PR base or pre-push SHA; locally check the latest commit.
whitespace_base="${VERIFY_BASE_SHA:-}"
if [[ "$whitespace_base" == "0000000000000000000000000000000000000000" ]]; then
  whitespace_base="$(git hash-object -t tree /dev/null)"
elif [[ -z "$whitespace_base" ]]; then
  if git rev-parse --verify HEAD^ >/dev/null 2>&1; then
    whitespace_base="HEAD^"
  else
    whitespace_base="$(git hash-object -t tree /dev/null)"
  fi
fi
echo "==> Committed whitespace check against $whitespace_base"
git diff --check "$whitespace_base" HEAD

if ! command -v python3 >/dev/null; then
  echo 'Python 3 is required; see docs/TESTING.md.' >&2
  exit 1
fi
python3 scripts/roblox-types.py --check

required_tools=(
  stylua
  selene
  rojo
  luau-lsp
  lune
)

for tool in "${required_tools[@]}"; do
  if ! command -v "$tool" >/dev/null 2>&1 || ! "$tool" --version >/dev/null 2>&1; then
    echo "Missing or unusable pinned tool: $tool" >&2
    echo "Run: ./scripts/bootstrap.sh" >&2
    exit 1
  fi
done

echo "==> Formatting"
stylua --check src tests

echo "==> Linting"
selene src tests

echo "==> Generating Rojo sourcemap"
mkdir -p build
rojo sourcemap default.project.json --output build/sourcemap.json

echo "==> Luau type analysis"
luau-lsp analyze \
  --platform roblox \
  --definitions=build/globalTypes.d.luau \
  --sourcemap=build/sourcemap.json \
  --base-luaurc=.luaurc \
  src tests

echo "==> Harness initialization tests"
python3 -m unittest discover -s tests/harness -p 'test_*.py'

echo "==> Unit tests"
test_count=0
while IFS= read -r -d '' test_file; do
  lune run "$test_file"
  test_count=$((test_count + 1))
done < <(find tests/unit -type f -name '*.spec.luau' -print0)
if [[ "$test_count" -eq 0 ]]; then
  echo 'No unit tests found; add tests/unit/*.spec.luau.' >&2
  exit 1
fi

echo "==> Rojo build"
rojo build default.project.json --output build/game.rbxlx

echo "==> Verification passed"
