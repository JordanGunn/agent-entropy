# 7. What Messy Actually Means

The feeling described in the opening section has names, and has had them since 1999.

A *code smell* is any characteristic of source code that hints at a deeper problem, a term Kent Beck coined and Martin Fowler popularised. It is a metaphor borrowed from the physical world: bad code, like something left too long in the refrigerator, announces itself before you can quite explain why. You know it before you can prove it. That is charming, and it is a problem.

## The metaphor has a cost

The olfactory metaphor is an honest admission that the thing it describes resists precise description. Whether something is a smell is subjective, varying by language, developer, and methodology. Fowler catalogued twenty-two (*Feature Envy, Shotgun Surgery, God Class*, and the rest), each evocative enough to recognise and vague enough to argue about. Not being able to identify smells is one of the greatest barriers to refactoring: most developers do not sense a design problem while it is still small and local.

This was already a problem when the only reader was a human. When the reader is an agent it becomes a structural failure. An agent has no nose. It can be given a list of smells, but natural-language descriptions of subjective symptoms, delivered into a context window optimised for agreement, are not a reliable enforcement surface. Smells are a human interface, and they require the experience the developers most reliant on AI have not yet accumulated.

## What is needed is something computable

What is needed is something that produces the same result regardless of who runs it, that cannot be argued away in review, and, most importantly, that exists outside the agent's control surface. A metric the agent computes for itself is subject to the same incentive as every other output it produces: if approval is the goal, the score gets massaged, rounded, or quietly omitted. A metric computed by external tooling and reported back is a fixed referent the agent cannot reshape, the conversational equivalent of running into a wall. This is the architectural inversion of the sycophancy problem. Agreement is cheap; arithmetic is not.

## Quality has two surfaces

What the rest of this chapter describes is not a fifth entropy. It is the surface the other four are read from. The four gaps describe the entropies of the work; quality is the measurable shape of the artifact they leave behind, and slop is its absence.

```text
QUALITY = STRUCTURE + VOCABULARY     the two surfaces a tool can read off the artifact
SLOP    ∝ 1 / QUALITY                its inverse: the visible residue of accumulated entropy
```

Structure is the shape of the work: its dependencies, its boundaries, whether it can still be navigated as one coherent thing. Vocabulary is the language it is written in: its identifiers, whether a concept is named once or five ways. The two are independent; a codebase can be clean on one surface and rotten on the other. Together they are everything an external tool can read off the artifact without trusting the agent's account of its own work. Slop is the colloquial name for what those surfaces look like once they decay: the vague wrongness of the opening section, given a definition at last. The constant of proportionality is unknown; the direction is not. As quality falls, slop rises.

## Slop is inherited, not produced

This carries the paper's thesis into the artifact. Slop is not something the model manufactures under stable conditions. It is the visible residue of entropy that was already in the environment when the artifact was made.

The four entropies rise co-variantly and accumulate in the context the agent works from: a comprehension polluted across turns, a trajectory with no lineage, a structure the agent cannot see, and an agency the agent only inferred. Quality is the surface they fossilise on; slop is the magnitude of the fossil. A degraded context does not announce itself in the diff. It settles into a dependency graph drifting toward the Zone of Pain, a vocabulary fragmenting into five words for one idea, or a compatibility shim guarding a consumer that does not exist.

This is the opening claim made measurable. The model did not get worse; the context it works from got poorer, and slop is how a poorer context surfaces in the work. So slop is not a defect to be reviewed away case by case. It is a gauge of accumulated entropy, and the only way to move the gauge is to lower what it measures.

## The instruments already exist

The research community has been building structural instruments for decades; they have simply never been applied at the cadence and granularity an agentic workflow demands, by tools outside the agent's control surface. A smaller set survives every constraint that matters for agentic use: deterministic computation, established literature, clear thresholds, language-agnostic semantics, and computability from primitives that can run as external tooling against the codebase.

| Metric | Captures | Source |
|---|---|---|
| **Distance from the Main Sequence (D′)** | Architectural rot at the package level | Martin, 1994 |
| **Coupling Between Object Classes (CBO)** | Over-coupling at the class level | Chidamber & Kemerer, 1994 |
| **Cyclomatic / Cognitive Complexity** | Path-coverage burden and reading difficulty at the method level | McCabe, 1976; Campbell, 2018 |
| **Change coupling and hotspot density** | Decay and defect risk over time | Gall et al., 1998; Tornhill, 2015 |
| **Dependency cycles** | Structural invariant violations | Tarjan, 1972 |
| **Dead code and unreferenced symbols** | Decay through accumulation | (folklore; widely tooled) |
| **Connascence taxonomy** | Vocabulary for the relationships above | Page-Jones, 1996; Weirich, 2009 |

These are computable from the same primitives (AST traversal, dependency-graph analysis, git history, cross-reference indexing) the field has had for decades. What was missing is not the measurements; it is the scaffolding to apply them where the agent cannot quietly skip them, by tools that report back in formats it cannot ignore. The smell becomes a measurement, the measurement becomes a contract, and the contract does not rot.

## The surface the field never instrumented

The structural metrics measure the shape code takes once written. They do not measure the language it expresses itself in: identifier choice, naming consistency, vocabulary discipline, classically the province of style guides and seasoned taste, and never seriously operationalised.

That was correct for its era. When writer, reviewer, and maintainer were all human, the lexical surface was a convenience; a messy name cost a moment of friction in the next review and stopped there. When the writer is an agent it becomes diagnostic infrastructure. Every identifier the agent emits is a function of its context window at the moment of emission, so stable, repeated, distinctive lexical anti-patterns across an evolving codebase are a plausible signature of a polluted one. And unlike structure, which must be inferred from graphs, a lexicon's entropy is computable directly from the identifiers it emits. This is the vocabulary surface of `QUALITY = STRUCTURE + VOCABULARY`: not a component the agent must be given, but the residue you read off the output to see which entropy ran high.

---

The field spent forty years building instruments to measure code structure with mathematical rigour, and forty more quietly accumulating instruments for measuring its language. Then it built systems that produce code at industrial scale, and connected the two with a markdown file. A markdown file is a high-entropy channel, and slop is what it leaves in the work. The instruments to detect it predate the tools that ignore them by decades. What was missing was the reason to run them: a participant that writes most of the code and cannot smell its own.
