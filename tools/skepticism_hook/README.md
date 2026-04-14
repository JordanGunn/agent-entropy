# Skepticism Hook (UserPromptSubmit)

A Claude Code UserPromptSubmit lifecycle hook that evaluates prompts for
architectural ambiguity before they reach the implementation agent.

## Purpose

Implements the intent pillar intervention described in Section V and
Section VII. Surfaces ambiguity in user prompts at the lowest-cost
point (before implementation begins) rather than allowing underspecified
intent to propagate into the codebase.

This is the **active interception** variant. The project also includes a
passive variant (`.claude/rules/SKEPTICISM.md`) that instructs the agent
to be skeptical but relies on the agent's own judgment. The hook evaluates
the prompt independently, before the agent sees it.

## How It Works

1. User submits a prompt.
2. `evaluate.sh` intercepts via the UserPromptSubmit hook.
3. The prompt is sent to Claude Haiku for ambiguity evaluation.
4. If ambiguous: a concern is injected as additional context. The agent
   sees both the prompt and the concern, and surfaces it to the user.
5. If clear: the prompt passes through unchanged.
6. If the API call fails: the prompt passes through unchanged (graceful
   degradation).

The hook **never blocks**. It surfaces concerns; it does not gate
implementation. The user maintains full authority.

## Files

- `evaluate.sh` — The hook script (bash, uses curl + jq)
- `prompt.md` — The skepticism evaluation prompt sent to the model
- `settings.example.json` — Example Claude Code hook configuration
- `logs/decisions.log` — Auto-generated decision log for experiment data

## Installation

1. Copy the hook configuration into your project's `.claude/settings.json`:
   ```json
   {
     "hooks": {
       "UserPromptSubmit": [
         {
           "type": "command",
           "command": "\"$CLAUDE_PROJECT_DIR\"/tools/skepticism_hook/evaluate.sh",
           "timeout": 20
         }
       ]
     }
   }
   ```

2. Ensure `ANTHROPIC_API_KEY` is set in your environment.

3. Ensure `curl` and `jq` are available.

## Testing

```bash
# Test with a clear prompt
echo '{"prompt":"Fix the typo on line 42 of README.md","session_id":"test"}' \
  | ./tools/skepticism_hook/evaluate.sh
# Expected: exit 0, no output

# Test with an ambiguous prompt
echo '{"prompt":"Add caching to the app","session_id":"test"}' \
  | ./tools/skepticism_hook/evaluate.sh
# Expected: exit 0, JSON with additionalContext containing the concern
```

## Decision Log

Every evaluation is logged to `tools/skepticism_hook/logs/decisions.log`
in pipe-delimited format:

```
timestamp|session_id|is_ambiguous|concern
```

This log is the primary data source for experiment 05b.

## Requirements

- `ANTHROPIC_API_KEY` environment variable
- `curl`
- `jq`
- Claude Haiku API access

## Used By

- `experiments/05b_intent_interception/` (hook condition)
- `experiments/07_three_pillar_benchmarking/` (intent pillar)
