# VII. A Framework of Interventions

The preceding sections have described **three distinct but related failure modes** in agentic development:
*structural rot* that accumulates invisibly in the codebase, *semantic overload* that erodes the signal quality
of the agent's reasoning surface, and *intent that arrives underspecified* and gets encoded that way. Each
failure mode operates at a different layer. **Each requires a different class of intervention.** Together, they
form a complete picture of why agent-assisted development so often produces output that *works but degrades* --
and what can be done about it.

## Agentic Intervention Pillars

The three intervention pillars are:

1. **Structural** — Enforcing *computable quality contracts* on the code itself, **independent of any agent's
judgment or any developer's intuition**.

2. **Semantic** — Constraining the *vocabulary* used within a codebase to prevent the overloading of terms
that collapses architectural boundaries and expands the agent's disambiguation burden.

3. **Intent** — Intercepting *underspecified prompts* before they reach an implementation agent, surfacing ambiguity
at the **moment of lowest cost** rather than allowing it to propagate into the codebase where it compounds.


These are **not sequential steps**. They are *concurrent layers of defence*, each catching a class of failure that
the others cannot see.

---

### The Structural Pillar: Metrics as Contracts

The metrics described in `Section IV` are **not reporting tools**. Used correctly, they are ***contracts*** -- computable
thresholds that define the boundary between acceptable and unacceptable structure, enforced *at the point where
the agent's output meets the codebase*.

A Distance from the Main Sequence ceiling, checked as a pre-commit hook, does not ask whether the agent's output
feels right. It measures whether the dependency structure of the affected packages has drifted into the Zone of Pain
or the Zone of Uselessness, and blocks the commit if it has. A Cognitive Complexity threshold, enforced as part of a
CI pipeline, does not require a senior developer to review every function. It identifies, automatically and without
ambiguity, the functions that no human should be expected to maintain.

The critical property of this intervention is that **it cannot rot**. The metric reads the code directly. *There is no
documentation to go stale, no instruction to drift out of context, no natural language to misinterpret.* The contract
is defined once, at the threshold level, and from that point forward the code **either satisfies it or it does not**.

This is the philosophical core of Meyer's Design by Contract *(Meyer, B., 1992)*, applied at the architectural scale
rather than the method scale. The precondition is not "*this function receives a valid argument*". Rather, it is
"*this package has not crossed the line between stable abstraction and painful rigidity.*" The enforcement mechanism
is not the type system, it is the metric.

---

### The Semantic Pillar: Vocabulary as Architecture

A **controlled vocabulary** is the *most underrated artifact* a development team can produce. **Not a style guide. Not a naming
convention document.** A short, maintained, authoritative list of the primitive terms used in a codebase, each defined with
enough precision to *distinguish it from every other term it might be confused with*.

The list does not need to be long. It needs to cover the terms most likely to be overloaded. In a data ingestion system: 
`load`, `fetch`, `read`, `parse`, `ingest`, `download`, `deserialise`. In an API layer: `request`, `call`, `invoke`, `dispatch`, 
`send`. Each term should carry a single, scoped definition and a short note on what it is not. `fetch` retrieves raw bytes from a
remote source. It does not deserialise them. `parse` converts raw bytes into a structured representation. It does not fetch anything.

This artifact rots at the pace of domain understanding, which is an order of magnitude slower than the pace at which CLAUDE.md files decay.
When the domain model evolves, the vocabulary is updated explicitly, in one place, as a deliberate act. There is no implicit drift. There are
no superseded decisions hiding in paragraph three of a section nobody has read since the first sprint.

The boundary-enforcing effect is architectural, not cosmetic. When `fetch` and `parse` are distinct terms with distinct definitions, the
functions that implement them naturally separate. Package boundaries emerge from the vocabulary because the vocabulary has made certain
collapses impossible to name.

---

### The Intent Pillar: Interception Before Encoding

**The cheapest point at which to resolve ambiguity is before any code is written.** A *skepticism pass*: a lightweight hook that examines a prompt
before forwarding it to an implementation agent. This does not need to be a sophisticated system. It needs to do *one thing*: **ask whether anything
in the request is ambiguous enough to produce meaningfully different outputs depending on interpretation**.

This intervention targets the placation problem directly. The implementation agent, receiving a forwarded prompt, has *no history of the original
request*. It sees a cleaned, clarified instruction and acts on it. **The sycophantic pressure to agree with the user's framing is interrupted at the
handoff point**, before it has the opportunity to encode underspecified intent into architecture.

The mechanism is already available in current agentic platforms as a *lifecycle hook*: a `UserPromptSubmit` handler that intercepts the prompt before
it reaches the model, applies a skepticism pass, and either forwards it with clarifications or returns a targeted question to the user. The implementation
is *a single skill, a page of instructions*. **The cost is one additional exchange at the start of a session. The benefit is paid across every session that follows.**

#### Claude Hooks

These lifecycle hooks are not hypothetical. Claude Code exposes a `UserPromptSubmit` hook that fires before any prompt reaches the model, a `PostToolUse`
hook that fires after each tool execution, and a `PreCompact` hook that fires before context compaction. Each represents an interception point where a skill
can inspect, modify, or gate the agent's behaviour without requiring changes to the model itself *(Anthropic, Claude Code Documentation, 2024)*. The skepticism
pass described above is implementable today, in a single skill file, using the `UserPromptSubmit` hook as its entry point.

---

## Benchmarking the Structural Pillar

The structural pillar is not theoretical. In controlled benchmarking of an implementation applying the deterministic minimalism principle to the most
common class of agentic file operations -- search and enumeration -- agents were constrained to generating parameters, not actions, with deterministic
scripts performing all execution. Natural language was used only to express intent. If a task could be deterministically scripted, the agent was not
allowed to do it.

The benchmark results are direct evidence for the structural pillar's central claim. Constraining agent authority to parameter selection, with execution
reserved for deterministic scripts, measurably reduces the reasoning burden placed on the agent.

In controlled experiments comparing agent performance with and without the structural intervention:
* **Context consumption** dropped from *47%* to *25%* of the available token budget.
* **Files read** dropped from *35* to *28*.
* **Search operations** dropped by ***98%***, moving from *200–300 file scans* to *6 targeted passes*.
* **Output quality** remained unchanged or improved.

These results reflect the structural pillar *in isolation*. The full three-pillar experiment described in `Section VIII` has **not yet been conducted**.
*No controlled vocabulary. No intent interception.* A single layer of intervention, applied only to file search operations, producing a **47% reduction
in token consumption with no degradation in output**. The implication for a full three-pillar implementation is significant and forms the basis for
the experimental design described in `Section VIII`.

---

## Provider Agnosticism

A framework that only works with one agent, one IDE, or one platform is **not a framework — it is a configuration**. The interventions described here are
*provider-agnostic by design*.

Metrics enforcement belongs in the CI/CD pipeline, not the agent. A pre-commit hook that computes a Distance score and blocks a push has no dependency
on which agent wrote the code. Vocabulary constraints live in a text file that any agent can be pointed at. Intent interception hooks exist as lifecycle
primitives in every major agentic platform; Claude Code's `UserPromptSubmit`, Cursor's prompt middleware, any platform that exposes a pre-execution hook.

*The agent writes the code. The contracts evaluate it. The vocabulary constrains the terms it can use. The hook interrogates the intent before it begins.*
**None of these require the agent to be trusted. They require the agent to be bounded** — a meaningfully different ask, and a much more achievable one.


---

## [EXPERIMENT INSERT]

Full three-pillar experiment -- 10-20 representative agentic coding tasks, each run under four conditions: barebones, structural pillar only, semantic pillar only, all three pillars. Record context consumption and token-per-operation ratio for each. Implement a metric enforcement hook gating on D-score, LCOM, and Cognitive Complexity thresholds -- measure false positive rate vs true positive rate across a sample codebase.
