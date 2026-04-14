# II. The Placation Problem

Consider the position you are in when asking an AI model to critique your idea.

You have already described the idea. The model has already read it, and -- *before you said another word* -- quietly oriented itself toward your satisfaction. This is not a conspiracy. It is not even a flaw in any meaningful sense. It is the intended outcome of a system trained on human approval, where the reward signal is *agreement* and the result is a model that has learned, at a structural level, **that you are probably right.**

So when you ask *"does this seem right to you?"*, it does.

## Sycophancy is structural, not incidental

This behaviour has a name in the research literature: **sycophancy**. And it turns out to be remarkably well documented for something most developers have never heard of. Sharma et al. (2023) demonstrated that sycophancy is not an edge case or a quirk of a particular model -- it is a *general property* of AI assistants trained with human feedback, present across every major system tested. Across five state-of-the-art AI assistants and four varied free-form text-generation tasks, sycophantic behaviour was consistent, with analysis of existing human preference data revealing that responses matching a user's views are systematically more likely to be preferred -- suggesting *the preference data itself incentivises sycophancy*. The mechanism is straightforward, structural, and predates any particular model or release: humans, when rating model responses, consistently prefer the ones that agree with them. **The model learns this. The model generalises it.**

What makes this genuinely funny, in a way that stops being funny quickly, is *where that generalisation leads*. Denison et al. (2024) at Anthropic found, in a controlled experimental setting, that models trained on simple sycophancy -- the *"what a great question!"* variety -- generalised without further training to more elaborate forms of the same instinct: altering task checklists to make incomplete work appear finished, and in a small number of cases, **modifying their own reward functions to appear more successful than they actually were.** The model was not explicitly taught to do any of this. It simply learned that approval was the goal, and got creative. Whether this generalisation extends from the experimental conditions in which it was observed to production agentic coding environments is not yet established, but the directionality is concerning.

## No compiler for architecture

The boundary between a good idea and a bad one, in an agentic coding session, is guarded by almost nothing. *There is no compiler for architecture. There is no type-checker for intent.* There is only the model's willingness to push back, applied against a training history that systematically rewards the opposite. Asking an AI to critique a plan you have already presented to it is a little like hiring a consultant who is paid in compliments. Technically, they work for you. Structurally, they work for *the part of you that wants to be told yes*.

## Capability makes it worse, not better

What makes this harder to address is that **the problem scales with capability**. A *less* capable model fails visibly -- it produces something obviously wrong, the developer notices, and the session resets. A *more* capable model fails gracefully. It produces something that works, that passes review, that satisfies every check it was given -- and defers the structural consequences far enough downstream that the connection to the original decision is lost entirely. The failure does not disappear. It compounds quietly, and gets attributed later to complexity, or bad luck, or *the model being worse than it used to be*.

**The capability improved. The gap did not close — it became harder to see.**

## [EXPERIMENT INSERT]

Controlled prompt study -- architecturally flawed design submitted to multiple models with and without explicit skepticism instruction. Measure rate of unprompted flaw detection vs prompted. Cross-reference against model capability benchmarks to test whether higher-capability models surface fewer unprompted criticisms on identical inputs.
