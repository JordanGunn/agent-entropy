---
name: deps
license: MIT
description: |
  Module dependency graph skill. Builds an import graph from source files,
  computes per-file coupling metrics (afferent Ca, efferent Ce, instability), and
  detects import cycles. Read-only. Tree-sitter is optional — text-tier regex fallback
  always runs.
metadata:
  author: Jordan Godau
  version: 0.1.0
  references:
  - references/01_SUMMARY.md
  - references/02_INTENT.md
  - references/03_POLICIES.md
  - references/04_PROCEDURE.md
  scripts:
  - scripts/skill.sh
  - scripts/skill.ps1
  keywords:
  - deps
  - dependencies
  - dependency-graph
  - coupling
  - instability
  - cycles
  - import-graph
  - code-analysis
  oasr:
    hash: sha256:590432ca846d872d88f2bc1e609004505dbc6f6699f9f359a5312dc03e6c6b90
    source: /home/jgodau/work/personal/skills/aux/skills/deps
    synced: '2026-03-31T20:41:20.241796Z'
---

# INSTRUCTIONS

> **Do not read reference files directly.**
> Run `./scripts/skill.sh init` to load all references in a single call.

1. Run `./scripts/skill.sh init` and follow the instructions.
