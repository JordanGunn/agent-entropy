# Agentic Approximation

Not every artifact in an agentic system should be made fully deterministic.
Some failures happen because information is too ambiguous and needs structure.
Other failures happen because information is over-structured, stripping away
the judgment, nuance, and contextual interpretation that make agentic
reasoning useful.

A useful rule is:
- Use schema where ambiguity creates failure.
- Use prose where judgment creates value.
- Use both when prose needs containment.

A schema gives the agent a stable target. It defines the expected shape of
information, constrains interpretation, and makes the result inspectable.
Prose gives the agent room to reason. It carries nuance, priority,
uncertainty, and intent in a way that may become awkward or misleading if
forced into rigid fields.

The relationship can be described informally as:
```
D(x...) ≈ A(S | P)
```

Where:

- `D   ` = Determinstic procedure
- `x...` = Variadic parameters
- `A   ` = Agentic process
- `S   ` = Schema
- `P   ` = Prose


This is not meant as literal mathematics. It is shorthand for a design principle:  
> The sum of prose and schema-constraints in an agentic process can approximate the output 
  of a parameterized deterministic procedure. 

The result may vary across runs, but if the agent is required to adhere to a schema, the 
variation is bounded enough to remain useful.

The schema does not replace the agent’s reasoning. It bounds it. The prose
does not make the output deterministic. It guides judgment. The approximation
error is the cost of preserving agentic flexibility.

That error is not always bad. Some artifacts benefit from subjectivity because
they are interpretive by nature. Others require tighter structure because
ambiguity would create downstream failure. The design question is not whether
to use prose or schema universally. The question is where each belongs.

A schema is most useful when the system needs:
- consistency
- validation
- inspection
- comparison
- persistence
- automation
- handoff between agents

Prose is most useful when the system needs:
- judgment
- nuance
- uncertainty
- context
- priority
- interpretation
- subjective tradeoffs

The strongest agentic artifacts often combine both. The schema provides
containment; prose provides meaning. The agent can reason over the prose, but
the schema gives the system a stable surface for storage, review, injection,
and downstream use.

In short:
- Schema gives the agent a stable target.
- Prose gives the agent useful subjectivity.
- Agents convert prose into action.
- Schemas make that conversion inspectable.

The goal is not to eliminate variance from agentic systems. The goal is to
decide where variance is acceptable, where it is dangerous, and where it can
be made useful by bounding it with structure.
