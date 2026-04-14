---
id: 05_controlled_vocabulary_impact
title: Controlled Vocabulary Impact on Agent Output Quality
paper_section: "Section V: The Intent Gap"
type: controlled_experiment
status: proposed
tools_required:
  - tools/controlled_vocabulary
---

# Hypothesis

Providing an agent with a controlled vocabulary reduces structural
divergence in output by constraining the naming surface and preventing
the overloading of terms across module boundaries.

## Prediction

- Agents with a controlled vocabulary will produce code with fewer
  overloaded function names and clearer package boundaries.
- Structural divergence (measured by naming entropy and module coupling)
  will be lower in the vocabulary condition.
- The effect will be most pronounced in codebases that have already
  accumulated semantic smells, where the vocabulary provides a
  correction surface the agent otherwise lacks.

## Design Summary

Identical tasks given to agents under two conditions: with and without a
controlled vocabulary. Measure structural divergence in naming and module
boundaries. This experiment isolates the semantic pillar; intent
interception is tested separately in experiment 05b.
