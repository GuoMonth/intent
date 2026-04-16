# Draft-Preview-Release Evolution Model

## Purpose

This document records the current stage model for evolving AI-native business systems.

The goal is not to define a perfect abstract maturity framework.
The goal is to provide a simple, observable, and operational model that can guide how business definition, generated systems, and iterative alignment evolve together over time.

This model emerged from discussion around:

- business definition versus implementation
- trust and admission mechanics
- preview versus usable systems
- repeated evolution as business grows

---

## Core idea

A business system should not be treated as something that is defined once, implemented once, and then considered complete.

Instead, it should be treated as something that evolves through repeated cycles of:

- definition drafting
- runnable preview building
- controlled operational trust
- renewed drafting from a trusted base

The stage model is intentionally simple:

- Draft
- Preview
- Release

And it operates in a loop.

---

## Why this model is intentionally simple

A fully abstract stage model can quickly become overloaded with too many dimensions:

- semantic completeness
- rule stability
- scenario coverage
- validation confidence
- runtime maturity
- user trust
- review state

All of these matter.
However, if the stage model tries to encode all of them directly, it becomes difficult to use in real work.

The project therefore adopts a simpler principle:

> stage definitions should be based on observable system state and user-facing usability
> finer-grained maturity signals can exist as secondary indicators

This keeps the model practical.

---

## Stage 1: Draft

### Working definition

Draft means:

> there is already a meaningful system artifact or definition artifact
> users can continue discussing and refining it with AI
> but the system itself is not yet runnable for real interaction

### Intuition

At this stage:

- there is already structure
- the business definition is no longer empty
- AI and user can continue to clarify rules, boundaries, and examples
- but the system is still not something users can meaningfully run, click, or inspect as a working product

### Typical properties

- initial objects, actions, workflows, and rules may exist
- the system may have skeleton code or generated outputs
- discussion is still the main interaction mode
- business understanding is still being actively shaped
- runtime behavior is absent or not yet usable

### What Draft is for

Draft is for:

- discovering core rules
- establishing semantic structure
- identifying key constraints
- collecting initial cases
- forming a coherent first system shape

Draft is not yet about operational trust.
It is about structured emergence.

---

## Stage 2: Preview

### Working definition

Preview means:

> the system can run
> users can see it, click it, and inspect its behavior
> but it is still not good enough for dependable real-world use

### Intuition

At this stage:

- the system is no longer just a definition artifact
- it has become a visible and interactive system
- users can begin evaluating behavior through direct interaction
- however, it is still rough, incomplete, or misaligned in important ways

Preview is the stage where many hidden business gaps become visible.

### Typical properties

- the system is runnable
- users can inspect behavior directly
- core flows may exist but remain unstable
- cases, rules, and system behavior are still being aligned
- usability is still poor or uneven
- trust is still limited

### What Preview is for

Preview is for:

- behavior inspection
- case-driven alignment
- rule correction
- identifying important missing details
- comparing generated behavior against real expectations

Preview is where definition begins to be tested through system behavior rather than only conversation.

---

## Stage 3: Release

### Working definition

Release means:

> the system is good enough to enter UAT or controlled internal use
> most common situations are already stable enough that the system can be treated as usable for its current business stage

### Intuition

Release does not mean perfection.
It means the system has reached a level where:

- most important and frequent situations behave acceptably
- the business can trust it in a controlled setting
- it is reasonable to let real people use it in UAT or internal testing

A useful operational shorthand is:

> around 90 percent of normal situations no longer feel seriously broken

This is not a mathematical guarantee.
It is a practical threshold for trust.

### Typical properties

- the system is usable in controlled real scenarios
- the most important business flows are aligned
- major contradictions have been reduced
- the system is not final, but it is useful
- trust is sufficient for internal adoption

### What Release is for

Release is for:

- UAT
- internal pilots
- controlled business usage
- collecting higher-value operational feedback
- serving as a trusted base for the next evolution cycle

Release is not the end of evolution.
It is the current trusted snapshot.

---

## Why Release is not final

The business will continue to grow.
New cases will appear.
Existing rules will need reinterpretation.
Better structure will become possible.

So the system should not be imagined as:

> draft -> preview -> release -> done

Instead, the correct model is:

> draft -> preview -> release -> new draft from release -> preview -> release -> ...

This is a continuous evolution loop.

---

## The evolution loop

### Loop principle

Every release becomes a potential base for the next drafting cycle.

That means:

- a release is a trusted snapshot
- a new draft can branch from that release context
- the next evolution cycle continues from a known operational base

This allows the system to evolve together with business growth rather than repeatedly restarting from scratch.

### Why this matters

The project is not trying to define the business perfectly in one pass.

Instead, it accepts that:

- understanding improves over time
- cases accumulate over time
- trust is earned over time
- structure and usability both evolve through iteration

This loop is therefore a core operating principle, not a temporary workaround.

---

## Relationship to business definition and implementation

This stage model reflects an important architectural recognition:

> in the AI coding era, implementation is cheap
> business definition quality and structured feedback are the real leverage

Therefore:

- Draft emphasizes definition emergence
- Preview emphasizes behavior alignment
- Release emphasizes trusted usability

The stages are not primarily implementation stages.
They are stages of business-definition maturity expressed through increasing system usability.

---

## Relationship to trust

The stage model also gives a practical trust progression:

### Draft
Trust is low.
The system is still mainly a discussion and shaping artifact.

### Preview
Trust is emerging.
The system can be seen and interacted with, but remains rough and unreliable.

### Release
Trust is high enough for controlled use.
The system can support internal validation, UAT, and real feedback loops.

This makes the model easy to reason about without requiring a fully formal trust calculus.

---

## Relationship to session-branch-PR collaboration

The stage model works together with the session-branch-PR collaboration model.

### Draft sessions
Often focus on:

- rules
- structure
- concepts
- cases
- early system skeletons

### Preview sessions
Often focus on:

- behavior mismatches
- usability issues
- rule refinement through runnable interaction
- case expansion

### Release sessions
Often focus on:

- controlled operational feedback
- identifying what should enter the next draft cycle
- deciding which new changes deserve a fresh evolution branch

Thus, the stage model describes system maturity, while the session-branch-PR model describes how collaborative work enters that maturity line.

---

## Important boundary

The stage model is intentionally user-facing and operational.
It should not try to absorb every internal maturity dimension directly.

If deeper tracking is needed, the system may later add secondary indicators such as:

- definition maturity
- rule confidence
- case coverage
- validation breadth
- trust notes

But these should remain supporting signals rather than replacing the simple stage model.

---

## Current consensus

The current working consensus is:

### Draft
There is already a meaningful artifact.
Users can keep discussing and refining it with AI.
The system itself cannot yet meaningfully run.

### Preview
The system can run.
Users can see it and click it.
But it is still not good enough or stable enough for dependable use.

### Release
The system is good enough for UAT or controlled internal use.
Most common situations are already acceptable.
It becomes the trusted base for the next evolution cycle.

This is the current project-aligned interpretation.

---

## Final principle

> Draft means structured emergence
> Preview means runnable but rough alignment
> Release means trusted enough for controlled use
> and every release can become the base for the next draft

This should be treated as the current working stage model for Blueprint evolution.

---

## Status

Initial stage and evolution model recorded.
