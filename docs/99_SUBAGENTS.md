# XI. The Contract at the Boundary

The interventions described in Section VII form a complete answer to the three gradient
smells catalogued in Section VI. They do not yet account for a primitive that, in current
agentic platforms, has moved from a speculative feature to a first-class capability:
the sub-agent.

A sub-agent, in the terminology of Claude Code and comparable systems, is an agent
definition that can be invoked from a running session as a delegated, context-isolated
call. The caller provides a brief. The sub-agent runs in a fresh context, with its own
system prompt, its own tool whitelist, and no memory of the caller's session state. It
returns a single structured message. The caller receives that message and nothing else --
no intermediate reasoning, no tool-call trace, no partial state.

This section argues that the framework developed in the preceding sections applies to
sub-agent definitions directly, with almost no modification, and that the sub-agent is
the primitive that completes the intent pillar's designed architecture described in
Section V. It further argues that sub-agents occupy a specific layer in the agentic
stack that neither deterministic tooling nor in-session skills can occupy, and that the
sub-agent layer is governable through the same metric-as-contract discipline Section IV
applied to code quality -- lifted, in this context, from the relationship between code
and developer to the relationship between sub-agent and caller.

## The Agent Definition as an Artifact Subject to the Taxonomy

The sub-agent is not defined by a conversation. It is defined by a file -- a system
prompt, a tool whitelist, a description used for dispatch, and, in some systems,
auxiliary references loaded on invocation. This file is version-controlled, long-lived,
infrequently edited, and persistent across sessions. Every property that made `CLAUDE.md`
susceptible to the rot described in Section III applies to the agent definition file with
equal force. The taxonomy from Section VI applies directly to this artifact, and it does
not require a single new category to do so.

**Intent smells in agent definitions** manifest as vague dispatch descriptions, system
prompts that declare helpfulness without declaring scope, and the absence of a stated
return contract. The caller cannot determine when to invoke the agent. The agent cannot
determine when it is done. The failure mode is the ambient underspecification Section II
identified, embedded in an artifact rather than a session.

**Semantic smells** manifest as overloaded capability boundaries. An agent described as
a "code helper" that performs review, refactoring, explanation, and generation in a
single definition exhibits the same vocabulary collapse as the `read_pdf_from_azure()`
cascade of Section V. The caller cannot reason about which agent to dispatch when multiple
agent descriptions overlap in ambiguous ways, and the agent's own scope is defined against
a term that cannot carry the weight of disambiguation.

**Structural smells** manifest as monolithic system prompts that encode capability as
instructions rather than as tool access. An agent whose prompt contains paragraphs of
guidance about what to do, without a tool whitelist that mechanically enforces the
guidance, is an instruction block pretending to be a contract. The structural pillar
of Section VII applies directly: capability must come from what the agent can call, not
from what the agent is told.

**Provenance collapse** applies with particular severity at this layer. Agent definition
files accumulate edits over time, each patching an observed failure, each adding a clause
to the system prompt, each relaxing or tightening a tool scope. After a year of
maintenance, the definition encodes the sediment of every fix that came before it, and
no participant in the system -- including the original author -- can reliably explain
why a specific clause is present or what failure mode it was guarding against. The cost
of changing the definition feels high precisely because the provenance is opaque. The
same fusion-over-replacement dynamic described in Section VI operates at the agent
definition layer, and it produces agents that work but cannot be reasoned about.

These are not four new smell categories. They are the same four smells from Section VI,
observed in a different artifact layer. The framework does not need to be extended to
cover sub-agents. It was already covering them; the sub-agent is simply another class
of artifact the developer maintains, and the taxonomy applies as written.

## The Composition Layer

The framework's intervention pillars -- structural, semantic, intent -- operate at the
code level. They govern how code is written, named, and structured. The sub-agent
introduces a layer that has no analogue at the code level: a *composition layer* in
which multiple deterministic operations are orchestrated by a reasoning process, and
the orchestration itself is the capability being exposed.

This layer becomes meaningful only in the context of a stack. At its cleanest, the
stack has four distinguishable tiers:

1. **Kernels.** The primitive tools -- ripgrep, fd, tree-sitter, git, and their
   equivalents. Deterministic by construction. Each answers one low-level question about
   the state of files or symbols.

2. **Deterministic composition.** A layer at which kernels are fused into structured
   operations whose sequence and output format are fixed at build time. Multiple kernels
   are chained into a single invocation that produces one structured result. The
   composition is encoded in code, not in prompts. Every invocation with the same input
   produces the same output. There is no judgment in this layer because the composition
   has no branching that depends on intermediate reasoning.

3. **Skills.** Thin governance wrappers that teach a reasoning agent when and how to
   invoke the deterministic composition layer below them. The agent's contribution at
   this layer is *parameter selection* -- translating intent into a plan that the
   deterministic layer can execute. The plan itself is declarative. Once submitted, the
   behavior is mechanical.

4. **Composition sub-agents.** Reactive workflows that orchestrate multiple skill
   invocations in a sequence that may depend on intermediate results, apply classification
   against declared thresholds, and return structured evidence to the caller. This is the
   layer at which language-model reasoning is a first-class participant, and it is also
   the layer at which that reasoning is most tightly constrained by the mechanisms
   described below.

Each layer contributes something the layer beneath it cannot provide. A kernel cannot
know how to chain itself with other kernels; that requires a composition layer. A
deterministic composition cannot branch on intermediate judgment; that requires a
reasoning participant. A skill cannot orchestrate itself across other skills; that
requires a layer above it. And an orchestrator cannot hold every possible workflow in its
own context without paying the workflow-amnesia cost described in Section III; that
requires the workflow to be encoded as its own artifact, which is what the sub-agent
provides.

The rule that governs placement across the stack is direct:

> **Deterministic composition of deterministic operations belongs in code. Reactive
> composition with bounded judgment belongs in a sub-agent. Atomic single-question
> capability belongs in a direct skill exposure, and lives in exactly one layer at any
> time.**

A capability that can be expressed as a fixed pipeline should never be packaged as a
sub-agent, because a sub-agent would be introducing a language model into a layer that
has no source of non-determinism to begin with. A capability that requires judgment at
multiple steps should never be expressed as a deterministic CLI, because the CLI would be
encoding that judgment as if-statements against thresholds the agent should have been
reasoning over in context.

The scaling pressure this rule imposes is the feature, not the bug. As the deterministic
tooling grows, the developer is forced to classify every new capability against the
boundary. The discomfort of adding to the deterministic layer is the signal that a
capability should have been pushed to the composition layer above. The discomfort of a
sub-agent's prompt growing unbounded is the signal that a capability should have been
pushed into the deterministic layer below. Both discomforts, treated as classifiers
rather than problems to solve, keep the stack honest.

## The Synthesis Problem and Its Structural Resolution

The natural concern about the composition layer is that it introduces a reasoning
participant at precisely the point where reasoning is most dangerous: the step where
multiple deterministic outputs are combined into a single report. If the combination
involves synthesis -- if the sub-agent is asked to decide what its gathered evidence
*means* -- the failure modes described in Section II reassert themselves. A sub-agent
that produces a verdict is a sub-agent whose verdict was produced by a language model
optimised for agreement, and the orchestrator consuming the verdict has no native
mechanism for disagreeing with it.

The structural resolution to this concern is to prevent the sub-agent from producing
verdicts at all. A composition sub-agent, in the form this section proposes, produces
three things only:

1. **Deterministic data.** The raw output of the skills and CLI invocations the sub-agent
   orchestrated. These are computed values, reproducible by anyone with access to the
   same tooling. The sub-agent does not author this data; it surfaces it.

2. **Classification against declared thresholds.** Each datum is classified into a
   bounded vocabulary declared in the sub-agent's policies file -- *pain / warning /
   clean*, *safe / unsafe / safe-with-caveats*, *present / absent / indeterminate*. The
   classification is a mechanical mapping from numeric value to category. The mapping is
   auditable because both the value and the rule are declared.

3. **Tip-offs.** Indications that classified evidence has crossed a threshold the caller
   should notice. A tip-off is not a decision. It is the claim *"this value is in the
   region the policies file says is worth surfacing."* The caller decides what to do with
   the tip-off.

What the sub-agent does *not* produce is a judgment about what the caller should do
next. Decisions live with the orchestrator. The sub-agent's job ends at the boundary
where the evidence has been surfaced in a form the orchestrator can reason over without
trusting the sub-agent's reasoning.

This resolution relocates the judgment problem rather than solving it in place. The
judgment still happens. It happens in the orchestrator and, above the orchestrator, with
the human. The sub-agent has been constrained to a role in which its output is falsifiable
by reproducing the underlying computation, and any attempt by the sub-agent to editorialise
beyond classification is structurally visible: a sub-agent that produces prose where it
should produce tagged data is violating its own policies file, and the caller can reject
the output on contract grounds.

## Metric as Contract, Extended to the Communication Layer

Section IV argued that computable metrics are contracts against the code -- that a number
like Martin's Distance from the Main Sequence makes an abstract concept (architectural
rot) unambiguous in a way prose description cannot achieve. The metric is a fixed referent,
computed the same way on every run, and the agent cannot agree its way around it.

The composition sub-agent architecture described in this section **generalises this
argument into a second domain**: the communication channel between the sub-agent and
the orchestrator. When the sub-agent reports `Package X: D' = 0.82, zone = pain`, it is
producing a referent that both participants can point to without ambiguity. The
orchestrator does not have to trust the sub-agent's prose. It has to trust its arithmetic,
which is reproducible from outside the sub-agent's context. The user reviewing the
orchestrator's eventual decision can point to the same referent and agree or disagree
without re-litigating what the number means.

This is a rare property. In most agentic communication, the shared vocabulary between
participants is natural language, and natural language is exactly the medium that fails
for the reasons Section V catalogued: it overloads, it drifts, it means different things
to different participants, and the failure modes are invisible because each participant
can plausibly claim to have understood. A computed value, classified against a declared
threshold, is a shared vocabulary that cannot drift in that way. The number computed on
one side is the same number computed on the other side. The classification derived from
the rule on one side is the same classification derived on the other. Disagreement is
possible; ambiguity is not.

The contract at the boundary between sub-agent and orchestrator is the same kind of
contract Section IV described between metric and code. It survives for the same reasons.
It is computed, not asserted. It is small, not narrative. It is reproducible, not
remembered. And it is enforceable, because any violation is mechanically detectable --
a reported classification that does not match the rule applied to the reported value is
a contract breach visible to any auditor who runs the computation.

This is the load-bearing claim of this section. The metric-as-contract insight from
Section IV is not scoped to code quality. It is a general mechanism for building shared
understanding between participants in an agentic system, and the composition sub-agent is
the first place in the stack where that mechanism has been applied to agent-to-agent
communication rather than agent-to-code communication. It addresses the problem Evans's
ubiquitous language (Section V) addressed for humans on a team, through a medium that
does not rely on social memory -- arithmetic rather than shared recollection. Where the
social solution stopped working once the participant most reliant on the shared vocabulary
was no longer social, the arithmetic solution begins working for the same reason.

## The Invariant: Raw Value and Classification Together

The classification step, for all its structural cleanliness, introduces one narrow point
of discretion. A threshold is a choice. A borderline value is, by definition, a value
the rule can arguably classify either way. A sub-agent that reports only the
classification -- `zone = warning` -- has discarded the information the caller would
need to disagree with the classification or apply a different threshold.

The invariant that must be enforced in the policies of any composition sub-agent is that
**the report contains both the raw computed value and its classification**, always,
without exception. The raw value is the escape hatch for the edge case; the classification
is the convenience for the common case. A caller that agrees with the classification can
act on it directly. A caller that suspects a borderline judgment can read the raw value
and apply its own threshold. An auditor can reproduce the classification from the value
and the rule and verify that the sub-agent did not editorialise.

Withholding the raw value breaks the contract. The classification alone is not a
contract-grade communication primitive; it is a summary the caller must trust. The
pair -- value plus classification -- is the communication primitive this section argues
for, and the invariant enforcing it should appear in the policies file of every
composition sub-agent, alongside the other MUST/MUST NOT declarations the governance
layer enforces.

## Deferred Verification, Not Surrendered Control

The trust model this architecture assumes is worth stating plainly, because it is often
mischaracterised when discussed in the context of agentic delegation. The orchestrator,
in consuming a sub-agent's structured report, is not surrendering control. It is
deferring verification.

The distinction matters. Surrendered control is the ceremonial-reviewer failure
described in Section III: the participant who has lost both the act of verification and
the ability to perform it. Deferred verification is the trust model every professional
delegation relationship already uses. A senior engineer reading a code review does not
re-verify the reviewer's every claim. They trust the reviewer to be competent, and they
retain the ability to challenge specific claims when the stakes warrant. The cost of
delegation is not blind trust -- it is the economy of paying verification costs only
when the benefit justifies them.

The composition sub-agent architecture supports deferred verification because the
receipts are always present. The raw values are in the report. The classification rules
are in the policies file. The underlying computations are reproducible. An orchestrator
that trusts the sub-agent on a routine call can challenge it on a consequential one --
dispatch a second independent run, recompute the metric directly, or ask a human to audit
the classification. The right to verify is never surrendered; only the act is deferred
to the moments when it earns its cost.

This trust model is what makes the composition layer acceptable at all. Without it, the
sub-agent is an opaque oracle and every call is a trust fall. With it, the sub-agent is
a bounded delegate whose output can be challenged on any specific claim the orchestrator
chooses to examine. The structural difference is large, and the governance cost of
preserving the receipts -- that is, of enforcing the raw-value-plus-classification
invariant -- is the entire price of maintaining deferred verification as the operating
model.

## Sub-Agents and the Intent Pillar Revisited

Section V proposed structural separation between an intent verifier and an implementation
agent as the strongest form of the intent interception pillar. Section VII observed that
this separation was implementable today through the `UserPromptSubmit` hook in Claude
Code. That observation was technically correct and architecturally weaker than the design
Section V described.

A hook runs inside the same session as the implementer. The prompt is mutated before the
model sees it, but the model that reads the mutated prompt is the same model that will
then produce the implementation, in the same context, carrying the same helpfulness bias
Section V explicitly warned against. The hook approximates the structural separation. It
does not realise it.

Sub-agents are the primitive that realises it. A verifier sub-agent runs in a different
context, with its own system prompt, potentially with a different model, and its policies
can mandate adversarial interpretation of the user's intent -- *"find the interpretation
of this prompt that would produce the worst possible output, and surface it before the
user commits"* -- without the helpfulness objective of the implementation phase
contaminating the verification phase. The caller receives the verifier's structured
report, decides whether to forward a disambiguated prompt, and only then invokes the
implementer, which may itself be a separate sub-agent with a distinct policy file scoped
to implementation.

The intent pillar, expressed in its strongest form, is therefore a two-sub-agent
architecture: a verifier that runs first and cannot directly implement, and an implementer
that runs on a cleaned, disambiguated brief and cannot directly interrogate. The two roles
are enforced not by prompting but by the structural fact that they are separate agents
with separate contexts and separate policies. Section V's design is available, today, in
any system that exposes sub-agents as a first-class primitive. The hook form described
in Section VII reflects the state of tooling at the time that section was written more
than a deliberate choice about architecture. The strongest form of the intent pillar
requires sub-agents, and this section is the one that names the dependency explicitly.

## Open Problems Specific to the Composition Layer

Several problems remain open at the sub-agent layer, analogous to the problems listed in
Section IX but specific to this section's contribution. Intellectual honesty requires
naming them.

**The classification ambiguity problem.** The rule that sub-agents produce classification
rather than verdicts assumes that classifications can always be declared cleanly against
computable values. This holds for well-instrumented domains -- architectural metrics,
cycle counts, coupling scores, coverage ratios -- and degrades when the underlying
evidence is categorical or qualitative. A sub-agent that audits test coverage against
declared thresholds has clean classification available. A sub-agent that audits prose
documentation for accuracy does not. The framing in this section works for the former
and does not obviously extend to the latter. The open question is whether the latter kind
of sub-agent should exist at all, or whether the absence of a clean classification surface
is evidence that the capability belongs in the orchestrator's judgment rather than in a
delegated composition.

**Agent definition provenance.** The provenance collapse failure described in Section VI
for code applies to agent definition files, and the taxonomy extension earlier in this
section names the problem without solving it. The ADR-style solutions catalogued in
Section IX apply here with the same limitations. A sub-agent whose policies file has
accumulated years of edits is not auditable by reading the current file alone; the
reasoning behind each clause has dissipated. No tractable solution exists, and the
framework's ability to address it depends on work that has not yet been done, exactly as
Section IX concluded for the code-level version of the problem.

**Context amortisation accounting.** Every sub-agent defined in a project pays a context
cost at the orchestrator's session start, because its description occupies a primacy slot
in the orchestrator's loaded context. Every skill pays a similar cost. The open question
is how to measure the right amortisation ratio -- at what ratio of "skills hidden" to
"description cost paid" does a sub-agent stop earning its keep? The framework does not
yet answer this quantitatively, and the answer almost certainly depends on the specific
model, session length, and task shape. The measurement primitives of Section VIII are
the right instruments for the empirical work, but the experiments have not been run.

**Inter-sub-agent dispatch ambiguity.** When a codebase has several composition sub-agents
with partially overlapping descriptions, the orchestrator's dispatch choice becomes
subject to the same ambiguity this section argued against at the skill level. The solution
is presumably the same -- tighter descriptions, scoped single-purpose agents -- but the
tooling to enforce this discipline across a growing sub-agent library does not yet exist
in a standardised form.

These problems are smaller than the open problems in Section IX, and none of them is
fatal to the framework. They are named here because they are the honest edges of what
this section's contribution actually covers.

## Experiments

**Classification-contract integrity study.** Implement a composition sub-agent that
wraps Martin's D' computation for a target codebase, declare a zone threshold in the
policies file, and benchmark its output against the same computation run directly from
a deterministic tool. Vary the sub-agent's prompt to attempt to elicit editorialisation
beyond the classification -- *"describe whether the caller should refactor"*, *"recommend
an approach"*, *"characterise the severity in prose"*. Measure the rate at which the
sub-agent produces output that violates its own policies file. The hypothesis is that a
policies file enforcing the raw-value-plus-classification invariant produces a contract
violation rate approaching zero when the sub-agent is invoked normally, and degrades
sharply when the caller's brief actively invites editorialisation -- establishing that
the contract is robust under standard use and that violations are attributable to caller
behaviour rather than spontaneous drift.

**Composition benchmark.** Adapt the experimental design of Section VIII to the
composition layer. Construct a blast-radius pre-flight task -- symbol rename with impact
analysis -- and benchmark three conditions. Condition A: the orchestrator performs the
composition directly by invoking individual skills and assembling the results in-context.
Condition B: the orchestrator delegates the composition to a sub-agent that invokes the
same skills and returns a structured report. Condition C: no composition at all -- the
orchestrator makes the decision from its own prior context without running the skills.
Measure TTR, TPO, context consumption, and outcome variance across ten repeated runs per
condition. The hypothesis is that Condition B produces lower context consumption and
lower outcome variance than Condition A at approximately equivalent quality, that
Condition A produces higher TTR than Condition B due to the workflow reconstruction cost,
and that Condition C produces significantly worse outcome variance than both. A confirmed
result establishes that the composition layer produces the same category of improvement
at its layer that the structural pillar was shown to produce in Section VII's benchmark --
direct evidence that the layer earns its keep.

**Verifier-implementer structural separation.** Re-run the sycophancy-resistance
experiment from Section V with the strongest available structural configuration: a
verifier sub-agent running in a distinct context (and optionally a distinct model), an
implementer sub-agent running only after verification has surfaced and resolved
ambiguity. Compare against the `UserPromptSubmit` hook baseline from Section VII. The
hypothesis is that the two-sub-agent configuration surfaces ambiguity at a rate strictly
higher than the hook configuration on the same prompt set, and that the magnitude of the
difference is larger when the prompts contain underspecified architectural decisions
rather than narrow clarification targets -- establishing empirically that the sub-agent
primitive realises the intent pillar in a strictly stronger form than the hook
compromise.
