---
id: 08_proxy_metrics_validation
title: Proxy Metric Validation Against Session Transcripts
paper_section: "Section VIII: Measuring What Cannot Be Seen Directly"
type: analytical_benchmarking
status: proposed
tools_required:
  - tools/ttr_tpo
---

# Hypothesis

TTR and TPO, computed from session transcripts, produce distinguishable
metric signatures across correct, misconfigured, and semantically ambiguous
task conditions -- validating them as proxy measures for intent quality.

## Prediction

- Scenario A (correct): low TTR, low TPO, low context consumption,
  low outcome variance.
- Scenario B (misconfigured): high TTR spike then halt, high TPO,
  high context consumption, moderate outcome variance.
- Scenario C (ambiguous): sustained high TTR, high TPO, high context
  consumption, high outcome variance.
- Scenarios B and C will produce distinguishable TTR trajectories
  (spike-then-halt vs sustained elevation).
- Outcome variance across 10 repeated Scenario C runs will be
  significantly higher than Scenario A.

## Design Summary

Implement TTR and action density measurement against Claude Code session
transcripts. Run the three-scenario experiment (correct, misconfigured,
ambiguous) across 10-20 representative tasks. Measure metric signatures
per condition and outcome variance across 10 repeated Scenario C runs.
