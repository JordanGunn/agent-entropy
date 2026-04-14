---
id: 07_three_pillar_benchmarking
title: Three-Pillar Intervention Benchmarking
paper_section: "Section VII: A Framework of Interventions"
type: controlled_experiment
status: proposed
tools_required:
  - tools/ttr_tpo
  - tools/metrics
  - tools/skepticism_hook
  - tools/iris
  - tools/controlled_vocabulary
---

# Hypothesis

Each intervention pillar (structural, semantic, intent) produces an
independent, additive reduction in context consumption and TPO, and
all three together produce a corresponding reduction in outcome variance.

## Prediction

- Structural pillar alone will reduce context consumption (replicating
  the ~47% reduction observed in preliminary benchmarking).
- Semantic pillar alone will reduce naming entropy and disambiguation
  overhead.
- All three pillars combined will produce the largest reductions in
  TTR, TPO, and context consumption, with measurably lower outcome
  variance across repeated runs.
- Metric enforcement hooks will achieve a low false positive rate
  against a sample codebase (below 10%).

## Design Summary

10-20 representative agentic coding tasks, each run under four conditions:
barebones, structural only, semantic only, all three pillars. Record
context consumption and TPO. Implement metric enforcement hooks gating on
D-score, LCOM, and Cognitive Complexity. Measure false positive rate.
