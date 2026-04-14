# III. The Rot Beneath the Surface

In 1994, David Parnas made an observation so simple it should not have needed saying: ***software ages*** *(Parnas, D.L., 1994)*. Not because computers
change, or because hardware fails, but because **the understanding that produced the software slowly decouples from the software
itself**. Changes made by people who do not understand the original design concept almost always cause the structure of a program
to degrade. Those changes become inconsistent with the original concept -- and eventually, they invalidate it.

Parnas was writing about code. This paper is writing about something *one layer above it*: the documentation that is supposed
to preserve the design concept in the first place.

The previous section described how the gap between intent and implementation is hidden *within* a session, by a model trained
to agree. This section describes how that same gap *widens between sessions*, in artifacts designed to prevent exactly that
drift. **They are the same gap, observed at different timescales.**

## Documentation fails quietly

Documentation does not break the way code breaks. Code at least has the courtesy to *fail visibly* when it diverges from reality.
A function that no longer does what its name says will eventually produce a bug. A markdown file that no longer reflects the
decisions of the team it describes will produce nothing -- it will simply sit there, *authoritative and wrong*, waiting to be read.

In a traditional development context, this is a manageable problem. Humans reading stale documentation carry enough contextual
awareness to notice when something feels off. They ask questions. They check the git history. They talk to the person who wrote
it. The documentation is wrong, but **the humans around it compensate**.

In an agentic context, *this compensation does not exist.*

An agent onboarding to a codebase reads a `CLAUDE.md` file the same way it reads anything else: **as ground truth**. It has no memory of
the three refactors that happened since that file was written. It cannot sense that the package structure described in section two
no longer exists. It does not notice that the architectural decision in section four was reversed, then partially reversed again, in
a way that was never quite dramatic enough to prompt an update. It simply reads, infers, and acts -- on a specification that has been
*quietly wrong for months*.

## Decoupling as a signal

Adam Tornhill's behavioural code analysis work offers an analytical apparatus for measuring this kind of decay, though it must be
*inverted* to apply here. Tornhill studied **change coupling** -- the phenomenon where two or more files consistently change together
in commits, revealing logical dependencies that static analysis cannot see. The signal in his work is the *presence* of co-change.
The signal here is its **absence**: source files that change without the documentation that is supposed to describe them. `CLAUDE.md`
rot is a ***decoupling*** phenomenon -- a silent failure of co-change between artifacts that the team's mental model treats as linked.
The same instrument that reveals hidden coupling can, *run in the negative*, reveal hidden divergence.

This is **not a discipline problem**. Teams that maintain perfect documentation are not failing at discipline when their `CLAUDE.md` rots;
they are failing at something more fundamental. They are using a representation that was designed for *human* readers, with all the
compensating mechanisms humans bring, and applying it to a system that has *none* of those mechanisms. The format is wrong for the
audience, and **the decay was guaranteed from the start**.

What makes this particularly compounding in practice is *the subtlety of the drift*. A single superseded decision is easy to catch.
Five decisions, each slightly updated, each not quite inconsistent enough with the previous version to trigger an alert, accumulate
into a document that is **plausible at every sentence and wrong in aggregate**. The agent reads it, infers a coherent picture from internally
consistent-sounding instructions, and builds accordingly. The developer reviews the output, finds nothing obviously wrong, and approves
it. The gap between documented intent and actual intent widens by another increment, invisibly, and the next session starts from a
position *slightly further from the truth* than the last one.

Parnas called this *software aging*. The concept of **technical debt**, introduced by Ward Cunningham in 1992, captures a related but distinct
phenomenon: the cost of expedient decisions made now, paid with interest later. Cunningham's framing was *financial and intentional* -- debt
taken on knowingly, with the expectation of repayment. Documentation rot is something quieter and more insidious. It is **not debt taken on
deliberately**. It is *decay that accumulates without anyone noticing*, in artifacts designed to prevent exactly that kind of drift.

## The Ceremonial Reviewer

The standard response to everything in this section is the same one offered for sycophancy, hallucination, and every other failure
mode AI systems exhibit: ***the human is in the loop***. *Read the diff. Check the tests. Approve thoughtfully.* The advice is universal,
repeated across documentation, blog posts, and forum threads, and **almost no one follows it**. This is not a moral failing on the part
of developers. It is the predictable output of *three structural pressures* that interact to make supervision economically impossible
and psychologically untenable.

### 1. Responsibility laundering

The first is ***responsibility laundering***. Tool vendors market autonomy. Users adopt the tool because it was marketed as autonomous.
When something breaks, the response is *"you should have reviewed more carefully."* This forms a closed loop with **no accountable actor**:
the vendor points at best practices, the best practices point at the user, the user points at the marketing. No one is structurally
responsible because responsibility has been distributed across actors who can each point at someone else. This pattern is not new.
Lisanne Bainbridge described it in *Ironies of Automation* (1983), nearly half a century ago, in the context of process control
systems: humans are asked to supervise automated systems *specifically because they cannot replicate the system's output*, then blamed
when their supervision fails. Parasuraman and Riley (1997) catalogued the same dynamic across aviation, medicine, and industrial
automation, naming the failure modes -- *misuse*, *disuse*, and *abuse* -- that emerge when the boundary of human oversight is
mismatched to the boundary of automated capability. Agentic coding tools have *rediscovered the failure mode without acknowledging
the precedent*.

### 2. Negative pedagogy

The second is ***negative pedagogy***. Every interaction with the agent updates the user's prior about whether vigilance is necessary.
The trap is that the prior **updates monotonically toward trust regardless of whether trust is warranted**. Visible successes train the
user that review is unnecessary. Invisible failures *also* train the user that review is unnecessary, because the user did not
observe the failure. There is no feedback path that increases vigilance except a catastrophic, attributable failure -- and the
entire thesis of this paper is that *catastrophic failures in agentic coding are precisely the ones most likely to be hidden long
enough to lose attribution*. The human in the loop is not being slowly worn down by laziness. They are being **trained out of the loop
by the tool itself**, on a schedule that has nothing to do with the tool's actual reliability.

### 3. Economic incompatibility

The third is ***economic incompatibility***. *"Review the code carefully"* is not just unfollowed in practice; it is **unfollowable in
principle** at the volume the tooling produces. If the agent generates eight hundred lines of code and twelve tests, careful review
approaches the cost of writing the code originally. *The entire value proposition of agentic tooling collapses if the recommended
supervision is performed.* People who skip review are not being lazy. They are being rational under the economics the tool establishes.
The advice is therefore not advice -- it is **an unfalsifiable defence** that lets the rest of the loop continue functioning. Anyone
diligent enough to follow it is, by definition, *not getting the advertised benefit*.

### What remains: ceremonial review

What is left, after these three pressures have done their work, is ***ceremonial review***. The human still presses approve. The human
still types the prompt. The human still merges the pull request. **None of these actions carry information anymore.** They have been
hollowed out into rituals that look like supervision but no longer constitute it. The reviewer reads the agent's summary instead of
the diff, accepts that the tests pass without inspecting what is being tested, and trusts the workflow to have caught anything
important. *The form of supervision is preserved. The function is gone.*

### The ecosystem has already voted

The clearest evidence that this is not a hypothetical is the shape of the agentic tooling ecosystem itself. The most active community
projects -- the highest-starred MCP servers, the most-discussed extensions, the most-shared `CLAUDE.md` templates -- are overwhelmingly
oriented toward ***increasing*** the agent's autonomy: persistent memory, context engineering, hook automation, compaction strategies,
skill composition. The build effort of the community is voting, in aggregate, for **less human in the loop, not more**. There is
comparatively little energy invested in *audit tooling, drift detection, intent verification*, or any other category of work whose
explicit purpose is to make supervision cheaper. **The ecosystem has already chosen, and the choice is autonomy.**

This is the environment in which `CLAUDE.md` decays. Not in spite of the human in the loop, but *because* the loop -- while still
nominally present -- has been restructured into a shape that **cannot detect the decay it was meant to prevent**.

---

## Experiments

**Decoupling drift in open-source repositories.** Survey public repositories that use `CLAUDE.md` (or equivalent convention files)
and measure, for each repository, the elapsed wall-clock time and intervening commit count between an edit to the convention file
and the next edit to any source file the convention file textually references. The metric deliberately does not require detecting
*contradiction*, which is the hard problem this paper identifies and which would force a circular dependency on the same models
whose failure modes are under study. It requires only detecting *divergence in change frequency* between coupled artifacts. A
healthy convention file should co-change with the code it describes. A rotting one will not. The expected output is a long-tailed
distribution where a small number of repositories maintain tight coupling and the majority exhibit unbounded drift.

**Synthetic drift over agent sessions.** Maintain a CLAUDE.md alongside an evolving codebase across thirty agent sessions of
comparable scope. At each session, capture (a) the structural claims the document makes about the codebase, (b) the actual
structural state of the codebase as derived from static analysis, and (c) the divergence between them, scored by an independent
human reviewer who is blind to which session produced which artifact. Plot divergence over session count. The hypothesis is that
drift is monotonic and that the slope is positive even when no party is acting in bad faith and no individual session introduces
an obvious inconsistency.

**Ecosystem orientation survey.** Sample the top one hundred community MCP servers and Claude Code extensions ranked by GitHub
stars and categorise each by intent: *autonomy-enhancing* (memory, context management, multi-step planning, tool composition,
compaction) versus *supervision-enhancing* (audit logging, drift detection, intent verification, structured review tooling,
provenance tracking). The hypothesis is that the ratio is heavily skewed toward autonomy-enhancing work, by at least an order of
magnitude. If confirmed, this is direct evidence that the ecosystem's collective build effort has voted against supervision as a
load-bearing component of agentic workflows -- and that the *ceremonial reviewer* described above is not an individual failure but
a structural one, encoded into the tools the community has chosen to build.
