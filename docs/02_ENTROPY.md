# II. A Taxonomy of Agentic Entropy Sources

*Four places order leaks out of an agentic system, and why a more capable model is not the solution.*

The opening section ended on one claim:

> The agent never acts on your codebase, it acts on a context it cannot audit, and what it cannot audit, it invents.

This section gives that claim its structure. This paper argues that this disorder is not random, but rather, dominated by *at least* 
four specific antagonists.

Each factor shares a part of its name from the only fields that study disorder rigorously: **Entropy**. Entropy is informally defined as:  
>  The disorder a system accumulates when no work is done to hold its order in place.


## The Four Pillars of Entropy

Left alone, an agentic system drifts away from the specific thing you are building, and towards the mean of the underlying model's training 
distribution. This is a proposed account, not a measured law. 

Its value is that it is testable, and the rest of the paper is the test. Four parts of an agentic system drift, they drift on independent axes, 
and each earns the name of the thing that decays.

All four are entropies of the context the agent works from, and none is visible directly. What is visible is the residue they leave in the 
artifact: its quality, the surface the quality section reads.

### 1. Entropy of Comprehension

The loop between you and the agent.

Error enters from both sides:

- Articulation: The user's unaudited contradictions and imprecision.
- Interpretation: The model's understanding of what the user intended to express.

What you are trying to convey decays as it passes through the model into the agent's reading of it, and the decay compounds across every turn. 
By session ten, neither party can state the goal you started with.

### 2. Entropy of Trajectory

The time-bearing context every change is made from.

An agent must be aware of both where the project has been, *and* where it is headed. When that record is not supplied, the agent does not leave 
it blank. It invents one, calibrated to the average project: lineage it cannot see, decisions whose reasons have dissipated, doors it quietly closes.

### 3. Entropy of Expression

The agent's ability to accurately represent complex relationships.

Its understanding can be correct, confirmed step by step, and the structure it builds against still incoherent: files treated as blobs, relationships 
it cannot see, a single scope into which it shovels everything. It can hold the idea; it cannot hold the shape of the idea, because nothing gives it 
a precise, current model of how the work relates to itself.

### 4. Entropy of Authority

The action the agent is allowed to take, and the world that action must stay valid inside.

When neither is declared, the agent reads it off the conversation: a timid *"look at this"* taken as licence to rewrite, a *"do whatever you need"* 
taken as licence to touch production. It acts boldly where its authority was narrow, timidly where it was broad, and sometimes in the wrong operating 
world entirely.

## Capability is a Buffer

It is tempting to read all of this as a maturity problem, today's models are not good enough; tomorrow's will be.

A more capable model is dropped into the same loop, handed the same empty lineage, and asked to build against the same unaudited context under the same unstated authority. It does not remove the disorder. It does something more dangerous: it absorbs it.

A weak model under rising entropy fails quickly and obviously. The break is local, legible, early, and the system still contains enough order for a human to find the fault and reverse it. A strong model under the same entropy fails late and all at once. It holds the disorder together, plausibly, long past the point where the order needed to diagnose it still exists.

A more capable model does not lower entropy, it raises the amount the system can carry before anyone notices. What surfaces is not a bug, it is a collapse. This is the irony of automation in a new register: the more capable the automation, the worse the position of the human left to recover when it finally cannot cope *(Bainbridge, L., 1983)*.

This is the section's sharpest prediction, and it is falsifiable. Under the same impoverished context, a stronger model should fail later and larger than a weaker one, not less often. A model that instead failed less often, or more visibly, would refute the account.

## Nothing pushes back

Capability explains why the disorder is not seen. It does not explain why it is not said. A system that merely hid its uncertainty would still surface the gap when asked, if it were built to push back. This one is not. The optimisation that makes the model helpful also makes it agreeable: it takes the reading in front of it as given and satisfies it, rather than flagging the gap that reading conceals. An under-specified instruction draws no clarifying question; a contradicted assumption, no objection; a foreclosed path, no warning.

Capability lets the disorder accumulate without showing; sycophancy lets it accumulate without anyone being told. A system that pushed back would let each of the four entropies self-correct while correction was still cheap. Nothing in the loop does. This is the multiplier the later sections measure their corrections against.
