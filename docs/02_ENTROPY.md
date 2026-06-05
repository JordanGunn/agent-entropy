# II. The Three Entropies

*Three places order leaks out of an agentic system — and why a more capable model hides the leak instead of sealing it.*

`Section I` ended on one claim: the agent never acts on your codebase, it acts on a context it cannot audit, and *what it cannot audit, it invents*. This section gives that claim its structure. **The invention is not random.** It happens in three specific places, it accumulates in a specific way, and it borrows its name from the only fields that study disorder rigorously.

> **Entropy** is the disorder a system accumulates when no work is done to hold its order in place.
> *An agentic system does no such work by default.* Left alone, every part of it drifts toward the **mean of the model's training distribution** — the average project, the average caution, the average name — *and away from the specific thing you are building.*

This is a *proposed* account, not a measured law. Its value is that it is **testable**, and the rest of the paper is the test. Three parts of an agentic system drift, they drift on independent axes, and each earns the name of the thing that decays.

## The three

- **The Entropy of Interaction** — *the loop between you and the agent.* The goal you are pursuing decays as it passes through the model, and the decay **compounds across every turn**. Error enters from both sides — *your own unaudited contradictions and imprecision on the way in, the model's interpretation on the way through* — and it does not add, **it multiplies**. By session ten, neither party can state the goal you started with.

- **The Entropy of Posture** — *the stance every change is made from.* Where the project has been, how much it matters, where it is going. When that stance is not supplied, the agent does not leave it blank — *it invents one, and calibrates the invention to the average project.* Lineage it cannot see, stakes it miscalibrates, doors it quietly closes.

- **The Entropy of Expression** — *the shape the agent cannot hold.* Its understanding can be correct — confirmed step by step — and the **structure** it builds against still incoherent: files treated as blobs, relationships it cannot see, a single scope into which it shovels everything. It can hold the idea; it cannot hold the *shape* of the idea, because nothing gives it a precise, current model of how the work relates to itself.

Two of these are entropies of the context the agent **receives** (interaction, posture); the third is the entropy of the **structure it builds** (expression). None is visible directly — they live in the loop, the stance, and the agent's model of the work. What *is* visible is the residue they leave in the artifact: its **quality**, the surface the section on measurement reads. The three rise; *quality is how you see that they did.* The point here is not the model — *it is the one property the three share*, the property that makes them dangerous and the property no model release will fix.

## Capability buffers; it does not correct

It is tempting to read all of this as a maturity problem — *today's models are not good enough; tomorrow's will be.* **This is exactly backwards.**

None of the three is a deficit of capability. The Entropy of Interaction is a property of the *loop*; the Entropy of Posture, of the *stance the agent is handed*; the Entropy of Expression, of the *shape it builds against*. A more capable model is dropped into the **same** loop, handed the **same** empty stance, and asked to build against the **same** unaudited context. It does not remove the disorder. *It does something more dangerous — it absorbs it.*

> A more capable model produces a **more plausible** output under the **same** rising disorder.
> *It does not lower the entropy. It raises the amount of entropy the system can carry before anyone notices.*

This is the mechanism behind `Section I`'s second claim, stated precisely. In the section on interaction, capability is what keeps the interpretation gain `γ` above one — *more plausible readings are corrected less often*. The same property operates on all three: the better the model, the longer accumulating disorder stays beneath a surface of **passing tests, reasonable diffs, and confident summaries**. The capability does not seal the leak. *It hides it.*

## Fail-fast versus fail-catastrophic

This buffering is not a benefit deferred. It is a *cost* deferred — **and compounded in the deferral.**

> **A weak model under rising entropy fails quickly and obviously.** The break is local, legible, early — and the system still contains enough order for a human to find the fault and reverse it.
> **A strong model under the same entropy fails late and all at once.** It holds the disorder together, plausibly, *long past the point where the order needed to diagnose it still exists.*

The danger is not that the strong model fails. *Every system fails somewhere.* The danger is **where on the curve it fails**. A failure that surfaces early surfaces into a system a human can still read: the decisions are recent, the structure still legible, the gap between intent and artifact still narrow enough to step across. A failure buffered across fifty sessions surfaces into a system that **no longer contains the order required to reverse-engineer it**. The intent that would explain the code was never recorded; the provenance that would justify it has fused; the structure that would map it has drifted. *The capability that postponed the failure spent the very legibility that remediation requires.*

What surfaces is not a bug. **It is a collapse** — and rolling back the code does not roll back the disorder, because the disorder was *never localised to a commit*. It accumulated across all of them, invisibly, the entire time the system looked healthy. This is the **irony of automation** in a new register: *the more capable the automation, the worse the position of the human left to recover when it finally cannot cope (Bainbridge, L., 1983).*

## What follows

The three sections after this take each entropy in turn — *what it is, how it fails when its slot is empty, who used to carry that slot, and the artifact that has to carry it now that no human does.* The section on **the whole context** unifies them; the section on **measurement** makes each one **computable** — because an entropy that cannot be measured cannot be shown to be *falling*, and the entire argument of this paper is that it can be made to fall.

**The model did not get worse.** *It got better at hiding the three places it was always going to leak.*
