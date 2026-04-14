# VI. Agentic Smells

The preceding four sections have described *a feeling, a mechanism, a surface, and a gap*. Each describes something real. Each resists easy articulation. And each, when presented to an experienced developer, tends to produce the same response: a slow nod of recognition, followed by a pause, followed by **"I have seen this, but I did not know what to call it."**

This is precisely the condition that **Kent Beck** addressed in the late 1990s when he introduced the concept of a code smell. The term was not a technical specification. It was a **permission structure** -- a name that made it acceptable to say *"something is wrong here"* before you could prove what, exactly, was wrong. A code smell is any characteristic of source code that hints at a deeper problem -- *not a bug, not a technical failure*, but a symptom that suggests the presence of something worth examining more closely. The olfactory metaphor was deliberate. **You smell something before you find it.** *The smell is not the problem. It is the signal.*

The term earned its place in the field **not because it was precise, but because it was useful**. It gave developers *shared language for shared experience*. Mäntylä et al. (2003) formalised this further, proposing a taxonomy that categorised Fowler's original smells into structured groups -- arguing that taxonomy makes smells more understandable and helps recognise the relationships between them. The smell concept has since been extended beyond its original object-oriented context to cover architectural smells, test smells, database smells, and infrastructure smells. Each extension followed the same pattern: a new context, a new class of symptom, the same underlying logic. Something is detectable before it is diagnosable.

This paper proposes one more extension.

---

## Defining Agentic Smells

An ***agentic smell*** is a symptom of quality degradation that emerges from the interaction between *a human operator, an AI agent, and an evolving codebase* -- detectable through proxy signals rather than direct observation, and present **independent of the model used, the tooling chosen, or the experience level of the developer**.

Three properties distinguish agentic smells from classical code smells, and each distinction is important enough to state precisely.

### They are systemic, not local

A classical code smell lives in a specific artifact -- a class, a function, a module. It can be found by reading the code. An agentic smell lives in *the relationship between the developer's intent, the agent's interpretation, and the codebase's evolution over time*. It **cannot be found by reading any single file**. It is a property of the *process*, not the artifact. A codebase can be entirely free of classical smells and *saturated* with agentic ones.

### They are temporal, and therefore measurable only by proxy

Classical smells can be detected statically -- a linter can identify a God Class without running the program. Agentic smells require *temporal observation*. They are not present in the first session; the first session is typically the cleanest point in the project's lifecycle. The smells accumulate as the project grows, as vocabulary drifts, as documentation decouples from reality, as the agent's reasoning surface expands to accommodate an increasingly ambiguous signal. Because the direct signal is unavailable until the damage has compounded, detection has to rely on indirect ones: thinking-token ratios, token-per-operation ratios, context consumption, outcome variance across repeated runs, semantic drift between sessions. (These measurement primitives are defined formally in Section VIII.) The same way a physician infers systemic illness from symptoms rather than direct observation of the underlying cause, agentic smells are diagnosed from the measurable wake they leave in session transcripts and codebase evolution.

### They are model-agnostic and operator-agnostic

This property is *the most counterintuitive and the most important*. The framework predicts that the same agentic smells will emerge whether the developer is a junior using Copilot or a senior using Claude Code, whether the model is the largest available or the smallest, whether the project is greenfield or legacy. The prediction follows from the framework directly: the smell emerges from the *interaction pattern* (underspecified intent → overloaded vocabulary → unconstrained structural drift), not from any participant's specific choices. The pattern is invariant under (a) which model translates intent into code, because the failure mode lives in the translation interface, not the translator's quality, and (b) which developer authors the intent, because the gap between holding an idea and articulating it precisely is a property of the medium, not the speaker. This is why *"the model got worse"* is **almost always the wrong diagnosis**. The variable is not the model. *It is the interaction pattern, which scales with project age, not with model capability.*

---

## A Taxonomy of Agentic Smells

Three categories of *gradient* agentic smell have been identified and described in the preceding sections. They are presented here as a formal taxonomy for reference. A fourth smell, categorically distinct in dynamics, is described in the subsection that follows the taxonomy.

**Structural Smells** *(see Section IV)*

Structural agentic smells manifest in the measurable architectural properties of a codebase as it evolves under agent assistance. They are detectable using the metrics described in Section IV: Distance from the Main Sequence, Coupling Between Object Classes, Cyclomatic and Cognitive Complexity, change-coupling density, and Connascence type. A codebase exhibiting structural smells will show characteristic clustering in the Zone of Pain or Zone of Uselessness on the Abstractness/Instability plane, rising coupling scores as classes accumulate responsibilities across sessions, and Cognitive Complexity scores that increase faster than the functional scope of the codebase would justify.

The underlying cause is the absence of computable quality contracts. Without metric thresholds enforced at the point of commit, each agent session is free to make locally reasonable decisions that are globally destructive. No individual session produces the smell. The smell is the aggregate.

**Semantic Smells** *(see Section V)*

Semantic agentic smells manifest in the vocabulary of the codebase -- in the overloading of terms across module boundaries, the collapse of distinct architectural concepts into shared namespaces, and the proliferation of function names that encode implementation details rather than domain concepts. The `read_pdf_from_azure()` cascade described in Section V is a canonical example. Each name was reasonable in isolation. Together they are a semantic catastrophe that expands the agent's disambiguation burden with every new session.

The underlying cause is the absence of a controlled vocabulary. Without an authoritative, scoped definition of the primitive terms used in a codebase, the agent defaults to whatever naming convention felt most natural at the time of each individual session. Natural language is optimised for convenience. Convenience at the term level is debt at the architecture level.

**Intent Smells** *(see Sections II and III)*

Intent agentic smells manifest in two related forms. At the *session* level, they appear as elevated thinking-token ratio (TTR), high token-per-operation ratio, sustained self-chatter before the first executable action, and high outcome variance across repeated runs of the same task -- session-transcript signals defined formally in Section VIII. At the *project* level, they appear as the documentation rot described in Section III: convention files that progressively decouple from the code they describe, encoding intent that no longer matches reality. The two forms share a common cause but operate on different timescales: session-level intent smells are the *acute* manifestation, documentation rot is the *chronic* one. They are the most ephemeral category to detect at the moment of creation -- present first in the session transcript, eventually reified in the codebase as decoupled artifacts -- and the earliest warning signal available. A project exhibiting intent smells has not yet accumulated structural or semantic smells; the intent smell is detectable at the session level before the damage reaches the architectural level.

The underlying cause is underspecified intent entering the implementation pipeline without interception. The agent, optimised for agreement rather than interrogation, encodes whatever interpretation felt most plausible and produces output that satisfies the immediate request while embedding assumptions that compound across future sessions.

---

## Provenance Collapse: A Categorically Different Smell

The three smells described above accumulate. Each individual instance is small, each compounds gradually with the others, and the harm becomes visible only over time. A fourth agentic smell exists that does not behave this way. It can emerge from a single remediation attempt on a codebase that was otherwise clean. It does not require the others to precede it. And unlike structural, semantic, and intent smells -- which degrade output quality gradually -- it degrades the *legibility of past decisions* simultaneously, often irreversibly.

It deserves a name. The one this paper uses is ***provenance collapse***, with one important disambiguation. *Provenance* in this context refers to the lineage of architectural decisions -- not the supply-chain, build-attestation, or data-lineage senses of the term as used in security tooling and scientific computing. What is at stake is the chain of intent and assumption that produced the current code state, and what is lost is the ability to reconstruct that chain after the fact.

The mechanism is precise. Every significant decision in a codebase was made under a set of assumptions that existed at the moment it was made. The developer who wrote `read_pdf()` knew why it was named that way, what it was expected to do, what it was explicitly *not* expected to do, and what would need to change if the requirements shifted. That knowledge was alive at the time of the decision. It is not preserved in the code. It is rarely preserved in the git commit message. It dissipates.

When an agent is asked to remediate an existing codebase -- to correct an architectural decision, refactor a module, or untangle a dependency -- it encounters artifacts whose provenance is invisible. It cannot distinguish a deliberate architectural choice from a workaround. It cannot tell whether a pattern was intentional or expedient. It cannot determine which assumptions were load-bearing at the time a decision was made. Faced with this opacity, it does the only safe thing available to it: it tries to preserve what exists while incorporating what is new.

This is where the trap closes.

**Fusion is the conservative response to opacity.** The agent does not know what is safe to remove, so it *removes nothing and adds new code alongside*. Each fusion increases surface area without reducing legacy. Old assumptions become structurally embedded in the new architecture; new patterns become entangled with old anti-patterns. The output satisfies the immediate request -- it compiles, it passes tests, it does what was asked -- and simultaneously destroys the legibility of every decision that preceded it. Bad decisions and good decisions are welded together into something that works but cannot be reasoned about. Over multiple remediation passes, the codebase becomes a sediment of every previous attempt, with no clear horizon between them.

The choice to fuse rather than replace is the same sycophancy mechanism described in the previous section, applied to the *codebase* as the source of agreement. Removing existing code is a stronger form of disagreement with the artifact than adding code alongside it. Removal asserts that something was wrong; addition asserts only that something else is needed. The agent, optimised for agreement, takes the lower-disagreement option. Provenance collapse is what happens when that optimisation runs across many remediation passes.

In information-theoretic terms, provenance collapse is not categorically separate from agentic entropy -- it is the *phase change* within it. The other three smells describe gradual accumulation of noise on the channel between developer intent and encoded artifact. Provenance collapse is the moment when gradual decay becomes irreversible loss. The signal does not just degrade; the record of what the signal was supposed to be is destroyed.

At this point the developer faces a choice with no good options: wipe the affected area and rebuild from scratch, accepting the loss of everything that was embedded in the fused state; or attempt to untangle the mess incrementally, describing each step carefully enough to preserve decision lineage -- a task that rapidly exceeds the feasible scope of any prompt sequence as the number of affected files grows. Either path requires a level of documentation of original intent that, in most cases, was never produced.

This is provenance collapse: the irreversible loss of decision lineage from a codebase, producing a state in which neither the developer nor the agent can reliably determine what was intentional, what was accidental, and what was the artifact of a remediation that fused both. **It is the smell that defines the point of no return.**

**Detection signals**  
Provenance collapse does not produce the gradual degradation curve of the other three smells; it produces a discontinuity. Three measurable signals tend to accompany it: rapid growth in cyclomatic and cognitive complexity following a remediation session, where the metrics climb sharply against a previously stable baseline; high outcome variance on tasks that previously produced consistent results; and elevated thinking-token ratio with no corresponding improvement in output quality -- the agent reasons extensively but does not converge. A fourth, qualitative signal is harder to formalise but consistently present: developers describing the affected area report *not knowing where to start* when prompted to explain it to an agent, and their prompts grow noticeably longer with each subsequent attempt at the same task. The qualitative version is not falsifiable on its own; the prompt-length proxy is.

**Remediation**  
Provenance collapse is the hardest of the four agentic smells to remediate, and proposed approaches are exploratory. Any viable approach must address two failures simultaneously: the *irreversibility* (the lost lineage cannot be reconstructed from current code state alone) and the *discipline gap* (existing documentation forms have failed to preserve the lineage in the first place, as Section III established for `CLAUDE.md` and as Section IX establishes for ADRs and their successors). The solution space is open, several directions exist in the broader software engineering literature, and none is yet canonical. The problem is named here. Its remediation is treated as unsolved and is enumerated in Section IX with the other open problems the framework does not yet close.

---

## The Temporal Factor: Why Agentic Smells Are Categorically More Dangerous

Classical code smells spread at **human speed**. A developer copies a bad pattern from one module to another. The spread is limited by human bandwidth -- how much code a developer can write in a session, how often they revisit unfamiliar areas, how much attention they pay to existing conventions. Even in a team of ten, a bad pattern takes time to propagate. *Time creates opportunity for detection.*

Agentic smells do not spread at human speed. **They spread at agent speed.** And that difference in rate is *not incremental* -- it is **structural**.

Consider what happens when an agent onboards to a codebase. It reads existing files to establish context. It identifies the conventions of the codebase. It infers the style. It extrapolates from what it sees. This is, under normal circumstances, a feature: the agent produces code that is consistent with the surrounding codebase. Under agentic entropy conditions, this becomes the mechanism of catastrophic propagation.

**The moment an agent reads a file containing a smell as context, that smell is promoted from a local violation to an established convention.** The agent will reproduce the pattern -- consistently, at scale, across every file it touches in that session and every session that follows. The smell is no longer a smell. It is the standard. This is the core mechanism that distinguishes agentic spread from classical spread, and it has no counterpart in the human-only world: a single instance of a bad pattern, observed once, becomes self-replicating the moment it enters an agent's context.

Three architectural properties of large language models compound this effect.

**The first is positional bias.** Liu et al. (2024) demonstrated that language model performance follows a U-shaped curve relative to context position -- models attend best to information at the very *beginning* and at the very *end* of their input, and performance degrades significantly when relevant information is placed in the middle of long contexts *(Liu, N.F. et al., 2024)*. In a long agent session, the original guidance (system prompts, lexicons, established conventions) initially occupies the high-attention primacy positions, and the most recent file reads occupy the high-attention recency positions. As the session grows, the original guidance is *displaced* -- it slides into the middle, where attention is weakest -- while the most recent reads, including any newly observed bad patterns, take its place at the end of the U. The bad pattern wins not because recency dominates abstractly, but because it physically displaces the conventions that would otherwise have constrained it. A pattern introduced in the most recent session is therefore more likely to be reproduced than one established at the start of the conversation, even if the established pattern was authoritative when the session began.

**The second is volume acceleration.** Industry vendor reports claim that developers using AI coding assistants generate three to five times more lines of code per session and substantially more pull requests per developer than developers working without AI assistance. These figures should be treated with caution: they originate from organisations with direct commercial interest in the conclusions, are not peer-reviewed, and measure raw output rather than useful work. The most rigorous independent study in this space is the METR randomised controlled trial (Becker et al., 2025), which recruited experienced open-source developers to complete real tasks in their own repositories with and without AI assistance. The METR result is striking: experienced developers were **19% slower** with AI assistance than without it. They had *predicted* before the experiment that AI would speed them up by roughly 24%, and *after* completing the tasks they still believed they had been around 20% faster than they actually were *(Becker, J. et al., 2025)*. Vendor metrics measure volume; METR measured useful work; the gap between the two is the agentic-entropy contribution to perceived productivity. A pattern that would have taken a human developer three weeks to propagate through a codebase can be propagated by an agent in a single session -- and the human supervising the session may have no reliable internal signal that anything has gone wrong, because the experience of increased productivity is itself a symptom of the pattern being measured.

**The third is detection lag.** Code review operates at human speed regardless of how fast code is produced. The agent has already propagated the smell across forty files before the first review catches it in one. And critically, the reviewer is not looking for agentic smells -- they do not yet have the vocabulary to name what they are seeing. They are looking for bugs. The smell is not a bug. The smell passes review.

The compounding effect of these three factors -- positional bias displacing original constraints, volume acceleration spreading patterns across the codebase in hours rather than weeks, and detection lag ensuring they are entrenched before anyone notices -- is what makes agentic smells categorically different in danger profile from classical ones. A classical God Class is a problem in one place. An agentic semantic smell, once latched onto by an agent as a codebase convention, is a problem everywhere, simultaneously.

And the agent will defend the pattern if asked about it, because the pattern is now consistent with the codebase it has been given as context. **This is the sycophancy mechanism from Section II generalised**: the agent agrees with what is in front of it, and the codebase has become what is in front of it. The same instinct that produces *"you're absolutely right"* in response to a flawed user proposal produces *"this is the convention of this codebase"* in response to a flawed pattern it just observed itself reproducing five files ago. The source of the agreement has shifted from the user to the artifact, but the mechanism is the same.

---

## Agentic Entropy

The four smell categories are not independent. They interact, reinforce each other, and share a common trajectory. A project that begins with intent smells -- underspecified prompts, unresolved ambiguity -- will develop semantic smells as the vocabulary is contaminated by the agent's unconstrained naming decisions. Semantic smells produce structural smells as architectural boundaries collapse along the lines of the vocabulary's failures. Structural smells increase the agent's reasoning burden, which increases the rate of intent smells in subsequent sessions. The temporal factor described above ensures that each cycle of this progression happens faster than the last.

The system tends toward disorder. Without active constraint, the signal fidelity between what the developer means and what the codebase encodes degrades over time. This trajectory has a name borrowed -- by analogy -- from the information theory that informs the measurement methodology in Section VIII.

The borrowing is intentionally loose. Shannon's formal entropy is a precise mathematical quantity defined over probability distributions, and Shannon himself was explicit that his framework has no relationship to meaning. What is borrowed here is not the equation but the intuition: a system in which signal fidelity progressively degrades as ambiguity accumulates across multiple coupling layers simultaneously. Each session that begins with underspecified intent, ends with uncontrolled naming, and commits unchecked architecture adds noise to a channel that previously carried developer intent into encoded artifact with reasonable fidelity. Each increment makes the next session harder. The reasoning surface expands. The disambiguation burden increases. The output degrades. The treatment of this as a measurable quantity, with formal definitions and grounded thresholds, is reserved for Section VIII; the term is introduced here as the umbrella concept under which the three smell categories cohere.

This is ***agentic entropy***: the *progressive degradation of signal fidelity* between developer intent and encoded artifact, driven by the compounding interaction of **intent smells, semantic smells, and structural smells**, accelerated by the volume and propagation speed of agent-assisted development, in the absence of the constraints proposed in this paper.

Agentic entropy is not visible in any single session. It is not visible in any single file. It is visible in the aggregate -- in the trend of thinking-token ratio over successive sessions, in the growth of the disambiguation surface, in the rate at which the developer begins to feel that the model is getting worse. The signal is getting noisier. A noisier signal, fed into a system optimised to produce confident output regardless of input quality and biased toward the most recent context it has read, produces exactly the experience developers describe when they say the model has degraded.

---

## Why the Taxonomy Matters

**Naming is not academic housekeeping.** It is the *precondition for shared accountability*.

Before Beck named code smells, developers had the experience of recognising something wrong in code without being able to defend the recognition in a code review. **The smell gave them standing.** *"This is a God Class"* is a defensible statement. *"This feels wrong"* is not. The taxonomy gave the community a *shared surface* on which to build tooling, research, and practice.

Agentic smells are in the same position today that code smells were in 1999. The experience is widespread. Stack Overflow's 2024 Developer Survey reported that the share of developers expressing high trust in the accuracy of AI coding tools has fallen substantially against rising adoption *(Stack Overflow Developer Survey, 2024)*. The data point is compatible with several explanations -- novelty wearing off, users developing better calibration, early adopters being structurally over-optimistic, or genuine quality decay driven by mechanisms like the ones described in this paper -- and the agentic-entropy framework is one candidate among several. What is striking is not that any single explanation dominates the data, but that the experience of *something is wrong* is now widespread enough to register in industry surveys at all. Developers know something is wrong. They are blaming the model because the model is the most visible variable. The taxonomy proposed here offers an alternative: a set of named, measurable, model-agnostic phenomena that account for the degradation without requiring the model to have changed.

That is what a good taxonomy does. *It does not create the problem.* **It makes the problem nameable, and therefore tractable.**

---

## Experiments

**Pattern propagation rate study.** Introduce a single deliberate semantic smell into a codebase at session zero. Run ten subsequent agent sessions on related tasks without explicitly referencing the smell. Count how many sessions reproduce the pattern unprompted, and measure the number of files affected per session. Run the same experiment with a controlled vocabulary and lexicon-aware naming enforcement in place, and compare propagation rates. The directional hypothesis is that the unconstrained codebase exhibits *exponential* propagation -- each subsequent session reproduces the pattern more aggressively as it becomes increasingly represented in the agent's context -- while the lexicon-constrained codebase exhibits sub-linear propagation or none at all. A confirmed result establishes that the convention-promotion mechanism is real and that the Section V interventions are sufficient to suppress it.

**Volume versus value measurement.** Measure raw lines of code output per hour for an agent completing a representative task versus a developer of equivalent experience completing the same task without AI assistance. Independently, measure the *useful* output, defined as code that survives review, is not subsequently reverted, and contributes to closing the original issue without introducing new ones. The hypothesis, consistent with the METR finding, is that the volume multiplier is large and the useful-output multiplier is much smaller -- possibly negative for experienced developers on complex tasks. The gap between the two is the magnitude of the agentic-entropy contribution to perceived productivity.

**Taxonomy validation study.** Present the three agentic smell categories to experienced developers without prior explanation and ask them to identify examples from their own recent work. Measure recognition rate and specificity. A high recognition rate with specific, unprompted examples supports the validity of the taxonomy. Pair this with a *nomenclature study*: measure whether having the term *agentic smell* changes how developers describe and escalate quality problems in agent-assisted codebases relative to a control group without the term. The hypothesis is that named phenomena are escalated faster and more specifically than unnamed ones, on the same mechanism that made *code smell* valuable in 1999.
