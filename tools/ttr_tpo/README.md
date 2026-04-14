# TTR / TPO Measurement Tooling

Computes Thinking Token Ratio (TTR) and Token-Per-Operation ratio (TPO)
from Claude Code session transcripts.

## Purpose

Provides the primary proxy metrics described in Section VIII for detecting
intent smells and measuring disambiguation overhead.

## Metrics

- **TTR** = reasoning_tokens / total_tokens
- **TPO** = total_tokens / atomic_operation_count
- **Context Consumption** = total tokens consumed per task
- **Action Density** = tool_calls / total_tokens (inverse of TPO)

## Used By

- `experiments/07_three_pillar_benchmarking/`
- `experiments/08_proxy_metrics_validation/`

## Input

Claude Code session transcript files (JSON format).

## Status

Not yet implemented.
