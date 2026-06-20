# 3. Inference

*Why a deterministic procedure and an agentic one are not rivals but the two ends of a single dial.*

Not every artifact in an agentic system should be made deterministic, and not every one should be left to inference. The two are usually posed as rivals: *automate it properly* versus *let the model handle it*. They are not rivals. They are the two ends of one dial.

> A deterministic procedure `D(x…)` enumerates: given the same arguments, it returns the same output. It is reproducible by definition.
> An agentic procedure `A(I)` infers: given an instruction `I`, it reasons over it to generate an output.

An instruction is `I = S | P`: a schema `S` and prose `P` together, the structured constraints and the judgement that cannot be structured. This is the same `I` the next section's context model calls `C`: a context is an instruction, the largest one the agent receives, and `GOAL = A(O, C)` is `A` run over it under a directive.

The two differ in one load-bearing property: **inference does not reproduce**. `A₁(I) ≠ A₂(I)`; two runs of the same instruction do not return the same output. The non-determinism lives in the process, not the instruction, and no amount of precision in `I` removes it. Sampling, floating-point non-associativity, batch effects, and their compounding across a trajectory guarantee it in deployment.

This is not a defect to engineer away. It is the property that lets `A` reach cases no one foresaw. Where `D` covers a case by holding a branch for it, and so is bounded by `|x|`, the size of the case space that must be enumerated in advance, `A` covers a case by reasoning about it, and so generalises across the space instead. Small, known case spaces belong to `D`: cheap, complete, verifiable. Combinatorial ones belong to `A`: the only viable tool, and the only one agentic technology newly provides.

## Schema buys back reproducibility

If `A` never reproduces, dependability comes from `S`. The schema is a deterministic projection laid over `A`'s output: it collapses divergent generations onto a bounded admissible set, and buys back equivalence to the resolution it enforces and no finer. A schema that admits one value gets exact reproduction; a schema silent on naming lets naming diverge. That projection is the `≈` in `D(x…) ≈ A(I)`: the schema is the deterministic spine, the prose is the inferential range, and the `≈` is the residue the non-reproducibility guarantees will remain. You do not eliminate the variance. You decide, field by field, what resolution of agreement the work requires, and spend schema to pin exactly that much.

This is the move the rest of the paper applies everywhere, and the design question is never prose or schema in general but where each belongs, field by field:

> **Schema** where ambiguity creates failure: consistency, validation, inspection, comparison, hand-off between agents.
> **Prose** where judgement creates value: nuance, uncertainty, priority, the trade-offs no field can hold.
> **Both** where prose needs containment: the schema bounds, the prose means, and the agent reasons over the prose inside the walls the schema builds.

Schema gives the agent a stable target; prose gives it useful latitude. The goal is never to eliminate variance from agentic systems. It is to decide where variance is dangerous, where it is useful, and where, with a little schema, it can be bounded to exactly the resolution the work requires.
