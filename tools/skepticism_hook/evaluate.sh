#!/usr/bin/env bash
# skepticism_hook/evaluate.sh
#
# A UserPromptSubmit hook that evaluates prompts for architectural ambiguity
# before they reach the implementation agent. Uses Claude Haiku for speed.
#
# Behaviour:
#   - Clear prompts: pass through silently (exit 0, no output)
#   - Ambiguous prompts: inject concern as additional context (exit 0 + JSON)
#   - API failure: pass through silently (graceful degradation)
#
# Requires: ANTHROPIC_API_KEY environment variable, curl, jq

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="${SCRIPT_DIR}/prompt.md"
LOG_DIR="${SCRIPT_DIR}/logs"
MODEL="claude-haiku-4-5-20251001"
MAX_TOKENS=256

# Read hook input from stdin
INPUT=$(cat)
USER_PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# Skip evaluation for empty or very short prompts
if [ -z "$USER_PROMPT" ] || [ ${#USER_PROMPT} -lt 10 ]; then
    exit 0
fi

# Skip evaluation for slash commands and system commands
if [[ "$USER_PROMPT" == /* ]] || [[ "$USER_PROMPT" == !* ]]; then
    exit 0
fi

# Ensure API key is available
if [ -z "${ANTHROPIC_API_KEY:-}" ]; then
    # No API key — pass through silently
    exit 0
fi

# Read the evaluation prompt
if [ ! -f "$PROMPT_FILE" ]; then
    exit 0
fi
SYSTEM_PROMPT=$(cat "$PROMPT_FILE")

# Call Claude API
RESPONSE=$(curl -s --max-time 15 \
    https://api.anthropic.com/v1/messages \
    -H "anthropic-version: 2023-06-01" \
    -H "x-api-key: ${ANTHROPIC_API_KEY}" \
    -H "content-type: application/json" \
    -d "$(jq -n \
        --arg model "$MODEL" \
        --argjson max_tokens "$MAX_TOKENS" \
        --arg system "$SYSTEM_PROMPT" \
        --arg prompt "$USER_PROMPT" \
        '{
            model: $model,
            max_tokens: $max_tokens,
            system: $system,
            messages: [{role: "user", content: $prompt}]
        }'
    )" 2>/dev/null) || {
    # API call failed — pass through silently
    exit 0
}

# Extract the text content from the response
EVAL_TEXT=$(echo "$RESPONSE" | jq -r '.content[0].text // empty' 2>/dev/null) || exit 0

if [ -z "$EVAL_TEXT" ]; then
    exit 0
fi

# Parse the evaluation result
IS_AMBIGUOUS=$(echo "$EVAL_TEXT" | jq -r '.ambiguous // false' 2>/dev/null) || exit 0
CONCERN=$(echo "$EVAL_TEXT" | jq -r '.concern // empty' 2>/dev/null) || exit 0

# Log the decision (for experiment data collection)
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
echo "$TIMESTAMP|$SESSION_ID|$IS_AMBIGUOUS|$CONCERN" >> "${LOG_DIR}/decisions.log"

# If ambiguous, inject the concern as additional context
if [ "$IS_AMBIGUOUS" = "true" ] && [ -n "$CONCERN" ]; then
    jq -n \
        --arg concern "$CONCERN" \
        '{
            hookSpecificOutput: {
                hookEventName: "UserPromptSubmit",
                additionalContext: ("[Skepticism Hook] Before proceeding, consider this ambiguity in the user\u0027s request: " + $concern + "\n\nSurface this concern to the user and resolve it before implementing.")
            }
        }'
fi

exit 0
