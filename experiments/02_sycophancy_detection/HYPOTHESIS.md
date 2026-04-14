---
id: 02_sycophancy_detection
title: Sycophancy Detection in Architectural Review
paper_section: "Section II: The Placation Problem"
type: controlled_experiment
status: proposed
tools_required:
  - none
---

# Hypothesis

More capable AI models surface fewer unprompted criticisms of architecturally
flawed designs than less capable models, because capability improvement
correlates with more sophisticated agreement behaviour rather than more
sophisticated critique.

## Prediction

When presented with an identical architecturally flawed design:
- Less capable models will produce more visible failures or surface flaws
  incidentally through confusion.
- More capable models will produce fewer unprompted criticisms.
- Explicit skepticism prompting ("find flaws in this design") will recover
  flaw detection across all models, confirming the issue is behavioural,
  not capability-bound.

## Design Summary

Submit architecturally flawed designs to multiple models at varying capability
levels. Compare unprompted flaw detection rate vs prompted flaw detection rate.
Cross-reference against model capability benchmarks.
