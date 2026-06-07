# Determinism and Inference

*Why a deterministic procedure and an agentic one are not rivals but the two ends of a single dial — and the one variable that sets it.*

Not every artifact in an agentic system should be made deterministic, and not every one should be left to inference. The two are usually posed as rivals — *automate it properly* versus *let the model handle it*. They are not rivals. They are the two ends of a single dial, and one variable decides where the dial should sit.

## Two ways to produce an output

> A deterministic procedure `D(x…)` enumerates. Given the same arguments, it returns the same output — reproducibility is its definition.
> An agentic procedure `A(I)` infers. Given instructions `I`, it generates an output by reasoning over them.

Write `I = S | P` — an instruction is a schema `S` and prose `P` together: the structured constraints, and the judgement that cannot be structured. This is the same `I` the whole-context section calls `C`: a context is an instruction — the largest one the agent receives, and `GOAL = A(C)` is just `A` run over it.

The two differ in one load-bearing property.

## Inference does not reproduce

> `A₁(I) ≠ A₂(I)`. Two executions of the same instructions do not return the same output — not for any output large enough to matter.

This is the defining contrast with `D`, and it is not a defect to engineer away. The non-determinism lives in the process, not the instructions — so no amount of precision in `I` removes it. Tightening the schema shrinks the space of outputs `A` ranges over; it does not make `A` deterministic. Exact equivalence is reachable only in the limit, where the schema collapses the admissible set to a single value — a boolean, a validated enum. Everywhere above that floor, `A` diverges, and the divergence is empirical, not merely theoretical: sampling, floating-point non-associativity, batch effects, and the compounding of all three across a multi-step trajectory guarantee it in deployment.

It is tempting to read this as inference's weakness. It is the source of its value.

## The dial is set by `|x|`

Here is the mechanism. `D` reproduces because it enumerates — it covers a case by holding a branch for it. That is exactly why it is bounded by `|x|`, the size of the case space: every case must be foreseen and written. While `|x|` is small and known, `D` is unbeatable — cheap, complete, verifiable. But as `|x|` grows toward the combinatorial, the cost of covering it rises without bound and the gaps become defects. `D` does not fail loudly at the wall; it fails as the case no one enumerated.

`A` diverges because it generates — it covers a case by reasoning about it, not by storing a branch for it. That is exactly why it is unbounded over `|x|`: it generalises across the case space instead of enumerating it. The same property that makes it non-reproducible is the property that lets it reach cases no one foresaw.

> One mechanism, two faces. `D`: enumerate → reproducible, bounded by `|x|`. `A`: generate → unbounded over `|x|`, never reproducible.

So the preference between them is not taste; it is a function of `|x|`:

> Small, known `|x|` — use `D`. Determinism is cheap and complete.
> Combinatorial `|x|` — use `A`. The `D` you would write is infeasible and full of holes; inference is the only viable tool — and the only one agentic technology newly provides.

The relation usually written `D(x…) ≈ A(I)` is the low-`|x|` statement: where you could have written `D`, inference approximates it. Past the wall there is no feasible `D` to approximate; `A` is not an approximation of anything — it is the primitive. The novelty of the moment is not that inference imitates determinism. It is that inference reaches the cases determinism never could.

## Schema buys back reproducibility

If `A` never reproduces, how is any agentic system dependable? Through `S` — the schema, which is a deterministic projection laid over `A`'s output. It collapses divergent generations onto a bounded admissible set, and it buys back equivalence to the resolution it enforces and no finer. A schema that admits one value gets exact reproduction; a schema silent on naming lets naming diverge.

That projection is the `≈` in `D(x…) ≈ A(I)`. The schema is the deterministic spine; the prose is the inferential range; the `≈` is the residue the non-equivalence axiom guarantees will remain. You do not eliminate the variance. You decide, field by field, what resolution of agreement the work requires, and spend schema to pin exactly that much.

This is the move the rest of the paper applies, everywhere:

- The **intent record** of the intent-gap section is an `I` — schema for the what and why that cannot be left blank, prose for the judgement that cannot be structured.
- The **posture** artifacts pin the slow layers so `A(C)` stops re-deriving them, and stakes is the schema for authority — the regime that fixes the definition of done.
- The **expression** model is almost all `S`: the schema-heaviest component, relationships projected to a resolution prose could never hold without overflowing the window.
- The **quality** metrics push all the way to `D`, for a reason that is not `|x|` at all but trust: a number computed by external tooling is one the agent cannot agree its way around — agreement is cheap; arithmetic is not.
- And `GOAL = A(C)` is the largest instance of all. The context is the `I`; the replay objective of the whole-context section is `D(x…) ≈ A(C)` read at the scale of a whole project — fix enough of `C` as schema, and the run reproduces to the resolution that schema pins.

## Where each belongs

The design question is never prose or schema in general. It is where each belongs, field by field:

> **Schema** where ambiguity creates failure — consistency, validation, inspection, comparison, persistence, hand-off between agents.
> **Prose** where judgement creates value — nuance, uncertainty, priority, interpretation, the trade-offs no field can hold.
> **Both** where prose needs containment — the schema bounds, the prose means, and the agent reasons over the prose inside the walls the schema builds.

Schema gives the agent a stable target; prose gives it useful latitude; the agent turns prose into action; schema makes that action inspectable. The goal is not to eliminate variance from agentic systems. It is to decide where variance is dangerous, where it is useful, and where — with a little schema — it can be bounded to exactly the resolution the work requires.
