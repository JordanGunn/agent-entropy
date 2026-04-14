---
name: aux
license: MIT
description: |
  Meta-skill for agent discovery and skill routing. Returns the structured
  capability registry for all aux skills so agents can select the right skill, understand
  composition patterns, and bootstrap with no prior context.
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
  - aux
  - capabilities
  - discovery
  - routing
  - meta
  - bootstrap
  oasr:
    hash: sha256:e0b7c87e959ccf2ea9b1c0da70bb30a341a984a59f88ae747d2d127edd816fab
    source: /home/jgodau/work/personal/skills/aux/skills/aux
    synced: '2026-03-31T20:41:20.248635Z'
---

# INSTRUCTIONS

> **Do not read reference files directly.**
> Run `./scripts/skill.sh init` to load all references in a single call.

1. Run `./scripts/skill.sh init` and follow the instructions.
