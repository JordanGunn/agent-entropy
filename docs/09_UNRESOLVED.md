# IX. What Remains Unsolved

No framework survives contact with a real codebase without leaving something unresolved. The three intervention pillars described in this paper are tractable, implementable, and grounded in decades of prior work. They are not complete. The following problems remain open, and intellectual honesty requires naming them directly.

---

### The Intent Bootstrapping Problem

Metrics define a floor. They do not encode why a decision was made.

A package with high instability might have been designed that way deliberately -- a rapidly evolving module in active development, intentionally kept concrete until its interface stabilises. A class with high LCOM might be large for a legitimate domain reason that no metric can see. The framework as described has no mechanism for representing justified exceptions in a way that is itself rot-resistant. A comment in the code explaining the exception will rot. A markdown file documenting it will rot faster.

The most honest proposed solution is a structured exception registry -- a machine-readable file, version-controlled alongside the code, where each exception carries a threshold deviation, a justification, and an expiry condition. Something like: "Package X is permitted a Distance score above 0.4 until the v2 interface is finalised, at which point this exception is automatically invalid." The expiry condition is the key property. An exception with no expiry is documentation. An exception with an expiry is a contract.

This is not naive in principle. It is naive in practice, because it requires developers to maintain a second artifact with discipline that the paper has already argued humans reliably fail to sustain. The honest answer is that this problem is not solved by the framework and will require tooling support -- automated expiry enforcement, CI gates that reject expired exceptions -- to be durable in practice. That tooling does not yet exist in a standardised form.

---

### The Social Problem

Adoption requires developers to want to be held accountable. Every intervention described in this paper introduces friction at the moment of maximum impatience -- the moment someone wants to start building.

The history of static analysis tooling is instructive and not encouraging. Pylint has existed since 2003. ESLint since 2013. SonarQube since 2007. All are technically sound. All face the same adoption curve: enthusiastic installation, gradual suppression of warnings, eventual configuration drift toward permissiveness, and silent abandonment. The tools do not fail because they are wrong. They fail because the cost of compliance feels immediate and the benefit feels distant.

The framework proposed here has no structural solution to this problem. The honest proposed mitigation is integration at the point of least resistance -- shipping metric enforcement as a pre-configured CI step rather than a developer-configured tool, defaulting to warn rather than block until thresholds are calibrated for a given codebase, and making the first violation surfaced by the system something the developer already suspects is a problem. That last point is important: a metric that surfaces a violation the developer recognises earns trust faster than one that surfaces a violation they disagree with.

None of this guarantees adoption. It reduces the activation energy. The social problem is ultimately not a technical problem, and this paper does not pretend otherwise.

---

### The Baseline Problem

The proxy metrics in Section VIII -- TTR, TPO, context consumption, and outcome variance -- are only meaningful when compared against a baseline. How many tokens should a well-specified file search operation consume? How much reasoning is appropriate before the first tool call on a moderately complex task? Without established baselines, the metrics produce numbers without reference points.

Establishing those baselines requires running the three-scenario experiment described in Section VIII across a large enough sample of task types, model families, and codebase sizes to produce statistically stable reference values. That is tractable work. It is also work that has not been done, and that a single paper cannot do alone. It requires coordinated effort -- ideally across multiple research groups, with results published as a shared resource the community can build on.

The naive proposed solution is to crowdsource baseline data by instrumenting skills built on the structural pillar with optional telemetry, aggregating anonymised session metrics across consenting users, and publishing the resulting distributions as a versioned dataset. This is naive because it assumes a level of community coordination and trust that does not currently exist around agentic tooling, and because self-selected telemetry produces biased samples. It is nonetheless the most tractable path currently visible.

A less naive but slower solution is to treat baseline establishment as a dedicated research contribution -- a follow-on paper whose sole purpose is producing the reference distributions that make the proxy metrics interpretable. That work is clearly scoped, clearly valuable, and clearly outside the bounds of what this paper can deliver.

---

### The Provenance Problem

Of the four agentic smells described in Section VI, provenance collapse is the only one this paper cannot offer a tractable remediation for. The other three each have a corresponding intervention pillar -- structural metrics for structural smells, controlled vocabularies for semantic smells, structural separation of verifier and implementer for intent smells. Provenance collapse has no such pillar, and the gap is not for lack of looking. It is because the underlying problem -- preserving the *why* behind a decision in a form that an agent can query reliably months later -- has been an open problem in software engineering for decades, and the agentic context has not made it easier.

The closest existing practice is the Architecture Decision Record, a convention introduced by Michael Nygard in 2011 *(Nygard, M., 2011)*. ADRs are short structured documents that capture significant architectural decisions, their context, the alternatives considered, and the rationale for the choice made. The convention has been refined repeatedly since: tooling such as `adr-tools`, Log4brains, and the C4 model's decision documentation have iterated on the format, the directory structure, the metadata, and the templates. None of these has solved the staleness problem identified in Section III. An ADR is a markdown file maintained by discipline. It rots on exactly the schedule that any other markdown file rots, and its rot is silent in exactly the same way. The artifact has no awareness of whether the code it describes still exists in the form described. The community has known this is a problem for over a decade and has not closed it.

The honest description of what a provenance solution would need to do is straightforward to state and difficult to achieve. It would have to produce, at the moment of decision, an artifact that records the intent behind the decision, anchors that intent to a verifiable property of the code state at the time of writing, can be queried by an agent in a later session against the *current* code state, and surfaces a meaningful signal when the current state has diverged from the state the artifact was anchored to. Each of these requirements is individually tractable. The combination is not yet packaged in any standardised tool, and the design space includes several open questions: who authors the intent declaration -- the developer, the agent, or both; at what scope the code-state anchor is computed -- function, file, module, or boundary; what counts as a *significant* decision worth recording; and how the system handles intentional drift, where the code is supposed to have moved past what the artifact describes.

Several directions for tackling these questions exist in the broader software engineering literature -- decision records anchored to commit hashes, structured rationale stores queried at remediation time, lightweight intent capture integrated into the tool-use loop -- and a working solution will likely combine elements of more than one. None of them currently exists in a form that can be dropped into the workflow and trusted to survive.

This problem is named here because it is the right problem to name. Its solution is left as future work because that is honestly where it stands. The framework proposed in this paper does not depend on solving it; the other three smells can be addressed in isolation, and the corresponding interventions are useful on their own. But provenance collapse is the failure mode most likely to be discovered the hard way by a reader who attempts to apply this framework to an existing codebase, and naming it in advance is the least the paper can do.

---

These four problems are not fatal to the framework, but they are not equivalent. The intent bootstrapping problem affects a minority of legitimate exceptions, not the common case. The social problem is shared by every quality enforcement tool ever built and is not unique to this approach. The baseline problem is a tractable research gap, not a theoretical objection. The provenance problem is qualitatively different from the other three: it is genuinely open, the solution space has not yet converged, and the framework's ability to address it depends on work that has not yet been done by anyone -- not for lack of effort, but for lack of a viable design. A reader who encounters any of these four without acknowledgement will find them anyway. Better to name them first.
