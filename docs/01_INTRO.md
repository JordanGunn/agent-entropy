# I. The Uneasy Feeling

Something feels wrong, but you cannot say what.

The tests pass. The pull request looks reasonable. The agent confidently summarized what it did, and the summary sounds right. You merge it. Two weeks later, a bug surfaces in a part of the codebase you forgot was touched. You dig into it and find code that technically works but is structured in a way no experienced developer would have chosen. You cannot point to a rule it broke. You cannot cite a standard it violated. It just feels wrong, and that feeling has no name.

This is where most conversations about AI-generated code end: in a vague dissatisfaction that gets filed under "good enough" or quietly blamed on the model.

It should not end there.

The people most willing to praise AI coding tools are often the same ones most willing to be impressed by volume of the generated output and tests they will never examine. This is not a criticism of enthusiasm. It is an observation about what happens when the gap between what was asked and what was built goes unmeasured long enough to feel normal. As AI models become more capable, they become better at producing outputs that look right. As that happens, the bar for examining those outputs quietly drops. Hubris accumulates through proxied achievements, delivered by a system optimized to satisfy the person using it. Meanwhile, the precision of language used to instruct that system decreases at exactly the moment its value is highest.

The dominant narrative in online communities attributes this unease to the models themselves. The model is worse than it used to be. The model does not follow instructions. The model is being deliberately limited. These complaints are widespread, confidently stated, and largely unfalsifiable, because the people making them have no instrumentation on the variable most likely responsible: their own intent.

This paper argues that the model did not get worse. 
It argues that the problem is structural, measurable, and older than any particular AI release.

Particularly, it asserts two claims:

(1)  
> The closing of the gap between a fragmented idea and a working implementation has produced a structural overconfidence: users routinely believe they have communicated a concept clearly, well before they actually understand it clearly themselves. AI systems, optimised for agreement, do not surface this gap — they fill it silently, encoding assumptions the user did not know they were making.

(2)  
> More powerful AI models do not replace missing or miscommunicated intent; they amplify the problem by hiding it longer. Even modest amounts of ambiguity in user intent produce rapid, compounding degradation in output quality across successive sessions.
