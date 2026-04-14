# IV. What Messy Actually Means

The feeling described in `Section I` has a name. **It has had one since 1999.**

A ***code smell*** is any characteristic of source code that hints at a deeper problem. The term was coined by **Kent Beck** and
popularised through his contributed chapter in Martin Fowler's *Refactoring: Improving the Design of Existing Code*. It is,
notably, a metaphor borrowed from the physical world. The idea being that bad code, like something left too long in the
refrigerator, *announces itself before you can quite explain why*. **You know it before you can prove it.**

*This is charming, and also a problem.*

## The metaphor has a cost

The olfactory metaphor is an honest admission that the thing being described *resists precise description*. Determining what
*is* and *is not* a code smell is subjective, and varies by language, developer, and development methodology. Fowler catalogued
**twenty-two** of them in 1999: *Feature Envy, Shotgun Surgery, Divergent Change, God Class,* and nineteen others. Each came with a
name evocative enough to recognise in a textbook and vague enough to argue about in a code review. Subsequent taxonomies expanded
the list. Researchers grouped the smells, regrouped them, and debated their boundaries. *Not being able to identify code smells is
one of the greatest barriers to refactoring.* Many developers do not detect design problems while they are still small and localised.
In practice, smells are often not sensed until **the problems are quite large, or have compounded with other problems and spread
through the codebase**.

This was already a problem when the only reader of the code was a human. **When the reader is an agent, it becomes a structural failure.**

*An agent has no nose.* It cannot detect the vague wrongness that an experienced developer senses when a class has drifted too far
from a single responsibility, or when a package boundary has been quietly violated one convenience import at a time. It can be
told what smells are, given a list, or instructed to look for them. But natural language descriptions of subjective symptoms,
delivered into a context window *already optimised for agreement*, are **not a reliable enforcement surface**. Smells, as currently
defined, are *a human interface*. They require experience to recognise, and **experience is precisely what the developers most reliant
on AI assistance have not yet accumulated**.

## What is needed is something computable

**What is needed is something computable.** Something that does not require an experienced nose, that produces the same result
regardless of who runs it, and that *cannot be argued away in a code review*. More importantly, something that exists ***outside the
agent's control surface entirely***. A metric the agent computes for itself is subject to the same incentive structure as every
other output it produces -- if approval is the goal, *the score will be massaged, rounded, or quietly omitted*. A metric computed
by **external tooling and reported back** is something else: a *fixed referent the agent cannot reshape*, the conversational equivalent
of running into a wall. This is the architectural inversion of the sycophancy problem described in Section II. **Agreement is cheap;
arithmetic is not.**

The research community has been building these instruments for decades. They have simply not been applied to the agentic context.
What follows is a survey of the candidate measurements, organised loosely by the property they capture.

## Architectural Health

*Robert C. Martin* formalised what may be the most directly useful suite. His **Instability** (I) and **Abstractness** (A) metrics,
combined into the **Distance from the Main Sequence** (D'), place every package in a codebase onto a two-dimensional plane with
two clearly defined failure zones:

1. **The Zone of Pain**: stable and concrete, impossible to change, everything depends on it.
2. **The Zone of Uselessness**: abstract and unstable, nobody depends on it, the abstraction serves no one.

A package's distance from the healthy diagonal between these zones is a single number, computed directly from the dependency graph,
**requiring no subjective interpretation of the result** *(Martin, R.C., 1994; 2002)*. The choice of what counts as a *package* and
which edges count as *dependencies* remains a question for the toolchain, but once those boundaries are fixed the computation is
deterministic and the thresholds are well established.

A precursor to Martin's work, **Henry and Kafura's Information Flow** complexity (1981), captured the same intuition with cruder
vocabulary: the **fan-in** of a procedure (how many other procedures depend on it) and the **fan-out** (how many it depends on),
combined into a complexity score. Martin's Instability metric is a normalised refinement of `fan-out / (fan-in + fan-out)`. The
lineage matters because it shows the underlying observation -- that coupling is measurable from structure alone -- has been
settled science for more than four decades *(Henry, S. & Kafura, D., 1981)*.

## Class and Module Cohesion

*Chidamber and Kemerer* (1994) produced a suite of six object-oriented metrics that operationalise properties most developers
can only describe impressionistically:

* **Weighted Methods per Class** (WMC) -- the sum of complexities of methods, a proxy for class size and testing burden.
* **Depth of Inheritance Tree** (DIT) -- distance from the root of the inheritance hierarchy.
* **Number of Children** (NOC) -- direct subclasses, a measure of reuse and downstream coupling.
* **Coupling Between Object Classes** (CBO) -- the number of classes a class is coupled to, mapping closely to Martin's afferent
  and efferent coupling at finer grain.
* **Response For a Class** (RFC) -- the size of the response set, a proxy for the testing surface area of a single class.
* **Lack of Cohesion of Methods** (LCOM) -- the degree to which methods of a class operate on disjoint subsets of fields.

LCOM in particular addresses the question "*does this class have a single identity?*" in arithmetic terms. A high LCOM score does
not suggest that the class might violate the Single Responsibility Principle. **It measures the degree to which it does**
*(Chidamber & Kemerer, 1994)*. The original LCOM has known methodological issues -- it can produce negative values, it does not
normalise across class sizes, and at least four named variants (LCOM2 through LCOM*) exist to address its shortcomings. Any
production application should pick a variant and commit to it, but the underlying instrument is sound and language-agnostic.

## Method-Level Complexity

*Thomas McCabe* gave the field **Cyclomatic Complexity** (CCX) in 1976. CCX provides a count of independent paths through a piece
of code that translates directly into the minimum number of tests required to cover it. McCabe's original recommendation was that
CCX above ten indicates code that should be restructured. Subsequent practitioner consensus, codified in SEI and NIST guidance, has
established that CCX above fifty indicates code that is effectively untestable in practice -- not hard to test, but combinatorially
infeasible to cover. That is not a smell. It is a measurement *(McCabe, T., 1976)*.

A close cousin, **NPATH complexity** *(Nejmeh, B., 1988)*, counts acyclic execution paths rather than independent paths and tends
to flag the same kinds of problems with stricter sensitivity. Both belong to the same family.

More recently, *G. Ann Campbell* at SonarSource introduced **Cognitive Complexity**, which addresses something McCabe's metric
misses: that nesting is not linear. Three sequential conditionals are not as hard to read as one conditional nested inside a loop
nested inside an exception handler. Cognitive Complexity penalises nesting incrementally, producing scores that correlate far more
closely with the subjective experience of reading difficult code than any prior metric. **It is the closest the field has come to
formalising the feeling** *(Campbell, G.A., 2018)*.

The oldest member of the family is *Maurice Halstead's* **Software Science** (1977), which counts unique operators and operands and
derives composite measures of program length, vocabulary, volume, difficulty, and effort. Halstead's derived measures have been
criticised for weak empirical validation -- his "estimated bug count" formula, in particular, does not survive contact with modern
data -- but the underlying counts are computable from any AST and remain useful inputs to other metrics *(Halstead, M., 1977)*.

## Decay Over Time

The metrics above describe a snapshot. The most powerful smell detectors operate on the dimension that snapshots ignore: time.

**Change coupling** (also called *temporal* or *logical* coupling), formalised by *Gall, Hajek, and Jazayeri* (1998) and developed
extensively by *Adam Tornhill* in *Your Code as a Crime Scene* (2015), measures which files consistently change together in commits.
It reveals dependencies that no static analysis can see: files that share no imports, no inheritance, no namespace, but break together
with statistical regularity. The same instrument applied in the negative -- as discussed in Section III -- reveals decoupling between
documentation artifacts and the source files they nominally describe.

**Hotspot analysis**, also from Tornhill, multiplies code complexity by change frequency to identify the files most at risk of
carrying defects. The intuition is straightforward: complex code that never changes is fine, simple code that changes often is
fine, complex code that changes often is where the bugs live. The metric is computable from git history and any of the complexity
measures above, and it is the single most evidence-rich signal in the literature for predicting where defects will occur
*(Nagappan, N. & Ball, T., 2005; Tornhill, A., 2015)*.

## Structural Invariants

Some properties are not gradient measurements but binary invariants. These are the easiest for an agent to violate and the easiest
to enforce externally.

**Dependency cycles** are unambiguous. A cycle in the import graph of a strongly typed system is a structural error; in a weakly
typed system, it is an architectural one. Cycle detection is computable in linear time with Tarjan's algorithm *(Tarjan, R., 1972)*
and produces output that requires no interpretation: there is a cycle, or there is not.

**Dead code and unreferenced symbols** are computable from cross-reference analysis. A symbol with no callers, a module with no
importers, an export that is never imported -- each of these is a defect or a deletion candidate, and each is detectable without
any subjective judgement. The category is folklore-old and tooled into nearly every linter, but it is rarely run as a structural
check at the cadence an agentic workflow demands.

## Vocabulary, Not Metric

Finally, there is **Connascence**. Originally described by *Meilir Page-Jones* (1996) and later formalised by *Jim Weirich* (2009).
Where the metrics above measure properties of components or relationships at a coarse grain, Connascence is a *taxonomy* of the
relationships between components. Two components are connascent if changing one requires changing the other. The taxonomy runs
from weak to strong: Connascence of Name at the bottom, through Type, Meaning, Position, Algorithm, Execution Order, Timing, Value,
and Identity at the top.

Connascence is a different kind of tool from the metrics above. It is not a scalar score; it is a categorical classification applied
via static analysis, and there is no widely accepted algorithm that automatically decides "*this is Connascence of Position*" -- the
application is partially manual, partially tooled. But what Connascence provides that the scalar metrics cannot is **vocabulary**.
"*This is Connascence of Position*" is a precise, unambiguous, actionable statement about a specific kind of coupling. It tells you
what kind of problem you have, how serious it is relative to other kinds, and what class of solution applies. It is the smell
taxonomy done again, **but this time with enough precision to survive a context window boundary** *(Page-Jones, M., 1996; Weirich, J., 2009)*.

## What Smells Cannot Be Measured

Honesty requires acknowledging that not all of Fowler's catalogue translates. Feature Envy is partially measurable through
cross-class field access counts. Shotgun Surgery is measurable through change coupling -- the same instrument used for documentation
rot in Section III. Divergent Change shares the same machinery. God Class is detectable through combined WMC, CBO, and LCOM
thresholds. But Speculative Generality, Mysterious Name, Comments-as-Deodorant, and several others resist computation. They require
human judgement of intent, not structural analysis of form.

This is acceptable. The claim is not that every smell can be metricised; it is that *the computable subset is large enough to do
the work the agent needs done*. The smells that require taste will continue to require taste. The smells that can be reduced to
arithmetic should be, and an agent should be held to them by tooling that exists outside its own conversation.

## The Defensible Subset

Of the inventory above, a smaller set survives every constraint that matters for agentic application: deterministic computation,
established literature, clear thresholds, language-agnostic semantics, and -- most importantly -- computability from primitives
that can be run as external tooling against the codebase without trusting the agent's account of its own work.

| Metric | Captures | Source |
|---|---|---|
| **Distance from the Main Sequence (D')** | Architectural rot at the package level | Martin, 1994 |
| **Coupling Between Object Classes (CBO)** | Over-coupling at the class level | Chidamber & Kemerer, 1994 |
| **Cyclomatic Complexity (CCX)** | Path coverage burden at the method level | McCabe, 1976 |
| **Cognitive Complexity** | Subjective reading difficulty at the method level | Campbell, 2018 |
| **Change coupling and hotspot density** | Decay and defect risk over time | Gall et al., 1998; Tornhill, 2015 |
| **Dependency cycles** | Structural invariant violations | Tarjan, 1972 |
| **Dead code and unreferenced symbols** | Decay through accumulation | (folklore; widely tooled) |
| **Connascence taxonomy** | Vocabulary for the relationships above | Page-Jones, 1996; Weirich, 2009 |

These are the instruments that earn their place. They are computable from the same primitives -- AST traversal, dependency graph
analysis, git history, cross-reference indexing -- that have been available to the field for decades. What has been missing is not
the measurements. It is the scaffolding to apply them at the cadence and granularity an agentic workflow demands, by tools that
exist outside the agent's control surface and report back in formats the agent cannot quietly ignore.

**Taken together, these metrics form a shared language for code quality that requires no experience to apply and no subjectivity
to interpret.** A developer who cannot yet feel when code is wrong can still read a Distance score, an LCOM value, a Cognitive
Complexity threshold. An agent can be required to compute them, check them against defined limits, and refuse to proceed when they
are exceeded -- *provided the computation happens somewhere it cannot quietly skip*. **The smell becomes a measurement. The
measurement becomes a contract. *The contract does not rot.***

## None of this is new

The metrics in this section **predate the smartphones used to praise the AI tools that ignore them**:

* McCabe published Cyclomatic Complexity in 1976 -- three years before the first commercial spreadsheet.
* Halstead followed with Software Science in 1977.
* Henry and Kafura formalised information flow complexity in 1981.
* Parnas described software aging in 1994. Martin formalised architectural rot in the same year. Chidamber and Kemerer published
  the object-oriented metrics suite in the same year.
* Gall, Hajek, and Jazayeri described change coupling in 1998.
* The entire catalogue predates the first AI coding assistant by **more than four decades**.

This body of work has been sitting in conference proceedings and textbooks for *forty years* -- **precise and computable and largely
unread** -- waiting to be applied to a problem that did not yet exist when it was written. The field spent forty years building
instruments capable of measuring code quality with mathematical rigour. Then it built systems capable of producing code at
industrial scale. **Then it connected the two with a markdown file.**

---

## Experiments

**Architectural clustering of AI-generated code.** Compute Martin's Distance from the Main Sequence, Chidamber & Kemerer's CBO,
and McCabe's CCX across a sample of AI-generated codebases (e.g. agent-completed open-source issues, agent-authored greenfield
projects) and a matched sample of equivalent human-written codebases. Plot each on the Abstractness/Instability plane. The
directional hypothesis is that AI-generated code clusters closer to the **Zone of Pain** -- high stability, low abstractness --
because LLMs default to literal implementations and tend to over-couple to existing structure rather than introducing new
abstractions. A null result would falsify the structural-overconfidence claim from Section I as it applies to architecture; a
confirmed result establishes a measurable signature for agentic output that no amount of model improvement can hide as long as
the metrics are computed externally.

**Metric-as-contract for agent judgement.** Present an agent with two functionally equivalent code samples, one of which violates
several metric thresholds and one of which does not. Ask the agent to choose the better implementation. Run three conditions:
(a) baseline -- no metrics provided; (b) treatment -- computed metric scores included in the prompt as external tool observations;
(c) sycophancy probe -- as (b), but with the user explicitly stating a preference for the metric-violating sample. The hypothesis
is that condition (b) improves selection accuracy over (a), and that condition (c) holds firm only when the metrics are presented
as external tool output rather than as the agent's own computation. This experiment directly tests the load-bearing claim of the
section: that external metrics function as constraints the agent cannot agree its way around.

**Survival of contracts under documentation drift.** Pair the synthetic drift study from Section III with metric thresholds.
Across thirty agent sessions on an evolving codebase, measure (a) drift between `CLAUDE.md` and code structure (the Section III
metric), and (b) drift in package-level D', class-level CBO, and method-level Cognitive Complexity over the same sessions. The
hypothesis is that prose documentation drifts monotonically while metric thresholds, when externally enforced, do not -- because
the contract has a numeric witness and the prose does not. If both drift, the intervention is insufficient. If only the prose
drifts, the intervention is justified.
