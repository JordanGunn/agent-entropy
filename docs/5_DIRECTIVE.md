# 5. Directive

*The context is everything the agent knows; the directive is what it is told to do with it.*

The four components assemble a context: what is wanted, what time has made of the work, the structure it acts against, and the world it is allowed to act in. Assembled, the context is complete and inert. It describes a situation in full and instructs nothing. A complete `C` does not say whether to summarise the work, extend it, audit it, document it, delete it, or leave it untouched. The context is the parameter set; something still has to say what action to project across it.

That something is the **directive**.

```text
GOAL = A(O, C)
```

`C` is the operand: the full, assembled context, everything the agent has to work from. `O` is the operator: the single action to perform over it. The goal is neither one alone. It is what the agent infers when it reads the directive against the context, so "write a book about `C`" resolves, through `A`, into the concrete objective of producing that book. The directive without the context is an empty verb; the context without the directive is an unread library.

> The **directive** is the action projected across the context. `GOAL = A(O, C)`: the directive resolved against the whole context.

This is the one input that is not part of `C`, and it earns that place by a clean test. Every component of the context decays: it must be held against re-inference, and that decay is one of the four entropies. The directive does not decay. It is supplied fresh on every invocation, never inferred from a fading store, so it carries no entropy and needs no chapter among the four. `C` is the standing context that rots; `O` is the fresh imperative applied to it.

Two boundaries keep the directive from blurring into its neighbours.

- It is not **comprehension**. Comprehension is what the user wants, the accumulated reading of the specification; the directive is the operation taken over it. Hold the context and the comprehension fixed, change only the directive, and the work changes completely. Comprehension is the noun; the directive is the verb.
- It is not **agency**. Agency is what the agent is *permitted* to do; the directive is what it is *told* to do. The directive proposes, agency disposes. "Write the change and deploy it" is a directive; "you may write but not deploy" is the agency that bounds it.

## A finite set of actions

The payoff of separating the operator from the operand is that the operator can be enumerated. With a comprehensive, fixed `C`, the directive is no longer an open-ended request reconstructed from scratch each turn. It is a selection from a small, named set: summarise, extend, refactor, audit, document, verify, persist. Each is a short, concrete instruction with a known shape, and each can be embodied in a repeatable, pre-defined sub-agent. The context supplies the information; the directive names which of a finite taxonomy of inferences to run over it. This is where pre-defined sub-agents earn their keep: not as bespoke prompts assembled by hand each time, but as a catalogue of operations, each one a directive with a fixed `C` beneath it.

## The run configuration

There is an exact precedent for this shape, and it is one every developer already uses. An IDE holds a codebase and offers a set of run configurations over it: run, compile, debug, test, lint, profile. The codebase is fixed; the configuration selects the action. Substitute the context for the codebase and the directive for the run configuration, and the model is the same: `GOAL = A(O, C)` is "run configuration `O` over codebase `C`."

The difference is the executor. The IDE runs its configuration through a deterministic toolchain; the agent runs its directive through `A`, the lossy interpreter, which never reproduces exactly. The aspiration of this whole paper is to narrow that gap. Fix `C` comprehensively, enumerate `O` precisely, and agentic work begins to behave like a run configuration: a named action over a fixed substrate, repeatable to the resolution its context pins down. The directive is the last piece of the model because it is the one that makes the rest runnable.

---

The paper opened on an unease with no name: work that passed every check and still felt wrong. The name is now in hand. The agent never acted on your codebase; it acted on a context it could not audit, and what it could not audit, it invented. The four components say what that context must hold, each on its own clock, and the directive says what to run over it; slop, the gauge of the second section, is what an entropic context leaves in the work when that holding is not done. The model did not get worse. The context it works from got harder to hold, and holding it, deliberately and against the entropy that always pulls it apart, is the whole of the discipline this paper argues for.
