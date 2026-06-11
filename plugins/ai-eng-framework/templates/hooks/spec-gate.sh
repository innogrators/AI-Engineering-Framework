#!/usr/bin/env bash
# Spec gate (opt-in, strict spec-first mode) — PreToolUse hook for Edit|Write.
#
# Blocks edits to source files while specs/ contains no approved spec
# (a file with a "Status: APPROVED" line). This turns the implement-feature
# precondition from an instruction into an enforced gate.
#
# Install: copy to <project>/.claude/hooks/spec-gate.sh (chmod +x) and add the
# hook from settings.example.json to <project>/.claude/settings.json.
# Escape hatch for genuinely trivial changes: SKIP_SPEC_GATE=1 claude
#
# Limitations: this is a coarse gate — it checks that *some* approved spec
# exists, not that the edit belongs to it. Right-size per project by adjusting
# SOURCE_PATTERN, or do not install the hook at all and rely on CI gates only.
#
# Trust anchor: this hook only READS the APPROVED line. What makes the line
# trustworthy is CODEOWNERS on specs/ + the spec-approval-guard CI job
# (see templates/ci/) — without those, anyone can set it.

set -euo pipefail

[ "${SKIP_SPEC_GATE:-0}" = "1" ] && exit 0

# Paths considered "implementation" (adjust per project).
SOURCE_PATTERN='^(src|app|lib|server|api)/'

INPUT=$(cat)
FILE_PATH=$(printf '%s' "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')

# Not a file edit we care about -> allow.
[ -z "$FILE_PATH" ] && exit 0
REL_PATH="${FILE_PATH#"$PWD"/}"
printf '%s' "$REL_PATH" | grep -Eq "$SOURCE_PATTERN" || exit 0

# Allow if any approved spec exists.
if [ -d specs ] && grep -rlq "Status: APPROVED" specs/ 2>/dev/null; then
  exit 0
fi

echo "Spec gate: no approved spec found in specs/ (need a file containing 'Status: APPROVED')." >&2
echo "Run /write-spec and get it approved first, or set SKIP_SPEC_GATE=1 for a trivial change." >&2
exit 2
