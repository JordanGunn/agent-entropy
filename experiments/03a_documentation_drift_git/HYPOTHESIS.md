---
id: 03a_documentation_drift_git
title: Documentation Drift in Open-Source Git History
paper_section: "Section III: The Rot Beneath the Surface"
type: observational_analytical
status: proposed
tools_required:
  - none
---

# Hypothesis

CLAUDE.md and equivalent convention files in open-source repositories
exhibit measurable documentation drift: a consistent lag between documented
architectural decisions and contradicting code changes, detectable through
git history analysis.

## Prediction

Across a sample of repositories using CLAUDE.md or equivalent files:
- The median elapsed time between a documented decision and its first
  contradicting code change will be measurably short (days to weeks).
- Convention files will show lower change-coupling with the code they
  describe than structurally co-dependent source files show with each other.
- Drift will accelerate over repository lifetime, not remain constant.

## Design Summary

Mine git histories of open-source repos using CLAUDE.md or equivalent.
Measure elapsed time between documented decisions and contradicting commits.
Apply Tornhill-style change coupling analysis to documentation artifacts.
