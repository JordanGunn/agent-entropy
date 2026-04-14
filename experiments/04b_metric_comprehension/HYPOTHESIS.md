---
id: 04b_metric_comprehension
title: Metric Score Impact on Developer Quality Judgement
paper_section: "Section IV: What Messy Actually Means"
type: user_study
status: proposed
tools_required:
  - tools/metrics
---

# Hypothesis

Providing computable metric scores (Distance, LCOM, CCX, Cognitive
Complexity) to developers without formal training in software metrics
improves their ability to correctly identify lower-quality code samples.

## Prediction

- Without metric scores, developers will perform near chance level at
  identifying the metric-violating sample from a matched pair.
- With metric scores and brief definitions, identification accuracy
  will increase significantly.
- The effect will be strongest for Cognitive Complexity, which
  correlates most closely with subjective reading difficulty.

## Design Summary

Present developers with pairs of functionally equivalent code samples
(one metric-violating, one clean). Measure identification accuracy with
and without metric scores provided. Within-subjects design with
counterbalanced presentation order.
