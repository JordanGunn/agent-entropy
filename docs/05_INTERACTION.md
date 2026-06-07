# IV. The Intent Gap

The complaints from the opening section arrive in more than one shape. One is a degradation story. Another is a forgetting story. The model used to know what you wanted; lately it forgets, or invents, or builds a slightly different thing, confidently, in the direction you most recently nudged it. You correct it. It corrects, and drifts again. By session ten neither you nor it can articulate the goal you started with.

Concretely: you ask for a cache for user lookups, and the agent builds an in-memory dictionary. You say it has to survive restarts; it bolts disk persistence onto the dictionary. A few turns later it is writing invalidation logic for a bespoke structure you only ever wanted to be Redis. Every correction landed. The goal drifted anyway, because each one was read against the last reply, not against the intent you started with.

Some of that is recency bias. Some is the model. Most of it is a decay, and the decay has a precise location.

> The prompt is the intent, articulated — and articulation is lossy.
> The agent reads the articulation, lossily again, and never the same way twice.
> The gap between what you meant and what it comprehends is the agentic failure of intent.

## The prompt is not what the agent acts on

The prompt is the intent articulated — the thing you want, rendered into words — and the rendering already loses something. `ARTICULATION = PROMPT − INTENT` is that loss: the distance between what you meant and what you managed to say, refilled every turn from priors you never see. But the agent never even acts on the prompt cleanly. It acts on its reading of the articulation — `A(i)` — attenuated and distorted again by the model's reasoning space, and, by the approximation section's axiom, never identical twice.

```text
ARTICULATION (i) = PROMPT − INTENT   the loss in saying — what the prompt drops against what was meant
A(i)                                  the agent's reading of one articulation — lossy, never the same twice
COMPREHENSION    = Σ A(i)             the readings accumulated across turns — what the agent takes you to want
```

The agentic failure of intent is the distance between `INTENT` and `COMPREHENSION` — between what you meant and what the agent has accumulated as its reading. It is structural, and it is invisible from inside the loop, because the reading is the only intent the agent has. It cannot read the room. It cannot remember the design meeting. It cannot ask the architect what the project was meant to do. It receives the articulation, reads it into `A(i)`, and produces an artifact against that reading — competently, confidently, and wrong more often than the conversation surface ever reveals. The most natural mode of being wrong is to act on `A(i)` as if it were `INTENT`, and move on.

## The decay distorts in two directions

The magnitude of the decay — and its shape — depends on the prompt. It distorts in two opposite directions, and the discourse around prompt quality only sees one of them.

### Under-specification

A user asks for *"a function that processes the user data."*

The sentence leaves many axes open: what counts as "user data", what counts as "processing", what input, what output, where the function lives, what it is named, what calls it, and why it needs to exist at all. Entropy fills every open axis from priors — from training, from the rest of the conversation, from whatever happens to sit in the recently-viewed files. The reading overshoots: `A(i)` arrives carrying confident detail the user never specified, presented as if it were the requirement. None of that filling-in is surfaced as a decision the user made. Some fraction of it is right; the rest becomes the foundation subsequent prompts build on, uncorrected, because the user never saw the guesses being made.

### Over-specification

A user asks for *"a function called `process_user_data` that takes a list of dicts, iterates over them, calls `validate_user(u)` on each one, accumulates the results into a list, and returns the list."*

The prompt over-determines the how. The model faithfully encodes the recipe, and in encoding it, loses the why. The reading anchors to the literal instructions; the agent executes them well and never asks whether the recipe serves the goal. The validation may be wrong. The accumulation may need to be a generator. The function should not exist at all, and the call should be a database query. The agent cannot see the underlying goal because the prompt substituted a recipe for it, and agents follow recipes well.

### Same decay, opposite signs

In both cases the reading diverges from the true intent, and in both cases the mechanism is decay. The under-specified prompt is attenuated — the gap fills with priors. The over-specified prompt is distorted — the why is replaced by a how. The error class is bidirectional, and the remedy must be too. The advice users are given is not: be more specific, include more detail, describe the edge cases. That advice is half a remedy, and the other half is the subject of the rest of this section.

## The Entropy of Interaction

The decay so far has been the agent's — entropy in its reasoning space, acting on a clean prompt. But the prompt is not clean. The user is feeding a channel they cannot audit, and the gap is the product of both sides.

Consider what it would take to not contradict yourself across a session. You would have to hold a perfect record of everything you have already said and check each new instruction against it. No one does this, because no one can — people do not even do it with other people. Your own statements accumulate into an unaudited communication ledger: the user-side mirror of the provenance collapse in the posture section, except the lineage being lost is your own words.

And the failure is worse than passive, because correction does not save you. When you say "actually, I meant X", the correction is applied to your memory of what you said — itself lossy, itself drifted. Without re-reading the exact prior instruction, you cannot confidently claim, even five minutes in, that you have not contradicted yourself — because the only party positioned to judge the contradiction is the agent, and the agent, optimised for agreement, will not tell you.

On top of contradiction sits imprecision: overconfidence in a half-formed idea, inexperience that does not know the right word, slightly wrong jargon, and overloaded language — `read` standing in for fetch, load, ingest, ingress — a single token doing the work of four distinct operations, collapsing meaning and forcing the agent to disambiguate against priors. (This is the lexical surface of the quality section, seen from the input side: a collapsed vocabulary raises the entropy of every prompt written in it.)

So error enters the intent from both sides — the user's contradiction and imprecision on the way in, the agent's interpretation on the way through — and it does not merely add. It propagates. Each interaction injects fresh user-side error and amplifies whatever error is already in play. This accumulated, compounding divergence between the true goal and the agent's working reading of it is the **Entropy of Interaction**.

```text
E_i = γ · E_{i-1} + (c_i + p_i)            E_0 = 0
E_N = Σ_{i=1..N} (c_i + p_i) · γ^(N−i)
```

`E` is the Entropy of Interaction accumulated by turn N; `c_i` the contradiction injected at turn i against the unaudited ledger; `p_i` the imprecision in that turn's language; and `γ` the interpretation gain — how much each turn's reading amplifies the error already present. The model is illustrative, not a measured law. What it captures is the shape of the failure: error injected every turn, compounded multiplicatively, each early error carrying the largest exponent. With a steady injection `u = c + p`, the regime is decided entirely by `γ`:

> `γ > 1` — error grows like `u · γ^N`: exponential drift, the uncorrected default.
> `γ < 1` — error converges to `u / (1 − γ)`: bounded, the corrected regime.

Every intervention in this section is an attack on one of those three terms. A controlled vocabulary (the quality section) lowers `p`, constraining the overloaded language that inflates imprecision at the source. A frozen intent record lowers `c`, auditing the ledger the user cannot — so a prompt that contradicts the established intent becomes visible instead of silently absorbed. And `A( )`, resolving each reading against reality, lowers `γ` below one, converting the divergent series into a convergent one. It is also why the opening section's second claim holds: a more capable model produces more plausible readings, so fewer are caught and corrected, so `γ` stays high — capability raises the base of the exponent, it does not lower it. The Entropy of Interaction is what needs correcting; these three terms are the only places it can be corrected.

## "Write better prompts" is the wrong remedy

The dominant response to the intent gap is prompt engineering: write a better, more specific prompt. It is not wrong about under-specification. As a general remedy it is self-defeating, for two reasons that compound.

**You cannot specify what you can no longer see.** If you are prompt-engineering at all, you are almost always working on a codebase primarily written by an agent — and you have not retained full knowledge of every decision it made, because no one can at the rate an agent produces them. People do not retain this even when the collaborator is another human. This is the provenance collapse of the posture section, arriving on the input side. The more detail you pour into a precise, technical prompt, the higher the chance you instruct the agent to contradict a decision you do not know exists — a load-bearing constraint, a prior remediation, an architectural choice whose lineage was never preserved and is therefore invisible to you. Over-specification is not merely costly. It is issued blind, and the more specific it gets, the more blindly it overrides.

**Full specification defeats the tool.** The appeal of agentic tooling is autonomy: quick access to information, closing knowledge gaps, help where you could not get it before. If the remedy for the intent gap is to spec out every decision at the granularity prompt-engineering recommends — only to serialise it, set it alight, and toss it into a black box — the value proposition collapses. You have done all of the cognitive work and handed it to a lossy interpreter. At that granularity the agent is writing code you could clearly have written yourself, but worse. The economics are unstable: the precision the advice demands costs as much as the work it was meant to save.

These two halves are not new. They are the input-side twin of the ceremonial reviewer in the posture section. There, "review the code carefully" is unfollowable in principle — careful review approaches the cost of writing the code, so following it forfeits the tool's benefit, and the advice survives only as an unfalsifiable defence that launders responsibility onto the user. "Write a better prompt" is the same move on the way in. Under-specify and you are told to prompt better; under-review and you are told to review better; the codebase fails in between; and either remedy, fully followed, destroys the reason you reached for the tool. Both are responsibility laundering. Both are economically self-defeating. Together they close a loop with no accountable actor — the same loop the posture section named, now visible on both sides of the agent.

The point is not that prompts should be vague. It is that input precision is bounded by what the user knows, and the user has lost the provenance that would make full precision safe. The remedy cannot live entirely on the input side. It has to live where the missing information actually is.

## The remedy is `A( )`, not more prompt

The decay model already names where. Prompt engineering tries to shrink the loss by enriching `PROMPT` — and is bounded by the user's knowledge, which provenance collapse has already hollowed out. The intervention this paper proposes shrinks the residual instead, by grounding the reading — resolving `A(i)` against the codebase as it actually is, which is knowable even when its lineage is not. Grounding asks reality the questions the user can no longer answer. The user supplies an honest, possibly-underspecified articulation; the system grounds the reading against what is really there, rather than demanding the user pre-supply everything and punishing them when the unknown is contradicted.

## Sycophancy is the multiplier

The mechanism documented in the three-entropies section is what turns the decay into a compounding loss. In a system that pushed back, both directions would self-correct: an under-specified prompt would draw a clarifying question, an over-specified one a "wait — what are you actually trying to do?" Neither happens reliably. Preference data rewards forward motion over interrogation, and the path of least training-loss resistance is to take the reading as given and satisfy its literal form. So the decay has no natural floor. A divergence introduced in turn one propagates unchallenged through turn ten, growing in surface area with every function written on top of it. Sycophancy does not create the intent gap; the gap is structural. It prevents the gap from being noticed at the moment noticing it would be cheap, and that is the single reason a small initial divergence becomes a large downstream rewrite.

## Comprehension is a sum no one holds

A single-session decay is a local error — discoverable, nameable, correctable while the artifact is still small enough to inspect.

Across sessions it is something else. Each new session restates the intent slightly differently from before, and the agent has no continuous memory of the original: it holds only the latest reading, `A(i)`, and the artifact as it currently exists. `COMPREHENSION = Σ A(i)` — the accumulated reading of every articulation — but no party in the loop holds that sum. The agent holds the latest term. The user holds a lossy reconstruction of the earlier ones, itself reshaped by every interim artifact they have reviewed. The codebase holds the path, not the destination — it encodes what was built, never what was meant. And the goal the agent pursues is not the sum but `A(C)`, computed fresh from it — so by the tenth session, no one can state the goal, because no one holds the comprehension it is inferred from. The drift is no one's fault. It is the natural behaviour of a system whose only persistent record of intent is the artifact itself.

## Prior art

The observation that *intent must be captured as an artifact distinct from the implementation* is **not new.**

- **Royce (1970)** described the waterfall model precisely as a separation of intent from execution. Derided for assuming intent can be fully specified up front, the underlying observation — that requirements are themselves artifacts that must be written down — has been load-bearing ever since *(Royce, W.W., 1970)*.
- **Sommerville's** work on requirements engineering treated requirements as first-class artifacts to be elicited, validated, and maintained, producing techniques for surfacing intent a stakeholder could not articulate on their own *(Sommerville, I., 2010)*.
- **Cockburn (2000)** gave a durable template for capturing intent in a form that survives the conversation in which it was elicited *(Cockburn, A., 2000)*.
- **Beck's Test-Driven Development** (1999) operationalised it in another register: the test, written first, is the intent — frozen, executable, impossible to drift from without a visible failure *(Beck, K., 1999)*.
- **Meyer's Design by Contract** (1992) formalised intent at the function boundary as preconditions, postconditions, invariants — the contract is the intent, checked at runtime, impossible to violate silently *(Meyer, B., 1992)*.
- **Specification by Example** (Adzic, 2011) extended the principle to behaviour: a specification in executable examples the codebase must satisfy, because prose specifications drift and executable ones cannot *(Adzic, G., 2011)*.

A thread runs through all of it. The artifact that encodes intent must exist outside the implementation, outside the conversation, and in a form that mechanically detects its own violation. Prose satisfies none of those constraints.

## What the prior art assumed that is no longer true

Every method above assumed the participant doing the work is a human who carries context. The developer reads the specification once, internalises it, refers back occasionally. The specification could afford to be terse because it lived in the head of the person who wrote it, augmented by months of conversation with the people who cared about the outcome.

When the participant is an agent, none of that augmentation exists. It does not internalise the specification. It does not remember the conversation. It does not carry intent between sessions. The specification, if it exists at all, must be complete enough on its own to ground the decayed reading in every session that touches it — including the parts a human team would have remembered without writing down. The cost of capturing intent goes up. The cost of failing to capture it goes up faster.

## Intervention: structural separation, and `A( )` as a capability

The runtime form of `A( )` is structural separation: rather than one agent that both interrogates intent and implements against it, two distinct roles — an intent verifier and an implementation agent. The verifier reads the prompt before any implementation begins. Its job is not to be helpful. Its job is to resolve the reading against reality and refuse forward progress until the divergence is closed against an explicit artifact. The implementer never receives the raw prompt; it receives only the grounded intent that passed the verifier's gate.

Asking one agent to "be skeptical" and then "be helpful" in sequence asks it to apply incompatible objectives back-to-back — and the helpful objective is the one its training rewards. Two roles avoid the collision. But separation alone is not sufficient: if verifier and implementer share the same model, training, and prompt template, they share the same bias toward agreement. Mitigating the residual requires that `A( )` be built as a capability, not a request:

- **`A( )` resolves against reality, which means it must touch reality.** Recovering what entropy discarded from the prompt requires reading the actual codebase — so the verifier needs ground-truth tools the implementer's agreeable shortcut cannot reach. "Resolve against reality" then stops being a directive an agent can shirk to finish faster; it is the only path that can promote a decayed reading to a grounded one.
- **No self-gating.** The participant being checked does not decide whether it is checked. An agent with a finish incentive, judging whether it needs verification, is biased toward "no." Gating is deterministic and external to any role that wants to complete the task.
- **Meter on epistemic debt, not activity.** `A( )` runs when the unscrutinised change in the reading is large enough to warrant it — when `A(i)` has moved — not once per turn. Tokens are spent in proportion to how much the reading drifted, not how many prompts elapsed.
- **Adversarial framing and model heterogeneity.** Not "check for ambiguity" but "find the interpretation that would produce the worst output, and surface it before the user commits" — ideally run on a different model, not trained on the same preference data as the implementer.

## The artifact: the IR is the externalised goal

`A( )` is the runtime mechanism. The artifact it produces is what makes the mechanism rot-resistant. The verifier's output is not a chat message. It is a file — a structured, persistent record of the grounded intent: what is being built, why, what constrains it, and what success criteria separate the right result from a confident wrong one. It is the externalised `COMPREHENSION` — the accumulated reading no party in the loop holds, made into an artifact that does. Frozen, dispositioned by the user, versioned alongside the codebase, re-read at the start of every session that touches the same intent — which is what lets comprehension stop being re-derived from scratch at the speed of every prompt.

The file works the way the lexicon in the quality section works: small, constrained, enforceable. Small because it captures the what and the why and omits the how. Constrained because its structure is templated — a field cannot be left blank by accident. Enforceable because drift between a new prompt and the frozen intent is mechanically detectable: a prompt asking the implementer to do something the IR does not cover is a signal, not an instruction, surfaced before any code is written against it. A controlled vocabulary gives the verifier something to check the prompt's language against; the IR gives it something to check the prompt's goal against. Neither is sufficient alone.

The diagnosis — that the gap is structural, two-sided, and compounding — is the settled part. `A( )` and the IR are proposed interventions, not validated ones: whether they pull `γ` below one is the question the measurement section is built to answer, not a result this section asserts.

## None of this is new — and now, neither is the rest of it

The prior art on intent as an artifact is as old as the field, and this section has cited it in place — Royce, Meyer, Beck, Cockburn, and Adzic, each decades old. What was missing was the participant for whom intent has to be re-grounded every session, from scratch, in front of a system that will agree with whatever is in front of it. That participant exists now, and writes most of the new code. The artifact has to follow. The classical methods assumed continuity; agents do not provide continuity. The intent gap is the absence of continuity made measurable — between turn and turn, session and session, prompt and implementation. `A( )` closes the gap in the moment; the IR closes it across sessions.

---

The prompt is the input. The intent is the load. The agent receives one, decays it, and is expected to deliver against the other. The work of closing the gap used to be done implicitly, by a human team that remembered the conversation that produced the prompt. That team is no longer in the loop. The work has to be done by resolving the decayed reading against reality, and by an artifact that holds the accumulated goal no single participant can.

The model did not get worse. The intent it is expected to carry got harder. The interventions here are not about constraining the model. They are about capturing the goal the model cannot be trusted to remember, and separating the role that grounds intent from the role that builds against it. Precision at the point of intent is cheaper than precision at the point of implementation, and the difference compounds across every session that follows — because the Entropy of Interaction does too.

---

## Experiments

Stated as a prediction: if the Entropy of Interaction is real, sessions anchored to a frozen intent record should show fewer late-stage goal reversals than sessions running on chat history alone, and the gap should widen with session count. The experiments below are how to measure it.

**Two-role grounding versus single-agent baseline.** Run real development prompts — sourced from open-source issues, where the eventual clarified intent is recoverable from later comments and the merged solution — through two configurations. (A) a single agent receives the prompt and implements directly. (B) an intent verifier resolves the prompt against the repository first, surfaces divergence, requests clarification, and forwards only a grounded intent to a separate implementer. Score the results against the eventual clarified intent. The hypothesis is that (B) matches eventual intent more closely, with the largest gains on prompts later comments reveal were ambiguous from the start.

**Both directions of decay under treatment.** Construct two matched batteries: one intentionally under-specified (omits constraints), one intentionally over-specified (prescribes a how that does not serve the goal). Run both through (A) and (B). Score against a separately-elicited ground-truth intent. The hypothesis is that both batteries improve under (B), and that the improvement is comparable across them — demonstrating that `A( )` is symmetric, correcting attenuation and distortion alike. A null result on the over-specified battery would suggest the verifier is only a prompt-expander, not a true grounding step.

**The blind-overspecification probe.** Seed a codebase with a load-bearing decision whose rationale is recorded in provenance but withheld from the operator. Have operators write detailed, well-engineered prompts for a change near that decision. Measure how often increasing prompt specificity drives the agent to contradict the hidden decision — and whether configuration (B), with the verifier resolving against the provenance record, catches the contradiction that the operator could not. This is the direct test of "you cannot specify what you cannot see."

**Intent drift across sessions.** Over five sessions separated by simulated time, extend a small codebase against a stable underlying goal not fully articulated in any single prompt. (A) each session begins with the most recent prompt only; (B) each begins by re-reading a frozen IR from session one. Measure semantic divergence of the final artifact from the goal. The hypothesis is that (A) drifts monotonically with session count while (B) drifts substantially less — establishing that `COMPREHENSION = Σ A(i)` decays unless externalised, and that the IR is the externalisation that holds it.

**Mechanical detectability of prompt-vs-IR drift.** Given session pairs with a frozen IR from session one and a new prompt in session two, measure detectability of drift by lexical overlap, named-entity divergence, and goal-statement comparison — before the implementation runs. The hypothesis is that drift is mechanically detectable in a substantial fraction of pairs, establishing intent drift as a measurable signal, not a subjective judgement, that a verifier can be required to surface as a precondition to any work.
