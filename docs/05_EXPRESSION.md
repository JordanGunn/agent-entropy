# The Expression Gap

*The relationships an agent cannot see, cannot express, and cannot keep current — and why the cure is a better notation, not a bigger window.*

*This is the third entropy, and the only one that is **build-side**. It is the counterpart to the Entropy of Interaction (`Section IV`) and the Entropy of Posture (`Section V`), but it is not a slot in the `GOAL + POSTURE` context of `Section III`, and it carries no spine numeral of its own: it is the entropy not of what the agent is **given**, but of how it structures what it **builds**.*

The complaints from `Section I` that this section answers are the ones that survive every correction. *You confirmed the agent understood the task.* You watched it explain the plan back, coherently, and the explanation was right. You approved each step. And the thing it built is still **structurally indefensible** — a module that swallowed responsibilities belonging elsewhere, a function written a second time fifty lines from the first, a boundary crossed so quietly no single diff shows it. **None of this is a failure of understanding.** *The understanding was confirmed.* It is a failure to give that understanding a **shape** — and it is the one entropy that fails even when the other two are held.

> **The agent can hold the idea. It cannot hold the *shape* of the idea.**
> *The gap between what it understands and how it organises what it builds is the Entropy of Expression.*

The parallel to `Section IV` is exact. The Entropy of Interaction is the gap between what was *asked* and what was *interpreted*; the Entropy of Expression is the gap between what is *understood* and what is *organised*. Both are **discontinuities between two things that should match**, and in both the agent proceeds confidently across the gap because *nothing in the loop renders it visible*.

## The file is a blob; the relationships are invisible

A traditional agentic system gathers *files*. It pulls a file in as though the file changes **as a whole**, and as though its relationship to the files around it were either obvious or irrelevant. Neither is true. A source file is not an atom — it is a container of **scoped items**: classes, functions, enumerations, *each with its own reasons to change*, its own dependents, its own life. The agent is handed the container and left to infer the contents' relationships from a flat reading. **Pulling the file is not enough; the structure lives in the AST, and the AST is exactly what the interface discards.**

The same defect afflicts prose. A markdown document is gathered as a blob, and *its main message can stay true while a paragraph inside it has gone stale* — stale enough to derail the task that trusts it. The document's components are **rarely evaluated in chunks against one another, against the current state of the code, or against how much has changed around them** since the lines were written. *No widely available system ships a reference-based interface that can address a relationship at the resolution relationships actually live at.* The result is an interface that assigns **equal weight to everything inside a boundary** — every line of the file, every paragraph of the doc — and therefore cannot tell the load-bearing chunk from the dead one.

So the agent does the only thing the interface permits: it **zeroes in on the region the task names**, because that is the only scope it can hold without conflating concerns it cannot see at once. That local focus is reasonable, and it is exactly how the damage starts. Code written for a *later, higher-level* goal is invisible from inside the local task — so the agent **writes it again**, slightly differently, under a different name. Over a long enough session most agents converge on a single scope — one file, one module — and begin **shoving every new item into it**, because that is the only structure they can keep in view. The cost is more than bloat: it is the **loss of a canonical source of truth**. When one concept lives in three places, *no decision can be made cleanly, because no one — agent or human — can say which copy counts.* And the next model inherits the mess as **the example of how this codebase is done**, and extends it faithfully. **The disorder becomes the convention.**

This is clearest **outside code**. Ask an agent to write a book and the early chapters come easily; then the work stalls — not for lack of capability, but because each new chapter demands *re-reading everything before it* to avoid **retconning a fact from chapter two, or destroying a setup the ending depends on**. The agent has no structural view of the narrative, only the linear text, and the cost of holding a long, non-repetitious structure in a linear window grows until forward progress stops. **The problem was never specific to code. It is the management of information that is complex, non-linear, and non-repetitious — where nothing repeats and everything refers.** And it is **getting worse as the tools improve**: larger context windows and disk-backed memory let the agent carry more *without ever organising it*, so the structure can collapse silently, discovered *too late and too gradually to know what the agent still does and does not know*.

## The precision–abstraction tension

There is a reason this is hard, and at first it looks like a wall. To express a multidirectional relationship *precisely* seems to require establishing context no window will reliably hold — which drives toward a **tempting but wrong conclusion**: that the fix is for models to simply *hold more, and hold it better*. **That conclusion is the trap.** It is the same false remedy as the ever-larger prompt, wearing the costume of memory.

The escape is **abstraction**, and the reason it works is that *precision and abstraction are not opposites*. A good abstraction is **selective precision** — exact about the relationships that matter, *silent about everything else*. An entity-relationship diagram is simultaneously abstract and exact; a dependency graph states its edges precisely while discarding every line of implementation behind them. The agent never needed to hold the detail. **It needed the relational skeleton, and the skeleton abstracts compactly enough to survive the window.** The corrective is a better *representation*, **not a bigger *context***.

> The entropy is the cost of an **unresolved tension** between precision and abstraction.
> *Too precise, and the expression overflows the window — the false pull toward more memory.*
> *Too little abstraction, and it collapses back into blobs and prose.*

The failure is **bidirectional** — exactly like the under- and over-specification of intent in `Section IV`. Both entropies fail in two opposite directions, and in both the remedy is never *more*. **It is the right form.**

## The abstraction does not have to be perfect

Here is the part that makes this tractable rather than aspirational. **The abstraction does not have to be perfect — it has to be cheap, familiar, and current.** Any modern model already knows how to read an ERD, an AST, a call graph; the notation sits *in its training corpus a million times over*. It does not need a flawless model of the workspace. It needs **a precise, abstract thing to look at**, and the value of that thing is decided almost entirely by *the accuracy and consistency with which it is kept*.

This is why the obvious half-measures fail — and they fail in **opposite directions**:

> A **one-off mermaid diagram** has the abstraction, and it **rots**. Written once, frozen on disk, it carries no delta against the work that kept moving after it. Ask an agent to design a database and it draws you an ERD; the schema then evolves for a week while the diagram still says what was true on Monday, until the agent falls back to prose and the diagram becomes one more stale document.
> An **`ls` dump** has the currency — *it is always true* — and it has **no precision**: it names the files and says nothing about what relates to what.

The artifact the agent needs is the one neither of these is: **precise, abstract, *and* current** — a representation maintained in delta against the evolving work. *This is the same rot that afflicts a stale prompt and a stale doc, seen a third time.* The mechanism underneath all three entropies is one: **a representation no one re-checks against reality decays silently, whatever it is made of** — a conversational turn, a paragraph, a diagram. The unaudited ledger of `Section IV` was never specific to conversation.

## The convention that makes it worse

The field's instinct, confronted with this, runs in exactly the wrong direction. The dominant convention — visible in the *"use this `CLAUDE.md` for perfect results"* genre and in system-prompt scaffolding alike — is to **constrain the agent**: *never act without authorization, change only what you were told, ask before you explore.* It is rhetoric, and there is reason to doubt it works as advertised. As a quality lever it **does the literal thing** — the agent asks permission more — while plausibly *delivering little of what it promises*; the *constraint cost* experiment below is how to find out.

Its cost is a **double irony**. The constraint is adopted to prevent one unintended consequence — unauthorized action — and it introduces another: *it is hostile to multidirectional relationship-awareness*, **collapsing the one capability the agent might be uniquely good at**, which is spotting a relationship a person would miss. And it is adopted not from analysis but because *reasoning about the full space of things to guard against is hard*, while a blanket constraint is easy and **feels safe**.

*The feeling is not baseless* — and that is what makes it durable. Letting an agent navigate freely on your machine is a **real risk**; constraint genuinely is the safer default. So this is not cargo-cult. It is a **rational choice with an unpriced cost**, and the cost stays invisible for the reason every cost in this paper stays invisible: the agent complies *agreeably* and never reports what the constraint cost it.

The error is **conflating perception with action**. By forbidding unauthorized *doing*, the convention also blinds *seeing*. The two can be separated, and separating them is the whole move:

> **Decouple seeing from doing.** Let the agent's *perception* of relationships run free — bounded, but free — while its *authority to act* stays gated. The autonomy risk lives in the doing; the value lives in the seeing; the convention sacrifices the second to contain the first.

## None of this is new

The insufficiency of prose for relationships is **not a discovery of the agentic era.** It is the reason an entire lineage of notation exists. We drew **Venn diagrams** to express set relationships a sentence mangles; **entity-relationship diagrams with crow's-foot notation** to express cardinality prose can only gesture at; **UML, dependency graphs, state machines, knowledge graphs** — each a purpose-built language for a class of relationship that **paragraphs express badly or not at all**. Natural language was the interface *between people* long before it was the interface to a model — in reports, in specifications, in presentations — and the people using it learned, repeatedly, that **not everything can be said clearly in prose.** That is why they reached for the diagram.

The agent is denied that recourse. It is made to operate through the one interface the field already judged inadequate for relational structure — **linear prose and the file-as-blob** — and is then blamed for the relational failures the interface guarantees. The design principle that resolves it is old too: **use structure where relationships and ambiguity dominate, and prose where judgement and nuance create value.** *Schema where ambiguity creates failure; prose where judgement creates worth.* **Text has value — but not everywhere.** An expression artifact is that principle applied: relationships abstracted into a notation the model can read at a glance, *the detail left in the prose and the code where it belongs.*

## The intervention, and the remedy that is not one

What the slot needs is an artifact that can be **examined and explored cheaply, before the agent acts** — a model of the workspace's relationships that answers the questions the agent currently answers by *invention*: **what exists, what does not, how much of this should be built, and how it is likely to be used.** It must be *precise* (resolved to the scoped item, not the file), *abstract* (a skeleton, not a transcript), and *current* (held in delta against the work, not frozen at the moment it was drawn). **No tool we know of provides this**, and the absence is why the most-offered remedy is the one that cannot work.

Because as the Entropy of Expression rises, the only remedy on offer is **a larger and larger prompt** — the user explaining the structure *for the Nth time*, or pointing the agent at a document that has quietly gone stale about some other part of the project that evolved since. Each escalation is **prose attempting to carry what prose cannot**, and each one **collapses the advertised economy of the tool**: the work the agent was supposed to absorb becomes the user's, re-narrated every session — *or skipped, because the user cannot tell whether this session needs the setup, and the agent will not tell them.* It is the same false remedy as "write better prompts," for the same reason — **the notation that failed cannot be the notation that fixes it.**

---

**The model did not get worse. The shape of the work outgrew the only interface it was given to hold it.** What detects the failure after the fact is the structural and lexical instrumentation of `Section VI`; what would *prevent* it is the artifact this section specifies and that no system, to our knowledge, yet ships. **Precision about relationships, paid before the agent acts, is cheaper than the duplication it prevents** — and the difference compounds across every commit written against a shape no one could see.

---

## Experiments

**Structure before action.** Give an agent the same battery of multi-file tasks under two conditions: *bare* (files supplied on demand) and *modelled* (a maintained, sub-file-resolution map of the relevant relationships — symbols, dependencies, ownership — supplied before it acts). Measure duplication rate, boundary violations, and post-hoc structural metrics (`Section VI`: Distance from the Main Sequence, CBO). The hypothesis is that the modelled condition produces *materially less duplication and tighter boundaries at equal task completion* — evidence that the failure is representational, not a deficit of capability.

**Currency decay.** Supply the same structural model at varying staleness — *current, one session old, five sessions old* — and measure the point at which it begins to **mislead** rather than help: decisions made against relationships that no longer hold. The hypothesis is a sharp degradation with staleness, establishing that the artifact's value is dominated by its delta against reality, not by its initial fidelity — *and that a one-off diagram is worse than none past a threshold.*

**The constraint cost.** Run a matched task with and without the *"act only when authorized / do not explore"* constraint prose, holding everything else fixed, and measure the relational quality of the output — duplication, missed reuse, boundary coherence — alongside the rate of *useful* unsolicited observations the agent surfaces. The hypothesis is that the constraint lowers relational quality and suppresses useful discovery while doing nothing for correctness — a direct test of *decouple seeing from doing*, and of the claim that the convention carries an unpriced cost.
