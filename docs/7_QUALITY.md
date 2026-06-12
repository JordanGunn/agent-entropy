# IX. What Messy Actually Means

The feeling described in the opening section has names. It has had them since 1999. The taxonomy is incomplete.

A *code smell* is any characteristic of source code that hints at a deeper problem. The term was coined by Kent Beck and popularised through his contributed chapter in Martin Fowler's *Refactoring: Improving the Design of Existing Code*. It is, notably, a metaphor borrowed from the physical world. The idea being that bad code, like something left too long in the refrigerator, announces itself before you can quite explain why. You know it before you can prove it.

This is charming, and also a problem.

## The metaphor has a cost

The olfactory metaphor is an honest admission that the thing being described resists precise description. Determining what is and is not a code smell is subjective, and varies by language, developer, and development methodology. Fowler catalogued twenty-two of them in 1999: *Feature Envy, Shotgun Surgery, Divergent Change, God Class,* and nineteen others. Each came with a name evocative enough to recognise in a textbook and vague enough to argue about in a code review. Subsequent taxonomies expanded the list. Researchers grouped the smells, regrouped them, and debated their boundaries. Not being able to identify code smells is one of the greatest barriers to refactoring. Many developers do not detect design problems while they are still small and localised. In practice, smells are often not sensed until the problems are quite large, or have compounded with other problems and spread through the codebase.

This was already a problem when the only reader of the code was a human. When the reader is an agent, it becomes a structural failure.

An agent has no nose. It cannot detect the vague wrongness that an experienced developer senses when a class has drifted too far from a single responsibility, or when a package boundary has been quietly violated one convenience import at a time. It can be told what smells are, given a list, or instructed to look for them. But natural language descriptions of subjective symptoms, delivered into a context window already optimised for agreement, are not a reliable enforcement surface. Smells, as currently defined, are a human interface. They require experience to recognise, and experience is precisely what the developers most reliant on AI assistance have not yet accumulated.

## What is needed is something computable

What is needed is something computable. Something that does not require an experienced nose, that produces the same result regardless of who runs it, and that cannot be argued away in a code review. More importantly, something that exists outside the agent's control surface entirely. A metric the agent computes for itself is subject to the same incentive structure as every other output it produces: if approval is the goal, the score will be massaged, rounded, or quietly omitted. A metric computed by external tooling and reported back is something else: a fixed referent the agent cannot reshape, the conversational equivalent of running into a wall. This is the architectural inversion of the sycophancy problem described in the four-entropies section. Agreement is cheap; arithmetic is not.

The research community has been building these instruments for decades. They have simply not been applied to the agentic context. What follows is a survey of the candidate measurements, organised loosely by the property they capture. One observation is worth holding throughout: the classical work is a survey of structural instruments. It measures the shape of dependency graphs, the cohesion of classes, the complexity of methods, the drift between artifacts over time. These are properties of structure. They are necessary, well-established, and (for the most part) predate the failure modes this paper is concerned with by several decades.

## Quality has two surfaces

What the rest of this chapter measures is not a fifth entropy. It is the surface the other four are read from. The intent-gap, trajectory, expression, and agency sections describe the four entropies of the work: its comprehension, its trajectory, its structure, and its agency. This chapter describes the **quality** of the artifact they leave behind, made measurable, and the **slop** that is quality's absence.

Quality has exactly two surfaces, and slop is their inverse:

```text
QUALITY = STRUCTURE + VOCABULARY     the two surfaces a tool can read off the artifact
SLOP    ∝ 1 / QUALITY                its inverse: the visible residue of accumulated entropy
```

Structure is the shape of the work: its dependencies, its boundaries, whether it can still be navigated as one coherent thing. Vocabulary is the language the work is written in: its identifiers, its naming, whether a concept is named once or five ways. The two are independent: a codebase can be clean on one surface and rotten on the other. Together they are everything an external tool can read off the artifact without trusting the agent's account of its own work.

Slop is the colloquial name for what those two surfaces look like once they decay, the vague wrongness of the opening section, given a definition at last: the visible inverse of measured quality. The constant of proportionality is unknown; the direction is not. As quality falls, slop rises.

## Slop is inherited, not produced

The second line carries the paper's thesis into the artifact. Slop is not something the model manufactures under stable conditions. It is the visible residue of entropy that was already in the environment when the artifact was made.

The four entropies rise co-variantly, and they accumulate in the context the agent works from: a comprehension polluted across turns, a trajectory with no lineage, a structure the agent cannot see, and an agency the agent only inferred. Quality is the surface they fossilise on; slop is the magnitude of the fossil. A degraded context does not announce itself in the diff. It settles into a dependency graph drifting toward the Zone of Pain, a vocabulary fragmenting into five words for one idea, or a compatibility shim guarding a consumer that does not exist: the four entropies, pressed into a surface an external tool can read.

This is the opening section's claim made measurable. The model did not get worse; the context it works from got poorer, and slop is how a poorer context surfaces in the work. So slop is not a defect to be reviewed away case by case. It is a gauge of accumulated entropy, and the only way to move the gauge is to lower what it measures.

The reframe is testable. If slop is inherited rather than produced, the same model on a fixed, low-entropy context (the frozen `C` of the whole-context section) should leave measurably less of it than on a polluted one: slop should track the environment, not the model release. Compute the two surfaces across matched artifacts that differ only in the entropy of the context that produced them, and the prediction is a clean gradient: quality falling and slop rising as environmental entropy climbs, the model held fixed.

Quality, then, is not a fifth entropy. It is the surface the other four are read from, and slop is what you read off it. What remains in this chapter is the instrumentation: first the structural surface, which the field has measured for forty years, then the vocabulary surface, which it has not.

## Architectural Health

*Robert C. Martin* formalised what may be the most directly useful suite. His **Instability** (I) and **Abstractness** (A) metrics, combined into the **Distance from the Main Sequence** (D'), place every package in a codebase onto a two-dimensional plane with two clearly defined failure zones:

1. **The Zone of Pain**: stable and concrete, impossible to change, everything depends on it.
2. **The Zone of Uselessness**: abstract and unstable, nobody depends on it, the abstraction serves no one.

A package's distance from the healthy diagonal between these zones is a single number, computed directly from the dependency graph, requiring no subjective interpretation of the result *(Martin, R.C., 1994; 2002)*. The choice of what counts as a package and which edges count as dependencies remains a question for the toolchain, but once those boundaries are fixed the computation is deterministic and the thresholds are well established.

A precursor to Martin's work, **Henry and Kafura's Information Flow** complexity (1981), captured the same intuition with cruder vocabulary: the **fan-in** of a procedure (how many other procedures depend on it) and the **fan-out** (how many it depends on), combined into a complexity score. Martin's Instability metric is a normalised refinement of `fan-out / (fan-in + fan-out)`. The lineage matters because it shows the underlying observation, that coupling is measurable from structure alone, has been settled science for more than four decades *(Henry, S. & Kafura, D., 1981)*.

## Class and Module Cohesion

*Chidamber and Kemerer* (1994) produced a suite of six object-oriented metrics that operationalise properties most developers can only describe impressionistically:

* **Weighted Methods per Class** (WMC): the sum of complexities of methods, a proxy for class size and testing burden.
* **Depth of Inheritance Tree** (DIT): distance from the root of the inheritance hierarchy.
* **Number of Children** (NOC): direct subclasses, a measure of reuse and downstream coupling.
* **Coupling Between Object Classes** (CBO): the number of classes a class is coupled to, mapping closely to Martin's afferent and efferent coupling at finer grain.
* **Response For a Class** (RFC): the size of the response set, a proxy for the testing surface area of a single class.
* **Lack of Cohesion of Methods** (LCOM): the degree to which methods of a class operate on disjoint subsets of fields.

LCOM in particular addresses the question "does this class have a single identity?" in arithmetic terms. A high LCOM score does not suggest that the class might violate the Single Responsibility Principle. It measures the degree to which it does *(Chidamber & Kemerer, 1994)*. The original LCOM has known methodological issues: it can produce negative values, it does not normalise across class sizes, and at least four named variants (LCOM2 through LCOM*) exist to address its shortcomings. Any production application should pick a variant and commit to it, but the underlying instrument is sound and language-agnostic.

## Method-Level Complexity

*Thomas McCabe* gave the field **Cyclomatic Complexity** (CCX) in 1976. CCX provides a count of independent paths through a piece of code that translates directly into the minimum number of tests required to cover it. McCabe's original recommendation was that CCX above ten indicates code that should be restructured. Subsequent practitioner consensus, codified in SEI and NIST guidance, has established that CCX above fifty indicates code that is effectively untestable in practice: not hard to test, but combinatorially infeasible to cover. That is not a smell. It is a measurement *(McCabe, T., 1976)*.

A close cousin, **NPATH complexity** *(Nejmeh, B., 1988)*, counts acyclic execution paths rather than independent paths and tends to flag the same kinds of problems with stricter sensitivity. Both belong to the same family.

More recently, *G. Ann Campbell* at SonarSource introduced **Cognitive Complexity**, which addresses something McCabe's metric misses: that nesting is not linear. Three sequential conditionals are not as hard to read as one conditional nested inside a loop nested inside an exception handler. Cognitive Complexity penalises nesting incrementally; it is designed to track the subjective experience of reading difficult code more closely than path-counting does, and SonarSource presents it as a better reflection of understandability than prior metrics. It is the closest the field has come to formalising the feeling *(Campbell, G.A., 2018)*.

The oldest member of the family is *Maurice Halstead's* **Software Science** (1977), which counts unique operators and operands and derives composite measures of program length, vocabulary, volume, difficulty, and effort. Halstead's derived measures have been criticised for weak empirical validation (his "estimated bug count" formula, in particular, does not survive contact with modern data) but the underlying counts are computable from any AST and remain useful inputs to other metrics *(Halstead, M., 1977)*.

## Decay Over Time

The metrics above describe a snapshot. The most powerful smell detectors operate on the dimension that snapshots ignore: time.

**Change coupling** (also called *temporal* or *logical* coupling), formalised by *Gall, Hajek, and Jazayeri* (1998) and developed extensively by *Adam Tornhill* in *Your Code as a Crime Scene* (2015), measures which files consistently change together in commits. It reveals dependencies that no static analysis can see: files that share no imports, no inheritance, no namespace, but break together with statistical regularity. The same instrument applied in the negative (as discussed in the trajectory section) reveals decoupling between documentation artifacts and the source files they nominally describe.

**Hotspot analysis**, also from Tornhill, multiplies code complexity by change frequency to identify the files most at risk of carrying defects. The intuition is straightforward: complex code that never changes is fine, simple code that changes often is fine, complex code that changes often is where the bugs live. The metric is computable from git history and any of the complexity measures above, and it is one of the most consistently validated signals in the literature for predicting where defects will occur *(Nagappan, N. & Ball, T., 2005; Tornhill, A., 2015)*.

## Structural Invariants

Some properties are not gradient measurements but binary invariants. These are the easiest for an agent to violate and the easiest to enforce externally.

**Dependency cycles** are unambiguous. A cycle in the import graph of a strongly typed system is a structural error; in a weakly typed system, it is an architectural one. Cycle detection is computable in linear time with Tarjan's algorithm *(Tarjan, R., 1972)* and produces output that requires no interpretation: there is a cycle, or there is not.

**Dead code and unreferenced symbols** are computable from cross-reference analysis. A symbol with no callers, a module with no importers, an export that is never imported: each of these is a defect or a deletion candidate, and each is detectable without any subjective judgement. The category is folklore-old and tooled into nearly every linter, but it is rarely run as a structural check at the cadence an agentic workflow demands.

## Vocabulary, Not Metric

Finally, there is **Connascence**. Originally described by *Meilir Page-Jones* (1996) and later formalised by *Jim Weirich* (2009). Where the metrics above measure properties of components or relationships at a coarse grain, Connascence is a *taxonomy* of the relationships between components. Two components are connascent if changing one requires changing the other. The taxonomy runs from weak to strong: Connascence of Name at the bottom, through Type, Meaning, Position, Algorithm, Execution Order, Timing, Value, and Identity at the top.

Connascence is a different kind of tool from the metrics above. It is not a scalar score; it is a categorical classification applied via static analysis, and there is no widely accepted algorithm that automatically decides "*this is Connascence of Position*": the application is partially manual, partially tooled. But what Connascence provides that the scalar metrics cannot is vocabulary. "This is Connascence of Position" is a precise, unambiguous, actionable statement about a specific kind of coupling. It tells you what kind of problem you have, how serious it is relative to other kinds, and what class of solution applies. It is the smell taxonomy done again, but this time with enough precision to survive a context window boundary *(Page-Jones, M., 1996; Weirich, J., 2009)*.

## The Defensible Structural Subset

Of the inventory above, a smaller set survives every constraint that matters for agentic application: deterministic computation, established literature, clear thresholds, language-agnostic semantics, and, most importantly, computability from primitives that can be run as external tooling against the codebase without trusting the agent's account of its own work.

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

These are the structural instruments that earn their place. They are computable from the same primitives (AST traversal, dependency graph analysis, git history, cross-reference indexing) that have been available to the field for decades. What has been missing is not the measurements. It is the scaffolding to apply them at the cadence and granularity an agentic workflow demands, by tools that exist outside the agent's control surface and report back in formats the agent cannot quietly ignore.

Taken together, these structural metrics form a shared language for code quality that requires no experience to apply and no subjectivity to interpret. A developer who cannot yet feel when code is wrong can still read a Distance score, an LCOM value, a Cognitive Complexity threshold. An agent can be required to compute them, check them against defined limits, and refuse to proceed when they are exceeded, provided the computation happens somewhere it cannot quietly skip. The smell becomes a measurement. The measurement becomes a contract. The contract does not rot.

## What the structural instruments cannot see

The structural instruments above measure properties of the form code takes once it is written. They do not measure properties of the language in which the code expresses itself. Identifier choice, naming consistency, vocabulary discipline: these were classically the province of style guides, code reviews, and seasoned taste. The literature treated them as matters of preference, addressed by Fowler under the smell name **Mysterious Name** and by every style guide ever published, but never seriously operationalised.

That treatment was correct for its era. When the writer of the code was a person, the reviewer was a person, and the maintainer was a person, the lexical surface was a human convenience: useful, but not load-bearing. A messy name in a hand-written codebase produced a moment of friction in the next review and a small loss of confidence in the author's craft. The damage stopped there.

When the writer is an agent, the lexical surface stops being a human convenience and becomes diagnostic infrastructure. The agent does not write in a vacuum. It writes from a context window: a partial, recent, lossy view of the codebase, augmented by the prompt, mediated by training. Every identifier the agent emits is a function of that context window's contents at the moment of emission. If the names the agent produces are systematically heterogeneous, disorganised, and verbose, that pattern is a fossilised record of the reasoning surface that produced it.

This is the load-bearing inversion. The lexical signal is no longer evidence of an author's taste. It is evidence of an author's context-window state. Bad lexicon does not prove a polluted context window, but stable, repeated, distinctive lexical anti-patterns across an evolving codebase are a plausible signature of one. The classical smell-naming method, borrowed from Beck, applies cleanly to this signal: repeated abnormalities in identifiers can be named, taxonomised, and measured.

This measurable degradation of the lexical surface is the vocabulary surface of quality, and the one the field has, by accident, instrumented most literally. Where structure must be inferred from graphs and the shape of the work, a lexicon's entropy is computable directly from the identifiers it emits. Together with the structural surface above, it completes `QUALITY = STRUCTURE + VOCABULARY`: not a component the agent must be given, but the residue you read off the output to see which entropy ran high.

## A Lexical Taxonomy

The taxonomy below is the result of treating the lexical surface of agent-written code as a measurable artifact. Each entry names a distinct, observable identifier pattern, marks its antecedent where a genuine one exists (and flags the coinages that are new here) and is detected by a reproducible measurement. The catalog has been derived across multiple codebases at multiple scales; the smells listed are the ones that recurred stably.

| Smell | What it names | Prior art |
|---|---|---|
| **Stutter** | Identifiers repeating tokens from the enclosing scope (`UserService.user_update_user_profile`) | Deissenboeck & Pizka, 2006 |
| **Verbosity** | Over-tokenised names that should be expressed as a namespace or class | Lawrie, Feild & Binkley, 2006 |
| **Hammers** | Catchall vocabulary (`Manager`, `Helper`, `Util`, `Spec`) used in place of a real noun | Deissenboeck & Pizka, 2006 |
| **Sprawl** | Closed alphabets sprawling across naming templates: an undeclared type | Caprile & Tonella, 2000 |
| **Cowards** | Disambiguator suffixes (`_v2`, `_old`, `_new`, `_local`) marking a codebase's failure to commit | named here |
| **Parrots** | Identifier suffixes redundantly restating the type annotation (`_dict`, `_path`) | named here |
| **Imposters** | Parameters camouflaged as ordinary dependencies: the missing receiver of a class | named here; cf. Move Method |
| **Strangers** | Sibling functions sharing an input but refusing to align by naming convention | named here; cf. Extract Class |
| **Tenants** | A single file holding multiple cohesive units, identifiable from receiver concentration | named here; cf. Extract Class |

Each smell is detectable from identifier strings and AST scope. Each has a configurable threshold. Each is reproducible: identical source produces identical output. Each names a manifestation that no classical structural metric surfaces, because the structural metrics measure shape, not language.

The catalog above is the lexical complement to the classical structural one. They are not in competition. A codebase passing every Martin / CK / McCabe threshold can still exhibit every entry in this table; the structural and lexical surfaces are independent measurement planes.

## Scientific Methods of Evaluation

The lexical taxonomy above is not produced by intuition. It is produced by a small set of measurement primitives, each grounded in literature *older than the problem to which they are now being applied*.

**Distributional shape: Zipf, applied to identifier corpora.** Identifier corpora follow Zipf's law *(Zipf, 1949; Pierret & Poshyvanyk, 2009)*: the rank-frequency distribution is a power law with a heavy tail. A single scalar (the hapax-legomena ratio, the fraction of tokens appearing exactly once) quantifies the long-tail noise floor. On the single codebase the taxonomy was developed against, the ratio held nearly constant across a major refactor: 0.373 then 0.392 (78 files / 475 distinct tokens, then 114 / 513). That shows only that the measure is stable under churn within one corpus; n = 1 cannot set a human baseline, and none is claimed from it. That the ratio is a structural regularity of identifier corpora at all is the finding of the multi-corpus work: Zipfian identifier distributions across 9 Java systems totalling 30M LOC *(Pierret & Poshyvanyk, 2009)* and cross-system identifier categories across 50 C/C++ systems *(Newman et al., 2017)*, which is where any human band would have to come from.

**Universal noise: Newman's 14.** Newman et al. (2017) catalogued 480K unique identifiers across 50 open-source C/C++ systems totalling 80–2400 KLOC each. They asked which identifiers appeared in every system studied, and found exactly 14: `a, length, id, pos, start, next, str, key, f, x, index, p, left, result`. These are cross-corpus universal noise from identifier streams, distinct from generic English stoplists, which silence the catchall vocabulary (`Manager`, `Helper`, `Service`) that the lexical taxonomy is specifically built to surface. The Newman 14 are filtered as a methodological baseline; the catchall vocabulary is measured.

**Three-plane orthogonal analysis.** Token-level diagnostics are computed across three independent distributional axes:

- **Association density**: which tokens co-occur in clusters (Formal Concept Analysis over the binary entity × operation relation; *Wille, 1982; Ganter & Wille, 1999*).
- **Distribution position**: which tokens dominate the frequency head, derived from the corpus's own p90 rather than a hardcoded threshold.
- **Spread**: which tokens cross file boundaries, measured by token-spread (the number of distinct files in which a token appears).

Cross-classifying tokens into the 2×2×2 cube these planes define produces cells that do not collapse. Every non-trivial cell is occupied across multiple corpora, and each cell corresponds to a distinct architectural condition: the empirically defined hub signature (high frequency + high spread + no packet bonding) sits in one cell; the diffuse-domain vocabulary worth refactoring sits in another; the local-concentration zones in a third. Bad lexicon is not a metaphor. It is a coordinate.

**Composite-signal cluster classification.** Where the lexical signal suggests a missing abstraction (clusters of free functions sharing a first parameter, or affix-polymorphism patterns implying an undeclared dispatch) classification is performed across three composite signals: **AST-body Jaccard similarity** (do these functions have similar structural shape?), **receiver-call density** (is the shared parameter being treated as a method receiver?), and **modal-token overlap** (do member names share a common naming convention?). The composite produces a label (missing class, strategy family, dispatch family, infrastructure, heterogeneous, false positive) rather than a single yes/no verdict. The labels are auditable: each input signal is reported alongside the conclusion.

The methodology composes Wille (1982) for clustering, Newman (2017) for stoplist principle, Zipf (1949) for distribution shape, Caprile & Tonella (2000) for identifier patterns, and Bavota et al. for missing-class detection into an analytical surface that did not exist in this form. Each constituent piece is decades old. The composition, applied to agent-written code at this resolution, is new.

## From stable measurement to prescriptive remedy

Stable measurements yield prescriptive remedies. A high stutter count does not invite interpretation; it names the specific identifiers in which the stutter occurs and the scope from which the stutter compensates. A first-parameter-drift cluster of seven functions all taking `result: LintResult` as their first argument is not advisory: it names the missing class, lists the candidate methods, and recommends the receiver. The output is auditable. The source is the codebase itself. The agent cannot disagree with the count.

The smell becomes a measurement. The measurement becomes a contract. The contract surfaces the reversal.

## None of this is new, and now neither is the rest of it

The classical structural metrics *predate the smartphones used to praise the AI tools that ignore them*:

* McCabe published Cyclomatic Complexity in 1976, three years before the first commercial spreadsheet.
* Halstead followed with Software Science in 1977.
* Henry and Kafura formalised information flow complexity in 1981.
* Parnas described software aging in 1994. Martin formalised architectural rot in the same year. Chidamber and Kemerer published the object-oriented metrics suite in the same year.
* Gall, Hajek, and Jazayeri described change coupling in 1998.

The structural catalogue predates the first AI coding assistant by **more than four decades**. The same field built the *lexical* prior art in parallel, and at comparable vintage:

* Harris on morpheme boundary in 1955.
* Wille's Formal Concept Analysis in 1982.
* Page-Jones's Connascence in 1996.
* Caprile & Tonella on identifier patterns in 2000.
* Lawrie, Feild & Binkley on identifier readability in 2006; Deissenboeck and Pizka on naming consistency in the same year.
* Pierret & Poshyvanyk on Zipfian regularities in software lexicons in 2009.
* Newman et al. on cross-corpus identifier categories in 2017.

Each piece is decades old. What was missing was the composition: three-plane distributional analysis, cell-occupancy validation, cross-corpus hapax stability, composite-signal cluster classification, applied to agent-written code at this resolution. That composition exists now. The structural surface is well-instrumented. The lexical one is now instrumented too.

The field spent forty years building instruments capable of measuring code structure with mathematical rigour, and forty more years quietly accumulating instruments for measuring its language. Then it built systems capable of producing code at industrial scale. Then it connected the two with a markdown file. A markdown file is a high-entropy channel, and slop is what it leaves in the work. That last step (and the consequences of leaving the structural and lexical instruments unused while doing so) is the subject of the measurement section that follows.

---

## Experiments

**Slop tracks the environment, not the model.** Fix a task and a model. Vary only the entropy of the context supplied, from a clean, frozen context (the whole-context section's fixed `C`) through progressively polluted ones: stale provenance, a contradicted intent, an unmodelled structure. Compute `QUALITY = STRUCTURE + VOCABULARY` on each output, and its inverse, slop. The hypothesis is a monotone gradient (slop rising as context entropy rises, with the model held constant) and, repeated across two model generations, that the *gradient* matters more than the *generation*: a stronger model on a polluted context produces more slop than a weaker model on a clean one. A null result (slop flat across context conditions, or dominated by model choice) would refute the claim that slop is inherited from the environment rather than produced by the model. This is the direct test of `SLOP ∝ 1/QUALITY` as a readout of accumulated entropy.

**Structural clustering of AI-generated code.** Compute Martin's Distance from the Main Sequence, Chidamber & Kemerer's CBO, and McCabe's CCX across a sample of AI-generated codebases (e.g. agent-completed open-source issues, agent-authored greenfield projects) and a matched sample of equivalent human-written codebases. Plot each on the Abstractness/Instability plane. The directional hypothesis is that AI-generated code clusters closer to the **Zone of Pain** (high stability, low abstractness) because LLMs default to literal implementations and tend to over-couple to existing structure rather than introducing new abstractions. A null result would falsify the structural-overconfidence claim from the opening section as it applies to architecture; a confirmed result establishes a measurable signature for agentic output that no amount of model improvement can hide as long as the metrics are computed externally.

**Lexical clustering of AI-generated code.** Compute the lexical taxonomy above (stutter, verbosity, cowards, hammers, parrots, sprawl, imposters, strangers, tenants) across the same matched sample. The hypothesis is that AI-generated codebases exhibit each smell at significantly higher rates than human-written codebases of equivalent functional scope, and that the gap widens with project age, i.e. that the lexical signal is a leading indicator of context-pollution as the project grows. A confirmed result establishes that the lexical surface is a measurable signature of agentic authorship, independent of structural quality.

**Independence of structural and lexical surfaces.** Across the same sample, compute the cross-correlation between structural metric scores and lexical taxonomy counts at the file and package level. The hypothesis is that the correlation is low to moderate: structural and lexical decay are *independent failure modes*, and a codebase can be clean on one surface while degraded on the other. A high correlation would falsify the independence claim and suggest the two measurement planes collapse into one. A low correlation establishes that they are orthogonal channels of evidence and justifies running both at every commit.

**Metric-as-contract for agent judgement.** Present an agent with two functionally equivalent code samples, one of which violates several metric thresholds (structural or lexical) and one of which does not. Ask the agent to choose the better implementation. Run three conditions: (a) baseline, no metrics provided; (b) treatment, computed metric scores included in the prompt as external tool observations; (c) sycophancy probe, as (b), but with the user explicitly stating a preference for the metric-violating sample. The hypothesis is that condition (b) improves selection accuracy over (a), and that condition (c) holds firm only when the metrics are presented as external tool output rather than as the agent's own computation. This experiment directly tests the load-bearing claim of the section: that external metrics function as constraints the agent cannot agree its way around.

**Cross-corpus baseline and agentic deviation of the hapax ratio.** First establish the human baseline the single-corpus measurement cannot. Compute the project-level hapax ratio across a large, varied sample of human-authored codebases (age, language, domain) and report its distribution: the band, if a stable one exists, is an output of this step, not an assumption fed into it. Then compute the same ratio for codebases authored predominantly under agent assistance, with the direction of deviation pre-registered per regime: unconstrained agent extension predicts a higher ratio (vocabulary fragmentation, a fattening tail), template-driven generation predicts a lower one (collapse toward a few reused stems). Pre-committing which regime predicts which tail is what makes the test falsifiable: an agentic corpus that lands inside the human band, or deviates against its regime, refutes the indicator. A direction-correct result establishes the hapax ratio as a single-scalar signal worth a CI threshold.
