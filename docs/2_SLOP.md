# 2. Slop

*Not what the model emits, but what an entropic context leaves behind, and the surface that makes it measurable.*

Slop is the word everyone reaches for and no one defines. The output feels off, the code is plausible and wrong in a way you cannot name, the prose is fluent and empty, and the verdict is always the same: slop. The word is useful precisely because it is vague, and that vagueness is the problem. As an insult it explains nothing. As a diagnosis it has to mean something specific, and the specific thing it means is the subject of this section.

The reflexive account is that slop is what an AI produces when it is not good enough: bad output from a weak model, curable by a better one. That account is wrong, and most of this paper is the argument that it is wrong.

## The opposite of slop

Ask the question the other way. What would the opposite of slop be? Not a smarter model and not a luckier generation, but an artifact whose structure you can navigate and whose vocabulary names each thing once: a clean surface. Slop is the absence of that surface, and the absence has a cause that is not the model.

> Slop is not what a model emits under stable conditions.
> It is the visible residue of a context window that was already in a state of entropy when the artifact was made.

This is the paper's central claim, stated this way so that it can be measured. The model did not get worse; the context it worked from got poorer, and slop is how a poorer context surfaces in the work. A degraded context does not announce itself in the diff. It settles into the artifact as a shape, and that shape is the only part of the failure anyone can actually see.

## The measurement surface

That visibility is what makes slop useful rather than merely pejorative. It is a measurement surface, the one place the hidden disorder of the context becomes legible, and it has two faces, not one.

```text
QUALITY = STRUCTURE + VOCABULARY     the two surfaces a tool can read off the artifact
SLOP    ∝ 1 / QUALITY                its inverse: the visible residue of accumulated entropy
```

Structure is the shape of the work: its dependencies, its boundaries, whether it can still be navigated as one coherent thing. Vocabulary is the language it is written in: its identifiers, whether a concept is named once or five ways. The two are independent; a codebase can be clean on one and rotten on the other. Together they are everything an external tool can read off the artifact without trusting the agent's account of its own work. The constant of proportionality is unknown; the direction is not. As quality falls, slop rises.

The surface has names, and has had them since 1999. A code smell is any characteristic of source code that hints at a deeper problem, a metaphor Beck coined and Fowler popularised: bad code, like something left too long in the refrigerator, announces itself before you can quite say why. That was a workable interface when the only reader was a human with a nose. An agent has none. It can be handed a list of smells, but natural-language descriptions of subjective symptoms, delivered into a context window optimised for agreement, are not an enforcement surface; they are a suggestion it can agree with and ignore.

What is needed is something that returns the same result regardless of who runs it, that cannot be argued away in review, and that lives outside the agent's control surface. A metric the agent computes for itself is subject to the same incentive as everything else it produces: if approval is the goal, the score gets massaged, rounded, or quietly dropped. A metric computed by external tooling and reported back is a fixed referent it cannot reshape, the conversational equivalent of running into a wall. This is the architectural inversion of the sycophancy problem. Agreement is cheap; arithmetic is not.

The instruments already exist. The research community spent decades building structural measures and simply never applied them at the cadence and granularity an agentic workflow demands, by tooling the agent cannot quietly skip. A smaller set survives every constraint that matters: deterministic, grounded in established literature, language-agnostic, and computable from primitives that run as external tooling against the codebase.

| Metric | Captures | Source |
|---|---|---|
| **Distance from the Main Sequence (D′)** | Architectural rot at the package level | Martin, 1994 |
| **Coupling Between Object Classes (CBO)** | Over-coupling at the class level | Chidamber & Kemerer, 1994 |
| **Cyclomatic / Cognitive Complexity** | Path-coverage burden and reading difficulty | McCabe, 1976; Campbell, 2018 |
| **Change coupling and hotspot density** | Decay and defect risk over time | Gall et al., 1998; Tornhill, 2015 |
| **Dependency cycles** | Structural invariant violations | Tarjan, 1972 |
| **Dead code and unreferenced symbols** | Decay through accumulation | (folklore; widely tooled) |
| **Connascence taxonomy** | Vocabulary for the relationships above | Page-Jones, 1996; Weirich, 2009 |

Those measure structure. They do not measure the language the work expresses itself in: identifier choice, naming consistency, vocabulary discipline, classically the province of style guides and seasoned taste and never seriously operationalised. That was correct for its era, when writer, reviewer, and maintainer were all human and a messy name cost a moment of friction in the next review. When the writer is an agent it becomes diagnostic. Every identifier the agent emits is a function of its context window at the moment of emission, so stable, repeated, distinctive lexical anti-patterns across an evolving codebase are a plausible signature of a polluted one, and unlike structure, which must be inferred from graphs, a lexicon's entropy is computable directly from the identifiers it emits. This is the vocabulary half of `QUALITY = STRUCTURE + VOCABULARY`: not a thing the agent is given, but residue read off the output to see which entropy ran high.

## Reverse-engineering the why

This is the move the whole paper turns on. Slop is the what: visible, measurable, external. But it is residue, and residue is residue of something. When the gauge reads high, the question is what raised it, and the answer is not in the artifact. It is in the context the artifact was made from.

The name for the disorder a context accumulates is borrowed from the only fields that study disorder rigorously.

> Entropy: the disorder a system accumulates when no work is done to hold its order in place.

Left alone, an agentic system drifts away from the specific thing you are building and toward the mean of its training distribution. This is a proposed account, not a measured law, and its value is that it is testable. The disorder is not uniform. It is dominated by four sources, each decaying on its own axis, each the entropy of a part of the context the agent works from, and none visible directly. They are the why behind the slop, and the rest of the paper takes them one at a time.

- **Comprehension** is the loop between you and the agent: your unaudited contradictions and imprecision on the way in, the model's reading of them on the way through. By session ten neither party can state the goal you started with.
- **Trajectory** is the time-bearing context, where the work has been and where it must still be able to go. Unsupplied, the agent invents a lineage calibrated to the average project, and quietly closes doors it cannot see it is closing.
- **Expression** is the agent's grip on complex relationships. Its understanding can be confirmed step by step and the structure it builds still incoherent, because nothing gives it a precise, current model of how the work relates to itself.
- **Agency** is the action it is allowed to take and the world that action must stay valid inside. Undeclared, it reads its remit off the conversation: bold where it was narrow, timid where it was broad, sometimes in the wrong operating world entirely.

Each is the subject of its own section. Here they matter only as the four dials the gauge integrates: the slop you measure is their combined wake.

## Capability is a buffer

It is tempting to read all of this as a maturity problem: today's models are not good enough, tomorrow's will be. But a more capable model is dropped into the same loop, handed the same empty lineage, asked to build against the same unaudited context under the same unstated authority. It does not remove the disorder. It does something more dangerous: it absorbs it.

A weak model under rising entropy fails quickly and obviously. The break is local, legible, early, and the system still holds enough order for a human to find the fault and reverse it. A strong model under the same entropy fails late and all at once, holding the disorder together plausibly, long past the point where the order needed to diagnose it still exists. A more capable model does not lower entropy; it raises the amount the system can carry before anyone notices, and what surfaces is not a bug but a collapse. This is the irony of automation in a new register: the more capable the automation, the worse the position of the human left to recover when it finally cannot cope (Bainbridge, 1983). The prediction is falsifiable: under the same impoverished context, a stronger model should fail later and larger than a weaker one, not less often.

## Nothing pushes back

Capability explains why the disorder is not seen. It does not explain why it is not said. A system that merely hid its uncertainty would still surface the gap when asked, if it were built to push back. This one is not. The optimisation that makes the model helpful also makes it agreeable: it takes the reading in front of it as given and satisfies it, rather than flagging the gap that reading conceals. An under-specified instruction draws no clarifying question; a contradicted assumption, no objection; a foreclosed path, no warning. Capability lets the disorder accumulate without showing; sycophancy lets it accumulate without anyone being told. A system that pushed back would let each of the four entropies self-correct while correction was still cheap. Nothing in the loop does, and that is the multiplier every later intervention is measured against.

---

So slop is not a defect to be reviewed away case by case. It is a gauge, and the only way to move a gauge is to change what it measures. The field spent forty years building instruments to measure code structure with mathematical rigour, then built systems that produce code at industrial scale and connected the two with a markdown file, a high-entropy channel, and slop is what that channel leaves behind. The instruments to detect it predate the tools that ignore them by decades. What was missing was never the measurement. It was a reason to run it, and a model of the disorder it measures: the reason is a participant that now writes most of the code and cannot smell its own; the model is the four entropies, and the chapters that follow supply the why this gauge can only point at.
