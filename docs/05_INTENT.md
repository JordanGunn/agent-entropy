# V. The Intent Gap

Spend enough time in forums where developers discuss AI coding tools and a pattern emerges. *The model was incredible
at first. Lately, it seems slower, less precise, more prone to making strange decisions. The quality has clearly degraded.
Someone, somewhere, must have changed something.*

This complaint is sincere. It is also, in most cases, **a description of the wrong variable**.

Some part of the perceived degradation is real and attributable to model updates, throttling, or routing changes. Some part of
it is recency bias. But a significant share -- *larger than the discourse acknowledges* -- is something else entirely.

> **Nothing changed in the model.**
> *Everything changed around it.*

## The PDF that ate the codebase

Consider how a project typically begins. A developer has a clear, narrow objective. They need to ingest data from PDF files.
The intent is clean, the vocabulary is not yet contaminated, and **the reasoning surface the agent must navigate is small**.
They ask the agent to create something that *reads* a PDF. It works. The model seems sharp.

Then the project grows. The data will also come from object storage, so the agent is asked to create something that *reads*
from there too. Then the data needs to be *read* into a processing engine. Then another format appears, DOCX files, so a
parallel function is needed to *read* those too. At no point does anyone stop to ask what the word "read" actually means,
because at each individual step it seems obvious. *Read* from disk. *Read* from Azure. *Read* into Dask. *Read* DOCX.

By the time the project reaches any meaningful scale, the codebase contains something like the following: `read_pdf()`,
`read_pdf_from_azure()`, `read_disk_pdf()`, `read_from_uri()`, `read_docx()`, `modify_and_read()`. Each function was named
reasonably at the time it was created. **Together they are a semantic catastrophe.**

The agent, asked to do anything involving data ingestion, must now reason across all of them. It must infer which one applies,
whether they overlap, whether they are interchangeable, whether `read_pdf_from_azure()` and `read_from_uri()` are the same thing
with different names or different things with confusingly similar ones. *Every token spent resolving this ambiguity is a token not
spent on the actual task.* The output gets worse. **The developer experiences this as the model degrading.**

The pattern is not unique to ingestion. The same collapse happens to `process()` in data pipelines, to `handle()` in web frameworks,
to `manage()` in infrastructure code, to `update()` in nearly anything stateful. *Pick any verb general enough to be reached for
without thought*, and a sufficiently large codebase will eventually have eight functions that share its prefix and disagree about
what it means. The PDF example is illustrative; **the underlying mechanism is universal**.

## Vocabulary collapses architecture

What has actually happened is that **a single overloaded term has collapsed several distinct architectural concepts into the same
namespace**. The act of fetching bytes from object storage is not the same as deserialising a PDF into structured data, which is
not the same as materialising records into a processing engine. These are separate concerns with separate failure modes, separate
dependencies, and separate reasons to change. The word "read" does not distinguish between them. Used consistently enough, it
actively prevents the distinction from being made. Once everything is `read`, there is no linguistic surface on which to hang
the separation.

**This is not a new observation in software design.** Fred Brooks made a version of it in *No Silver Bullet* (1986), arguing that
*conceptual integrity* -- the property of a system in which a small number of consistent ideas govern a large number of decisions
-- is the single most important consideration in software architecture, and that it is achieved primarily through controlling who
gets to introduce new vocabulary into the design *(Brooks, F.P., 1986)*. Lakoff and Johnson, working in cognitive linguistics,
demonstrated in *Metaphors We Live By* (1980) that the categories available to a speaker structure what distinctions that speaker
can make: when a single word covers a region of conceptual space, the boundaries within that region become invisible to anyone
reasoning in that vocabulary *(Lakoff, G. & Johnson, M., 1980)*. Neither author was writing about agents. Both were describing the
same mechanism: a vocabulary that conflates loading, parsing, fetching, ingesting, and reading does not merely fail to describe
architectural boundaries -- it forecloses them. The architecture cannot emerge from the language because the language has already
decided there is nothing to distinguish.

Eric Evans named the operational version of this problem in *Domain-Driven Design* (2003). His concept of a *ubiquitous language*
-- a shared, precise vocabulary maintained consistently within a bounded context -- was a *social* solution: get the humans on a
team to agree on what words mean, and the model of the domain becomes easier to reason about. It was a good idea then, and it
worked, because humans carry context. They remember the conversation in which `load` was distinguished from `fetch`, even when
the distinction was never written down. The vocabulary survived in the heads of the team that built it *(Evans, E., 2003)*.

In an agentic context, **the social solution stops working**. The agent has *no team memory*. It cannot sense when a term has drifted.
It cannot ask a colleague what `read_from_uri()` was supposed to do when it was first written. It can only reason from what is in
front of it, and if what is in front of it is ambiguous, it will produce ambiguous output -- *confidently, fluently, and at scale*.
The artifact Evans proposed remains the right artifact. What changes is the ***enforcement layer***: it can no longer be social,
because **the participant most reliant on it is no longer social**.

Bertrand Meyer formalised *Design by Contract* in 1992. Meyer's argument was that software components should carry explicit,
verifiable specifications of their behaviour -- preconditions, postconditions, and invariants -- rather than relying on
documentation that could drift from the implementation. The contract is enforced at the function boundary, in code, and it cannot
be ignored without being noticed. A controlled vocabulary is an extension of this principle into a layer Meyer did not formalise:
not the function's *behaviour*, but the function's *name*. Meyer constrained what a function does. A controlled vocabulary
constrains what its name is allowed to mean. Both are precommitments against drift, and the second is upstream of the first
because a function whose name has drifted will be misused long before its body is incorrect *(Meyer, B., 1992)*.

## Why Vocabulary Rots Slower Than Prose

A **controlled vocabulary** -- a short, maintained list of primitive terms with unambiguous, scoped definitions -- is *the most
rot-resistant artifact a development team can produce*. Not because vocabulary maintenance demands more discipline than `CLAUDE.md`
maintenance, but because vocabulary, structurally, has properties that resist the failure modes documented in Section III.

It is ***small***: a single page, read in one pass, with no room for paragraphs of guidance to drift past unnoticed. It is
***constrained***: each entry is short and definitional rather than narrative, which makes inconsistencies between entries
immediately visible to a human reader and trivially detectable by tooling. And it is ***enforceable***: a function named
`read_pdf_from_azure` in a codebase that defines `read` as "deserialise into in-memory representation" is *mechanically wrong* in
a way that a function violating a paragraph of architectural guidance is not. **The same instruments that catch typos can catch
semantic violations**, provided the vocabulary is precise enough to define what a violation looks like.

This is the property that lets vocabulary survive what prose cannot. *Prose rots because nothing breaks when it is wrong.* A
vocabulary entry that has drifted from the codebase produces **visible mismatches at every site of use**. The decay is observable,
which means it can be detected, which means it can be prevented from compounding.

## Intervention One: Domain-Scoped Lexicons

The first intervention is a **domain-scoped lexicon**: a short, authoritative file -- not a `CLAUDE.md` of architectural guidance,
not a wiki, not a paragraph in a README -- that answers a single question. *What does `load` mean in this codebase, as distinct
from `fetch`, `parse`, `read`, `ingest`, and `download`?* The file contains primitive terms only. It commits to a single canonical
verb for each architectural concept and forbids the others. It is the controlled vocabulary made explicit and enforceable.

The lexicon does not eliminate ambiguity. It localises it. Disagreements about what `load` should mean still happen, but they
happen *once*, at the moment a term is added or revised, instead of being relitigated implicitly every time a function is named.
The cost of precision is paid in the lexicon, not amortised across every subsequent reading session.

Lexicon maintenance is a reasonable concern given the discipline failures documented in Section III. The answer is that lexicons
fail differently from architectural prose. A `CLAUDE.md` rots silently because no individual paragraph is obviously wrong; a
lexicon rots loudly, because any divergence between a defined term and its use in code is a single-line, mechanically detectable
violation. Maintenance is not strictly required to catch up; it is required only to *resolve* violations when they are surfaced.
The work of detection moves from the developer to the tooling, which is exactly the inversion the previous sections argued for.

## Intervention Two: Structural Separation of Verifier and Implementer

The second intervention targets a different failure: the moment before code is written at all. Users arrive at agentic coding
sessions with intent that *sounds specific* but is *structurally underspecified* -- not because they are careless, but because the
gap between having an idea and being able to articulate it precisely is exactly the gap the agent is supposed to help close. As
established in Section II, the agent is optimised to agree rather than interrogate. The result is that underspecified intent gets
encoded directly into the codebase, where it compounds with every subsequent session.

The simplest viable response is **structural separation**: rather than a single agent that both interrogates and implements, a
two-agent layer in which an ***intent verifier*** and an ***implementation agent*** are explicitly distinct roles. The intent verifier
reads the user's prompt before any implementation begins. *Its job is not to be helpful.* **Its job is to refuse forward progress
until ambiguity has been resolved.** The implementation agent never receives the raw prompt; it receives only the verified,
disambiguated intent that has passed the verifier's gate.

The architectural separation matters more than it may appear. Asking the same agent to *"be skeptical"* and then to *"be helpful"*
in the same session is asking it to apply **incompatible objectives in sequence** -- and the helpful objective is the one its training
rewards. Two agents with two roles avoid this collision: the intent verifier is judged on whether it *surfaces ambiguity*, the
implementation agent is judged on whether it *executes a clear intent correctly*, and neither is asked to do both at once.

The verifier's failure mode is worth naming explicitly. If the verifier and the implementer share the same underlying model,
training, and prompt template, they share the same bias toward agreement. The structural separation is necessary but not
sufficient. Mitigating the residual bias requires one or more of: (a) prompting the verifier *adversarially* -- not "check for
ambiguity" but "find the interpretation of this prompt that would produce the worst possible output, and surface it before the
user commits"; (b) augmenting the verifier with mechanical checks -- detecting overloaded verbs, undefined nouns, references to
terms not in the lexicon -- so that verification does not depend on the model's willingness to disagree; (c) using a different
model entirely for the verifier role, ideally one not trained on the same preference data as the implementer. The strongest
configuration combines all three: a different model, prompted adversarially, with mechanical checks against the lexicon as a
backstop. This is the structural enforcement layer that Evans's social ubiquitous-language solution can no longer provide on its
own.

The two interventions reinforce each other. The lexicon gives the verifier something concrete to check against. The verifier
prevents the lexicon from being silently violated by the next session's prompt. Neither is sufficient alone. Together they keep
the reasoning surface small enough to be reasoned over.

## A Note on Measurability

Whether vocabulary quality is itself measurable is a separate question and one this paper does not depend on, but it is worth
flagging. The same primitives that compute the structural metrics in Section IV -- AST traversal, symbol indexing, token analysis
-- could in principle compute properties of a codebase's vocabulary: the number of distinct verb stems used as symbol prefixes,
the number of disjoint contexts in which a single token appears, the deviation of a codebase's symbol vocabulary from its
declared lexicon. None of these metrics exists in the literature in the form needed here, and none is required for the
interventions above to function. They are mentioned only to note that the same measurement framework that constrains architecture
can in principle be turned on the language used to describe it, if the field decides that is a problem worth solving.

---

**The reasoning surface starts small.** Intent is at its clearest before the project expands, before the vocabulary is contaminated,
before `read` has been used to mean six different things across forty files. *The cost of precision is lowest at the beginning
and highest at the end.*

**The model did not get worse. The language it was asked to reason over got harder.** The interventions in this section are not
about constraining the model. They are about keeping *the vocabulary it reasons in worth reasoning about*. Precision at the point
of definition is cheaper than precision at the point of use, and the difference compounds across every session that follows.

---

## Experiments

**Vocabulary impact on structural divergence.** Run the same set of feature requests against two equivalent codebases, one
developed under a maintained domain-scoped lexicon with lexicon-aware naming enforcement, and one developed without. Both
codebases begin from the same starting state and receive the same prompts. Measure the resulting divergence using the structural
metrics from Section IV: D' at the package level, CBO at the class level, and change-coupling density across symbols sharing a
common verb prefix. The directional hypothesis is that the lexicon-free codebase will accumulate vocabulary collisions (multiple
distinct definitions per overloaded term) at a faster rate than the lexicon-controlled codebase, and that this accumulation
correlates with degraded structural metrics. A null result would suggest that the vocabulary-collapse mechanism is overstated;
a confirmed result establishes that semantic discipline propagates into structural quality and is itself measurable.

**Two-agent verification versus single-agent baseline.** Run a sample of real development prompts -- sourced from open-source
issue trackers, where the prompt is the issue text and the eventual clarified intent is recoverable from subsequent comments and
the merged solution -- through two configurations. Configuration A: a single agent receives the prompt and implements directly.
Configuration B: an intent verifier processes the prompt first, surfaces ambiguity, requests clarification from a simulated user
(or from the issue thread), and only forwards a disambiguated intent to a separate implementation agent. Have human reviewers
score the resulting implementations against the *eventual* clarified intent expressed in the closed issue. The hypothesis is
that Configuration B produces implementations that more closely match the eventual intent, with the largest gains on prompts
that subsequent comments reveal were ambiguous from the start.

**Sycophancy resistance of the intent verifier.** Construct a battery of prompts in which the user has explicitly stated a
preferred but underspecified interpretation. Run the verifier against each prompt under three configurations: (i) same model and
the same prompt template as the implementer; (ii) same model with an adversarial verification prompt; (iii) a different model
with an adversarial prompt and mechanical checks against a lexicon. Measure the rate at which the verifier surfaces ambiguity
versus accepts the user's framing. The hypothesis is that ambiguity-surfacing rate increases monotonically across (i), (ii),
and (iii), with the largest jump between (i) and (ii) -- demonstrating that the structural separation is doing real work and
that adversarial framing is doing more.
