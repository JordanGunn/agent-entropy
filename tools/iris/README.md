# Iris — Intent Verification Agent

A read-only agent whose sole purpose is intent verification, ambiguity
detection, and skepticism. Iris never performs implementation. It
evaluates a user's prompt, surfaces gaps and ambiguities, and only
delegates a clarified prompt to an implementation agent once invariants
are satisfied.

## Purpose

Implements the architectural separation of intent verification from
implementation described in Section V and Section VII. Where the
skepticism hook (tools/skepticism_hook) adds behavioral friction to an
existing agent, Iris is a structurally separate agent that cannot be
biased by the implementation it is evaluating — because it never sees
or participates in that implementation.

## Design Principles

- **Read-only**: Iris has no write access to the codebase. It can read
  files, search code, and inspect structure, but cannot edit, create,
  or delete anything.
- **Short-lived**: Iris runs only at session start. Once intent is
  verified and delegation occurs, Iris exits.
- **Overridable**: The user can override Iris's objections at any time.
  Iris surfaces concerns; it does not gate implementation.
- **Model-agnostic**: Iris's skepticism prompt is portable across any
  agent platform that supports pre-execution hooks or agent chaining.

## Lifecycle (Proposed)

1. User prompt enters Iris.
2. Iris evaluates for ambiguity, underspecification, conflicting intent.
3. If clear: delegate clarified prompt to implementation agent.
4. If ambiguous: surface targeted question(s) to user.
5. Post-delegation (future): memoize session context, compact, recall.

The post-delegation lifecycle (step 5) is proposed but not yet
implemented. It addresses context management for long sessions and is
orthogonal to the core intent verification function.

## Used By

- `experiments/05b_intent_interception/` (Iris condition)
- `experiments/07_three_pillar_benchmarking/` (intent pillar)

## Status

Not yet implemented.
