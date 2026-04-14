---
id: 03b_documentation_drift_synthetic
title: Documentation Drift Under Sustained Agent Sessions
paper_section: "Section III: The Rot Beneath the Surface"
type: synthetic_longitudinal
status: proposed
tools_required:
  - none
---

# Hypothesis

A CLAUDE.md file maintained alongside an evolving codebase will exhibit
measurable semantic drift from actual codebase structure over successive
agent sessions, even when the human operator intends to keep it current.

## Prediction

Over 30 agent sessions evolving a single codebase:
- Semantic similarity between CLAUDE.md content and actual codebase
  structure will decrease monotonically.
- Drift will accelerate after a threshold number of sessions as
  compounding inconsistencies outpace manual correction attempts.
- Specific categories of documented decisions (package structure,
  naming conventions, architectural boundaries) will drift at
  different rates.

## Design Summary

Maintain a CLAUDE.md alongside an evolving codebase over 30 agent sessions.
Measure semantic drift between documented intent and actual structure at
each session boundary using embedding similarity and manual annotation.
