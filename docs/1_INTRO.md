# 1. Introduction

*Work that passes every check and still feels wrong, and why the fault is not the model but the context it was given.*

The tests pass. The pull request is clean, the summary reads well, and the agent is sure it did what you asked. You merge. Weeks later a defect surfaces in a corner of the codebase you had forgotten was touched, in code that works and that no one who knew the system would have written. You cannot name the rule it broke, because it broke none. It is just wrong, and the wrongness has no name.

Most accounts of AI-generated work stop here, in a vague dissatisfaction filed under "good enough" or blamed on the model. The blame is the tell. The complaints are everywhere and confidently made: the model got worse, it stopped following instructions, it was quietly capped. They are also unfalsifiable, because the people making them hold no instrument on the variable most likely responsible: not the model, but what they handed it.

This paper argues that the model did not get worse. The problem is structural, measurable, and older than any model release. An agent never acts on your codebase. It acts on a context, and that context is something you assemble, mostly by accident, and never inspect. What the context fails to hold, the agent does not leave blank; it fills from the average of everything it has ever seen, confidently, and moves on. The agent never edits your code. It edits a context you never audit, and emits a diff.

A more capable model does not fix this. It hides it. Where a weak model under a poor context fails early and visibly, a strong one holds the disorder together and fails late, all at once, past the point where the order needed to diagnose it still exists. The better the model, the longer the gap between cause and symptom, and the larger the eventual repair. Capability buys delay, not correctness, and that is the more dangerous bargain.

The chapters that follow take this apart. The felt wrongness has a name and a surface you can measure it on, taken up next. Beneath that surface sits a context with nameable parts, each decaying in its own way when nothing holds it in place, and each holdable by an artifact built for the job, with a single directive run over the whole. The argument is not that the model should be trusted less. It is that the thing we hand it has been left unnamed, unmeasured, and unmaintained, and that all three are fixable.
