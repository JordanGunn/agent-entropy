# X. A Call to Instrument

There is a number worth sitting with before closing. According to Stack Overflow's 2025 Developer Survey *(Stack Overflow, 2025)*, 84% of developers
now use or plan to use AI tools in their development process -- yet trust in the accuracy of those tools has fallen to just
29%, the lowest recorded level since AI tool adoption began being tracked. Adoption is accelerating. Confidence is not. The
field is moving faster than its ability to evaluate what it is producing.

This is not a critique of the tools. It is a description of a gap -- between the rate at which code is being generated and
the rate at which the engineering discipline required to evaluate it is being developed. That gap is the subject of this paper. 
It is also, in a broader sense, the defining engineering challenge of this moment.

Software engineering has always transmitted its deepest knowledge through friction. Not through curricula. Schools do not teach
branching strategies, code review culture, or the particular discipline required to maintain infrastructure under production
conditions. These things are learned on the job, through the canonical ceremony of professional development: the PR rejected
with a comment that makes you realise you do not understand the system as well as you thought, the architecture review that
surfaces an assumption you did not know you were making, the incident postmortem that connects a decision made six months ago
to a failure that happened last night. The knowledge is in the resistance. The craft is transmitted through the experience of
being wrong in a recoverable way, under the supervision of someone who has been wrong in the same way before.

The agent removes that friction. And with it, the signal.

A developer who has never had a senior engineer push back on their connection pooling implementation does not know what they do
not know about connection pooling. An agent that produces connection pooling code that passes every test provides no signal at all.
The gap remains invisible -- not because the developer is incapable of learning, but because the mechanism that would have surfaced
the gap has been bypassed. The code works. The PR merges. The knowledge does not transfer.

This is compounding at scale in a way that has no historical precedent. The volume of code being produced has increased by orders of
magnitude. The barrier to producing it has been lowered to the point where significant architectural decisions are now being made by
developers who have not yet accumulated the experience to evaluate them. And the models producing this code are, as this paper has
argued at length, optimised to satisfy rather than interrogate -- which means the developer's existing assumptions, however incomplete,
are consistently reinforced rather than tested.

The more a developer asks an agent for code they do not fully understand, the higher the probability that their codebase becomes unmaintainably
complex in ways they cannot see. This is not a failure of intelligence. It is a failure of instrumentation. A developer who cannot see the
Distance score of their package graph, who has no controlled vocabulary to prevent semantic collapse, who has never had a prompt interrogated
before it reaches an implementation agent, is navigating by feel in a codebase that is growing faster than their ability to model it. They will
not notice the problem until it is expensive to fix. By that point, the agent will have already attributed the difficulty to model degradation,
and the developer will have agreed.

The interventions described in this paper are not sophisticated. They are metrics designed thirty years before the problem they are being applied
to existed. They are vocabulary lists. They are a single hook that asks one clarifying question before a session begins. Their modesty is intentional.
The goal is not to build a system so complex that it requires its own maintenance burden. The goal is to establish a measurement layer -- the minimum
instrumentation required to make the gap between intent and output visible before it becomes structural.

Every abstraction layer added without a measurement layer is debt. Every codebase grown without metric contracts is a codebase whose quality is a function
of the developer's attention rather than the system's constraints. Every agent session begun without intent interception is a session that starts from an
assumption of clarity that may not exist.

This is not an argument against AI-assisted development. It is an argument for taking it seriously enough to constrain it properly -- to treat the agent as
what it actually is: a powerful tool with no judgment, no memory, and no stake in the long-term health of what it builds. The discipline required to work
with such a tool safely is not less than the discipline required to work without it. It is more. And the field, at the moment of its greatest enthusiasm,
has not yet reckoned with that.

The metrics exist. The measurement surface exists. The ceremony of professional software development, stripped of its friction by tools that were built to
be helpful, still contains the accumulated wisdom of every system that was built wrong and had to be fixed by hand. That wisdom is worth preserving. It is
worth instrumenting. It is worth making computable enough that an agent can be held to it.

And so, we must ask ourselves:  
> Did the model actually get worse or did we stop asking it to be better?
