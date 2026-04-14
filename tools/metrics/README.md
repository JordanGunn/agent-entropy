# Metric Computation Tooling

Computes the structural code quality metrics described in Section IV.

## Metrics

- **Distance from Main Sequence** (D-score): |A + I - 1| per package,
  based on Martin's Abstractness and Instability measures.
- **Lack of Cohesion of Methods** (LCOM): Chidamber-Kemerer cohesion
  metric per class.
- **Cyclomatic Complexity** (CCX): McCabe's independent path count per
  function.
- **Cognitive Complexity**: Campbell's nesting-penalised complexity per
  function.

## Used By

- `experiments/04a_metric_distributions/`
- `experiments/04b_metric_comprehension/`
- `experiments/07_three_pillar_benchmarking/`

## Input

Source code directories. Language support TBD (Python and TypeScript
as initial targets).

## Status

Not yet implemented.
