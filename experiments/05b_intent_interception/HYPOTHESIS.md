---
id: 05b_intent_interception
title: Intent Interception — Passive, Active, and Structural
paper_section: "Section V: The Intent Gap"
type: controlled_experiment
status: proposed
tools_required:
  - tools/skepticism_hook
  - tools/iris
---

# Hypothesis

Intent interception improves agent output quality, and the mechanism
matters: passive behavioral instruction, active pre-prompt evaluation,
and architecturally separated intent verification produce measurably
different outcomes.

## Prediction

Four conditions, measured against each other:

- **Baseline (no intervention)**: The agent receives prompts with no
  skepticism mechanism. Ambiguity propagates into implementation
  unchallenged. Outcome variance across repeated runs will be highest.

- **Passive (SKEPTICISM.md rule)**: The agent is instructed via system
  rules to be skeptical. Some ambiguity will be surfaced, but the agent
  is subject to sycophantic pressure — the same agent that critiques
  the prompt also wants to satisfy the user. Effect will be modest and
  inconsistent.

- **Active (UserPromptSubmit hook)**: An independent model evaluation
  intercepts the prompt before the agent sees it. Ambiguity surfacing
  rate will be higher and more consistent than the passive condition,
  because the evaluator has no implementation stake.

- **Structural (Iris agent)**: A dedicated read-only agent evaluates
  intent before delegating to an implementation agent. This will
  produce the best outcomes if the paper's claim is correct — that the
  problem is structural (the same agent cannot both critique and
  implement without sycophantic bias) rather than merely behavioral.

## Key Experimental Question

If the active hook and Iris produce equivalent results, simple friction
is sufficient and architectural separation adds unnecessary complexity.
If Iris outperforms, the mechanism matters: structural separation of
intent verification from implementation is a necessary intervention,
not just a nice-to-have.

## Design Summary

Representative agentic tasks run under four conditions. Measure:
- Ambiguity surfacing rate (concerns raised per session)
- Output quality via structural metrics (Distance, LCOM, CCX)
- Outcome variance across repeated runs per condition
- Token consumption and TPO per condition

The passive condition uses the existing `.claude/rules/SKEPTICISM.md`.
The active condition uses `tools/skepticism_hook/evaluate.sh`.
The structural condition uses `tools/iris/` (not yet implemented).
