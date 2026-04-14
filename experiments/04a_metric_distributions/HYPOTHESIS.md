---
id: 04a_metric_distributions
title: Metric Distributions in AI-Generated vs Human-Written Code
paper_section: "Section IV: What Messy Actually Means"
type: benchmarking
status: proposed
tools_required:
  - tools/metrics
---

# Hypothesis

AI-generated codebases exhibit statistically distinct metric distributions
from human-written codebases on Distance from Main Sequence, LCOM,
Cyclomatic Complexity, and Cognitive Complexity -- clustering differently
on the Abstractness/Instability plane.

## Prediction

- AI-generated code will cluster closer to the Zone of Pain (stable and
  concrete) due to the agent's tendency toward concrete implementations
  without abstraction layers.
- LCOM scores will be higher in AI-generated code, reflecting classes that
  accumulate responsibilities across sessions without cohesion review.
- Cognitive Complexity will show a wider variance in AI-generated code,
  with more functions exceeding standard thresholds.

## Design Summary

Compute Distance, LCOM, CCX, and Cognitive Complexity across a matched
sample of AI-generated vs human-written codebases. Compare distributions
and test for statistically significant clustering differences on the
Abstractness/Instability plane.
