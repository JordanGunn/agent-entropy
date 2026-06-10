# III. The Whole Context

*What a window must hold — and why the goal is something the agent infers from it, not something it keeps.*

The unease in the opening section did not arrive as one complaint. It arrived as several: *the model forgot what I wanted*, *the cleanup made the code worse*, *the names drifted*, *it warned me about a migration that cannot matter yet*. The four-entropies section named the mechanism that keeps all of them hidden — **a system optimised for agreement does not surface the gap; it fills it**. This section names the thing all of those complaints are complaints *about*.

It is not the code. It is not the model. It is the context the model was working from.

> The agent never edits your codebase.
> It edits the context it was given, and emits a diff.
> The codebase is downstream of a window you never inspect.

## The window is a pile

In most agentic tools, context means whatever happened to fit in the window at the moment of generation: recent chat, the files that were open, a memory blob, a retrieved snippet, a system prompt, and a guess about relevance. This is useful, but it is not an artifact. It is **a pile** — assembled by recency and convenience, never audited, never frozen, never the same twice. The agent reasons over the pile, and the pile is lossy, recency-biased, and unaccountable.

The damage this paper catalogues is not, in the first instance, damage to the code. It is damage that was already present in the pile before a single line was written. A function that encodes the wrong intent, a remediation that fuses good and bad decisions, a name that drifts, a caution calibrated to a project that does not exist — each is the faithful output of a context that was wrong going in. The model did its job. The job was specified by a pile.

The correction is not more context. More text in the window is not more signal — the literature on long-context degradation already shows that models use the middle of a long window poorly *(Liu et al., 2023)*. The correction is to ask a sharper question: what would a context window have to hold, at minimum, for an agent to keep the work on trajectory across many turns and many sessions? That question has a determinate answer, and the answer is the theoretical target the rest of this paper measures real contexts against.

## The target: a context the goal can be inferred from

A context window holds trajectory when it preserves four things no agent can reconstruct on its own — what it has understood, what time has made of the work, the structure it acts against, and what action is allowed. The goal is not among them. The goal is what the agent infers from all four.

```text
ARTICULATION (r) = PROMPT − INTENT             per-turn gap: what was said minus what was meant
COMPREHENSION    = Σ A(r)                      the agent's reading of each articulation, accumulated
---
TRAJECTORY       = PROVENANCE + HORIZON        the time-bearing context — past and future
PROVENANCE       = Δ(CONTEXT)                  The difference between the context at two poitns in time
EXPRESSION       = PRECISON * ABSTRACTION      granular access to structured abstract representation of compelx relationships
AUTHORITY        = PERMISSION + GOVERNANCE     what may be done, and the world it must stay valid inside
---
CONTEXT (C)      = COMPREHENSION + TRAJECTORY + EXPRESSION + AUTHORITY
---
GOAL             = A(C)                        the objective, inferred from the whole context
```

This inverts the relationship the field usually assumes. The goal is not a value the window stores; it is a value the agent computes — `A(C)`, the context resolved into an objective by the same agentic operation the approximation section anatomises, here run over the whole context as its argument. That is precisely why the goal is so easy to lose. A stored value persists; a computed one is recomputed every time — and `A` does not reproduce (`A₁(C) ≠ A₂(C)`), so the goal is never the same twice unless `C` is held fixed. "The model forgot what I wanted" is not forgetting. It is re-derivation against a context no one froze.

## The four components

Each component answers a different question, changes at a different rate, and does a different job — and the jobs are separable, which is what makes the decomposition testable rather than decorative.

```text
COMPREHENSION : what is wanted
TRAJECTORY    : what time has made true, false, unknown, or necessary
EXPRESSION    : what structure exists
AUTHORITY     : what action is allowed
```

**Comprehension — what is wanted.** The prompt is not the intent; it is the intent *articulated*, and articulation is lossy. `ARTICULATION = PROMPT − INTENT` is the gap between the two, refilled every turn from priors the user never sees. What the agent accumulates is not the intent but its *reading* of each articulation, summed across turns: `COMPREHENSION = Σ A(i)`. The intent-gap section is the anatomy of that sum, and of why no participant holds it — the agent keeps only the latest term, the user a lossy reconstruction of the rest.

**Trajectory — what time has made of the work.** Two tenses the present rests on: **provenance**, the past the code already embeds, and **horizon**, the future it is trying to keep room for. Provenance is not memory and not mere history; it is the delta between context states — `PROVENANCE = Δ(context over time)` — the record of what changed, what was assumed, what was decided, what was left unresolved, and what a later state superseded. It governs *integration*: extending and updating existing work instead of duplicating it or welding new onto old. Horizon governs *creation*: the permission to keep a door open that a context-blind agent would otherwise suppress as premature. Trajectory is the time-bearing context of the work — not what is remembered, but what time has made true, false, unknown, or necessary.

**Expression — what structure exists.** The relationships the work is made of, held in a form compact enough to survive the window. It exists to answer a problem the other components create: a comprehensive context would overflow if every relationship were spelled out in prose. Expression is the **compression** — a schema, a graph, a skeleton — that holds the relationships precisely while spending almost none of the window. The earlier framing placed expression outside the context, as a build-side concern; that was wrong. The structural model is something the agent reads before it acts, which makes it context like any other — the most schema-heavy component, and the one that makes a comprehensive `C` fit at all.

**Authority — what action is allowed.** What may be done, by whom, within what bounds. `AUTHORITY = PERMISSION + GOVERNANCE`: **permission** is who may authorise an action and what has actually been delegated to the agent, and **governance** is the external constraint surface the action must conform to even when permission is valid — the operating world (environment, cluster, namespace, subscription, the signed specification, the public contract) that survives any local *yes*. Risk lives here too, but as one input to authority rather than the controlling idea. The earlier framing called this *stakes* and held it outside the context as a static regime; that was too narrow. Authority is action-bearing context like the rest — read before the agent acts, and decaying when it is inferred from conversation instead of declared.

A clean comprehension does not explain how the work came to be; a complete trajectory says nothing about what may be done with it; a precise expression carries no authority. Each is missing on its own terms; each must be supplied on its own terms.

## The layers move at different speeds

The four components are not one thing, updated together. They change at different rates, and the rate is a property of the thing:

- **comprehension** moves at the speed of the *prompt* — every turn;
- **expression** at the speed the *structure* changes;
- **provenance** accretes one *decision* at a time;
- **horizon** shifts only when the *direction* does;
- **governance** changes rarely — the operating world is a *slow* truth — but must be present every time the agent acts;
- **permission** drifts *within a session*, nudged broader or narrower turn by turn.

This is **pace layering** — Stewart Brand's account of why buildings and civilisations endure (*How Buildings Learn*, 1994, building on Frank Duffy's *shearing layers*). A system survives by letting each layer move at its own speed: *the fast layers propose, the slow layers dispose; the fast learn, the slow remember.* Couple them — force a slow layer to a fast layer's pace — and the structure tears.

Nearly every agentic tool in wide use couples them. The window has one update channel — the prompt — so every slow layer is dragged to prompt-speed. Provenance that should accrete over months is re-stated badly or dropped each turn; governance that should be declared once is re-guessed from nothing, while permission drifts unaudited; the structural model that should track the codebase is narrated again, or left to go stale. The rot this paper catalogues is a pace-layer failure — a slow truth updated at the wrong speed, or not at all. The artifacts the later chapters propose are not "memory" in the usual sense. They are the mechanism that lets each layer move at its own pace again — and the reason a comprehensive context is achievable rather than a contradiction in terms.

## Why a fixed context is the point

Put the pieces together and the objective the whole paper serves comes into view. If `GOAL = A(C)` and the slow layers of `C` are fixed — provenance sealed, horizon current, governance pinned, structure tracked — then the only thing moving between one run and the next is the fast layer, the articulation. A comprehensive, fixed context is a program, written in natural language; `A` is the interpreter; the goal and the diff are the run. You do not get bit-exact replay — `A₁(C) ≠ A₂(C)` forbids it — but you get replay to the resolution the schema pins down, which is exactly what the approximation section means by `D(x) ≈ A(C)`. Fix a comprehensive `C`, and agent work becomes correctable at the grain of its context, replayable, and runnable like a script — the deterministic procedure you could never finish writing, approximated by inference over a context you can.

This is the inversion the paper is built on. *The unit of agentic engineering is not the prompt; it is the context* — an artifact you compose, freeze, and version, not a pile you refill.

## What the agent receives, builds, and leaves behind

The context above is the **receive** side — what an ideal window holds before the agent acts. The intent-gap section walks comprehension; the trajectory section walks provenance and horizon; the expression section walks the structural component; the authority section walks permission and governance. Each names the failure of an empty component, the prior art that assumed a human carried it, and the artifact that has to carry it now.

What the agent **builds** is `A(C)` — the goal, and the diff that pursues it. *How well it builds is downstream of how complete `C` was.*

What you **measure** is the residue. The quality section reads the artifact's quality — its structure and its vocabulary, `QUALITY = STRUCTURE + VOCABULARY`. The measurement section reads the transcript — the disambiguation an impoverished context forces, which is computable. These degradations have names: the **Entropy of Interaction** (comprehension), the **Entropy of Trajectory** (provenance and horizon), the **Entropy of Expression** (the structure), and the **Entropy of Authority** (permission and governance). All four are dynamic — they rise co-variantly as their layers decay — and quality is where they fossilise.

## None of this is new

The idea that a system needs a single coherent stance behind every local decision is **conceptual integrity**, and Brooks named it the most important consideration in system design half a century ago *(Brooks, F.P., 1975)*. His mechanism was an architect — one mind that carried the whole design and vetoed any local choice that violated it. That mind held the understanding, the history, the direction, and the structure at once, and knew what it was authorised to change and what it was not — and brought all of it to bear on every line.

The architect is the carry that is now empty. The agent holds no comprehension between sessions, no history it did not just read, no direction it was not just told, no structure it did not just infer, and no authority it was not just handed. The target this section defines is the architect's carry, externalised into artifacts that each move at their own speed — because the participant that used to hold conceptual integrity in one head has left the loop, and the participant that replaced it holds nothing between one prompt and the next.

---

The model did not get worse. The context it works from got poorer. Every chapter that follows takes one source of the disorder: what it is, how it fails, who used to carry it, and the artifact that has to carry it now. Precision at the point the context is assembled is cheaper than precision at the point the damage is found, and the difference compounds across every commit that inherits the window.

---

## Experiments

**Component ablation against a fixed task.** Take a battery of development tasks for which a complete context can be authored by hand — *comprehension, the provenance of the touched files, horizon, the structural model, and the authority the work runs under* — and ablate one component at a time against the full-context control, measuring output quality against a held-out specification alongside the transcript metrics of the measurement section. The hypothesis is that each ablation degrades a distinct, separable dimension — comprehension-ablation raises outcome variance, provenance-ablation raises duplication and net-additive fusion, horizon-ablation produces locally-clean choices a reviewer flags as future-hostile, expression-ablation raises boundary violations and re-implementation, and authority-ablation produces both actions taken outside the declared bounds and over-cautious refusals inside them. A confirmed result establishes the four components as independent channels, not facets of one underspecification.

**Pile versus whole context, held to equal length.** Give two agents the *same token budget* of context for the same task: one a conventional pile (recent chat, open files, a memory blob), the other a context occupying the components in equal size. Hold length constant so the comparison isolates structure, not quantity. The hypothesis is that the component-structured configuration produces lower outcome variance and lower disambiguation overhead at equal token cost — evidence that the gain is organisation of context, not volume of it.

**Replay under a fixed context.** Fix a comprehensive `C` — slow layers frozen, governance pinned — run the same task from clean sessions repeatedly, then perturb exactly one component and re-run. The hypothesis is two-part: that outcome variance under a fully fixed `C` collapses toward the floor the non-equivalence axiom allows (replay to schema resolution), and that a single-component perturbation moves the output along that component's signature dimension only — establishing that a fixed context behaves like a program whose edits are localisable. This is the direct test of agent work as replayable script.
