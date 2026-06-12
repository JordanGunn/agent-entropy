# III. The Context Model

*What a window must hold, and why the goal is something the agent infers from it, not something it keeps.*

The unease in the opening section did not arrive as one complaint. It arrived as several:
- *the model forgot what I wanted*,
- *the cleanup made the code worse*,
- *the names drifted*,
- *it warned me about a migration that cannot matter yet*.

The four-entropies section named the mechanism that keeps all of them hidden: **a system optimised for agreement does not surface the gap**.

This section names the thing all of those complaints are complaints *about*. It is not the code. It is not the model. It is the context the model was working from.

> The agent never edits your codebase.
> It edits the context it was given, and emits a diff.
> The codebase is downstream of a window you never inspect.

## The Context Window

In most agentic tools, context means whatever happened to fit in the window at the moment of generation: recent chat, the files that were open, a memory blob, a retrieved snippet, a system prompt, and a guess about relevance. This is useful, but it is not an artifact. It is **a pile**, assembled by recency and convenience, never audited, never frozen, never the same twice. The damage this paper catalogues is not, in the first instance, damage to the code. It is damage that was already present in the pile before a single line was written.

The correction is not more context. More text in the window is not more signal. The literature on long-context degradation already shows that models use the middle of a long window poorly *(Liu et al., 2023)*.

The correction is to ask a sharper question: what would a context window have to hold, at minimum, for an agent to keep the work on trajectory across many turns and many sessions? That question is the theoretical target the rest of this paper measures real contexts against.

## The Proposed Model

A context window holds trajectory when it preserves four things no agent can reconstruct on its own:

```text
ARTICULATION (i) = PROMPT − INTENT             per-turn gap: what was said minus what was meant
COMPREHENSION    = Σ A(i)                      the agent's reading of each articulation, accumulated
---
TRAJECTORY       = PROVENANCE + HORIZON        the time-bearing context: past and future
PROVENANCE       = A(Δ(C))                     what changed, was assumed, decided, left open, superseded
EXPRESSION       = PRECISION * ABSTRACTION     granular access to a structured abstract representation of complex relationships
AUTHORITY        = AGENCY + GOVERNANCE         what may be done, and the world it must stay valid inside
---
CONTEXT (C)      = COMPREHENSION + TRAJECTORY + EXPRESSION + AUTHORITY
---
GOAL             = A(C)                        the objective, inferred from the whole context
```

## Cadence

The four components are not one thing, updated together. They change at different rates, and the rate is a property of the thing:

- **comprehension** moves at the speed of the *prompt*, every turn;
- **expression** at the speed the *structure* changes;
- **provenance** accretes one *decision* at a time;
- **horizon** shifts only when the *direction* does;
- **governance** changes rarely (the operating world is a *slow* truth) but must be present every time the agent acts;
- **agency** drifts *within a session*, nudged broader or narrower turn by turn.

This is **pace layering**, Stewart Brand's account of why buildings and civilisations endure (*How Buildings Learn*, 1994, building on Frank Duffy's *shearing layers*). A system survives by letting each layer move at its own speed: *the fast layers propose, the slow layers dispose; the fast learn, the slow remember.*

By coupling them, one forces a slow layer to a fast layer's pace, and the structure tears. Nearly every agentic tool in wide use couples them. The window has one update channel, the prompt, so every slow layer is dragged to prompt-speed. The artifacts the later chapters propose are not "memory" in the usual sense. They are the mechanism that lets each layer move at its own pace again, and the reason a comprehensive context is achievable rather than a contradiction in terms.

## How the Model is Applied

Put the pieces together and the objective the whole paper serves comes into view. If `GOAL = A(C)` and the slow layers of `C` are fixed, then the only thing moving between one run and the next is the fast layer, the articulation. A comprehensive, fixed context is a program, written in natural language; `A` is the interpreter; the goal and the diff are the run. You do not get bit-exact replay: `A₁(C) ≠ A₂(C)` forbids it. But you get replay to the resolution the schema pins down, which is exactly what **agentic approximation** expresses as `D(x) ≈ A(C)`.

Fix a comprehensive `C`, and agent work becomes correctable at the grain of its context, replayable, and runnable like a script.

None of this is new. The need for one coherent stance behind every local decision is **conceptual integrity**, which Brooks named the most important consideration in system design half a century ago *(Brooks, F.P., 1975)*. His mechanism was an architect who held the whole design in one head and vetoed any local choice that broke it. The agent is that architect's carry, now empty: it holds no comprehension between sessions, no history it did not just read, no authority it was not just handed. The model this section defines is that carry, externalised into artifacts that each move at their own speed.

---

## Experiments

**Component ablation against a fixed task.** Take a battery of development tasks for which a complete context can be authored by hand (*comprehension, the provenance of the touched files, horizon, the structural model, and the authority the work runs under*), and ablate one component at a time against the full-context control, measuring output quality against a held-out specification alongside the transcript metrics of the measurement section. The hypothesis is that each ablation degrades a distinct, separable dimension: comprehension-ablation raises outcome variance, provenance-ablation raises duplication and net-additive fusion, horizon-ablation produces locally-clean choices a reviewer flags as future-hostile, expression-ablation raises boundary violations and re-implementation, and authority-ablation produces both actions taken outside the declared bounds and over-cautious refusals inside them. A confirmed result establishes the four components as independent channels, not facets of one underspecification.

**Pile versus whole context, held to equal length.** Give two agents the *same token budget* of context for the same task: one a conventional pile (recent chat, open files, a memory blob), the other a context occupying the components in equal size. Hold length constant so the comparison isolates structure, not quantity. The hypothesis is that the component-structured configuration produces lower outcome variance and lower disambiguation overhead at equal token cost, evidence that the gain is organisation of context, not volume of it.

**Replay under a fixed context.** Fix a comprehensive `C` (slow layers frozen, governance pinned), run the same task from clean sessions repeatedly, then perturb exactly one component and re-run. The hypothesis is two-part: that outcome variance under a fully fixed `C` collapses toward the floor the non-equivalence axiom allows (replay to schema resolution), and that a single-component perturbation moves the output along that component's signature dimension only, establishing that a fixed context behaves like a program whose edits are localisable. This is the direct test of agent work as replayable script.
