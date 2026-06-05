# III. The Whole Context

*What a context window must hold to keep its trajectory — past, present, and future.*

The unease in `Section I` did not arrive as one complaint. It arrived as several: *the model forgot what I wanted*, *the cleanup made the code worse*, *the names drifted*, *it warned me about a migration that cannot matter yet*. `Section II` named the mechanism that keeps all of them hidden — **a system optimised for agreement does not surface the gap; it fills it**. This section names the thing all of those complaints are complaints *about*.

It is not the code. *It is not the model.* **It is the context the model was working from.**

> **The agent never edits your codebase.**
> *It edits the context it was given, and emits a diff.*
> **The codebase is downstream of a window you never inspect.**

## The window is a pile

In most agentic tools, *context* means whatever happened to fit in the window at the moment of generation: **recent chat**, **the files that were open**, **a memory blob**, **a retrieved snippet**, **a system prompt**, and **a guess about relevance**. This is useful. *It is not an artifact.* It is **a pile** — assembled by recency and convenience, never audited, never frozen, *never the same twice*. The agent reasons over the pile, and the pile is *lossy*, *recency-biased*, and *unaccountable*.

The damage this paper catalogues is not, in the first instance, damage to the code. **It is damage that was already present in the pile before a single line was written.** A function that encodes the wrong intent, a remediation that fuses good and bad decisions, a name that drifts, a caution calibrated to a project that does not exist — *each is the faithful output of a context that was wrong going in*. The model did its job. **The job was specified by a pile.**

The correction is not *more* context. **More text in the window is not more signal** — the literature on long-context degradation already shows that models use the middle of a long window poorly *(Liu et al., 2023)*. The correction is to ask a sharper question: *what would a context window have to hold, at minimum, for an agent to keep the work on trajectory across many turns and many sessions?* **That question has a determinate answer**, and the answer is the *theoretical target* the rest of this paper measures real contexts against.

## The target: goal and posture

A context window maintains trajectory when it preserves two things: **where the work is going**, and **the stance from which every decision along the way should be made**.

```text
CONTEXT = GOAL + POSTURE
POSTURE = PROVENANCE + SCALE + HORIZON

GOAL    = Σ INTENT(1..n)     — corrected intentions, summed at a moment in time
INTENT  = A(INTENT')         — the decayed reading, resolved against current reality
INTENT' = decay(PROMPT)      — the prompt's decayed reading, after entropy in the model
```

The goal definition is the subject of `Section IV`, compressed — and it is not the relationship usually assumed. **The prompt is the raw intent.** What the agent acts on is not the prompt but *its own decayed reading of it*: `INTENT'`, the prompt after **entropy in the model's reasoning space**, attenuated by an unknown magnitude. **The agentic failure of intent is the gap between `PROMPT` and `INTENT'`** — between *what was asked* and *what was interpreted* — and nothing in the loop reveals it, because the decayed reading is the only one the agent can see. A well-formed agentic step does not stop there: it **resolves the decayed reading back against the current state of reality** — `INTENT = A(INTENT')` — recovering against the codebase what entropy discarded from the prompt. The **goal** is then the *running sum of those corrected intentions*, evaluated at whatever moment you ask — `GOAL = Σ INTENT(1..n)`. The failure named in `Section IV` is that **no participant in the loop holds that sum**: the agent sees the latest term, the user remembers a lossy reconstruction of the earlier ones, and *the accumulated goal lives nowhere unless an artifact is built to hold it.*

The goal is the **present** — the live, accumulating target. **Posture** is everything that should condition how the present is pursued:

> *Provenance is the past. Goal is the present. Horizon is the future. Scale is the weight on all three.*

A context window that robustly preserves **goal and posture** is, by construction, one that robustly manages **the past, the present, and the future of the work** — weighted by how much any of it should matter for the project actually in front of the agent. That is the whole claim. **The optimal agentic context is not the fullest window. It is the one that holds trajectory.** Everything the field loosely calls *drift* — intent drift, provenance decay, premature foreclosure, miscalibrated caution — is **a failure to preserve one term of that sum.**

## The four slots

Each slot answers a different question, is filled by a different artifact, and fails in a different way when it is empty.

- **Goal** *(present — `Section IV`)* — *what is being built now.* The accumulated, reconciled target — `GOAL = Σ INTENT`. Its failure mode is the **intent gap**: the prompt decays into the agent's reading of it (`INTENT'`), and nothing surfaces the difference between *asked* and *interpreted*.
- **Provenance** *(past — `Section V`)* — *why the project is the way it is.* The lineage of decisions already made. Its failure mode is **provenance collapse**: the reasoning behind the code is not carried by the code, and remediation welds the deliberate to the accidental.
- **Horizon** *(future — `Section V`)* — *where the project is trying to keep a path open.* Direction, held at low authority. Its failure mode is the **future-hostile decision**: a locally reasonable choice that quietly forecloses a path the project will need.
- **Scale** *(weight — `Section V`)* — *how much caution, ceremony, and stakeholder-protection actually apply.* The multiplier on every other slot. Its failure mode is **miscalibrated stakes**: the agent applies the decision stance of a production system to a project with no users, *or the reverse*.

The decomposition is clean, and the cleanness is the argument. **Three tenses and a weight.** A slot cannot be derived from its neighbours: *a perfectly specified goal does not explain the codebase around it*, *a complete provenance record does not say where the project is going*, and *a clear horizon says nothing about how much risk a change actually carries*. **Each is missing on its own terms. Each must be supplied on its own terms.**

## Three sides: what the agent receives, what it builds, what you measure

The target above is the **receive** side — *the state an ideal window would hold before the agent acts*. But the context is not the whole system. The agent then **builds**, and *how it structures what it builds is a source of disorder no context slot prevents*. And the paper has a **measure** side: *the surfaces you read off the output to detect that any of it went wrong*.

- The **receive side** is prevention. `Sections IV–V` walk the slots: the goal in `Section IV`, and the three components of posture — provenance, scale, and horizon — in `Section V`. Each names the failure mode of an empty slot, the prior art that assumed *a human would carry that slot in their head*, and the **rot-resistant artifact** that has to carry it now that no human is in the loop.
- The **build side** is structure. The *expression gap* names what happens when the agent acts without a precise, abstract, current model of the work's relationships: it duplicates effort it cannot see, collapses boundaries it cannot hold in view, and *organises what it understood into a shape no one would choose*. This is not a context slot — it is the entropy of how the agent gives **form** to its understanding.
- The **measure side** is detection. `Section VI` reads the work's **quality** — its *structure* (the dependency graphs and complexity metrics the field has held for forty years) and its *vocabulary* (the identifiers an agent emits, a fossil of the context that produced them) — the two surfaces of `QUALITY = STRUCTURE + VOCABULARY`. `Section VII` reads the **transcript**: an agent working from an impoverished context spends measurably more of its reasoning budget disambiguating, and that expenditure is computable.
- Spanning both is **the multiplier**. `Section II` established that nothing in the loop pushes back. *An empty slot does not announce itself.* The agent fills it, confidently, in the direction of agreement, and **the filling is indistinguishable from a fact until it has propagated far enough to be expensive**. Sycophancy is why the target has to be an *external artifact* rather than a trusted habit: *without one, the only record of intent is the agent's own agreeable guess.*

These degradations have names. Two live in the context this section models — the **Entropy of Interaction** (`Section IV`, the goal) and the **Entropy of Posture** (`Section V`, the posture slots). The third lies *outside* the context, in how the agent structures what it builds — the **Entropy of Expression** (the expression gap). *Naming them is not decoration.* It is the precondition for measurement, and the three **rise co-variantly**, sharing one visible surface: the work's **quality** (`Section VI`), where structure and vocabulary fossilise what the entropies did. `Section VI` reads that surface; `Section VII` reads the transcript.

## None of this is new

The idea that a system needs *a single coherent stance behind every local decision* is **conceptual integrity**, and Brooks named it the most important consideration in system design half a century ago *(Brooks, F.P., 1975)*. His mechanism was *an architect* — **one mind that carried the whole design and vetoed any local choice that violated it**. That mind held the goal, the history, the direction, and the stakes *at once*, and brought all four to bear on every line.

**The architect is the slot that is now empty.** The agent carries no goal between sessions, no history it did not just read, no direction it was not just told, and no stakes it did not just invent. *The target this section defines is the architect's carry, externalised into an artifact* — because the participant that used to hold conceptual integrity in their head has left the loop, and the participant that replaced it **holds nothing between one prompt and the next**.

---

**The model did not get worse. The context it works from got poorer.** Every chapter that follows takes one source of the disorder: *what it is, how it fails, who used to carry it, and the artifact that has to carry it now.* **Precision at the point the context is assembled is cheaper than precision at the point the damage is found**, and the difference compounds across every commit that inherits the window.

---

## Experiments

**Slot-ablation against a fixed task.** Take a battery of development tasks for which a complete context can be authored by hand — *goal, provenance of the touched files, horizon, and declared scale*. Run each task under five configurations: the full context, and four ablations each removing exactly one slot. Measure output quality against a held-out specification, alongside the transcript metrics of `Section VII` (reasoning-to-execution ratio, token-per-operation, outcome variance across repeats). **The hypothesis is that each ablation degrades a *distinct* and *separable* dimension of the output** — goal-ablation raises outcome variance, provenance-ablation raises fusion and net-additive remediation, scale-ablation shifts the caution profile, horizon-ablation produces locally-clean choices a reviewer flags as future-hostile. A confirmed result establishes that the four slots are **independent channels**, not facets of one underspecification, and justifies preserving them separately rather than concatenating prose.

**Pile versus whole context, held to equal length.** Give two agents the *same token budget* of context for the same task: one a conventional pile (recent chat, open files, a memory blob), the other a context occupying the four slots in equal size. Hold length constant so the comparison isolates **structure**, not **quantity**. Measure quality and the transcript metrics across repeated trials. The hypothesis is that the slot-structured configuration produces *lower outcome variance and lower disambiguation overhead at equal token cost* — evidence that the gain is **organisation of context, not volume of it**, and a direct test of the claim that a window should be *completed*, not merely *filled*.
