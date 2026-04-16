# Session-Branch-PR Collaboration Model

## Purpose

This document records the collaboration model that emerged during discussion around trust, traceability, and iterative business definition in the AI coding era.

The goal is to define a simple but strong operating model for how exploratory discussion, versioned working state, and trusted definition changes should relate to each other.

---

## Core principle

The project adopts the following collaboration principle:

> each meaningful session should be anchored to its own Git branch
> the session's context source is defined by the base branch from which that working branch is created
> only structured, valuable outcomes should be promoted through pull requests into the trusted definition line

This creates a three-layer model:

- conversation for exploration
- branch for contextualized working state
- pull request for trusted admission

---

## Why this model exists

AI-assisted discussion is powerful for exploration, but raw conversation should not automatically become official system definition.

Without a stronger admission model, the system would suffer from:

- unclear authorship
- weak change traceability
- poor rollback capability
- unstable trust boundaries
- confusion about which ideas are exploratory versus adopted

Git branches and pull requests already solve these problems well in software development.
The same strengths can be reused for evolving business definition.

---

## Layer 1: Session

A session is one meaningful discussion unit.

It is not merely a message or a single reply.
It is a bounded exploration thread around a coherent theme, such as:

- stage definitions
- rule versus case distinctions
- trust and admission mechanics
- a domain-specific modeling refinement

A session is where exploration happens.

Typical session outputs may include:

- a clarified principle
- a refined rule
- a useful case
- a document draft
- a change proposal

Not every session produces official repository changes.
Some sessions remain exploratory only.

---

## Layer 2: Branch

A branch is the working container for one session.

### Rule

> one meaningful session corresponds to one Git branch

The branch provides:

- a stable working space
- a versioned context anchor
- a place to organize outputs from the session
- a boundary between this session and unrelated work

The branch is not the same as the conversation itself.
Rather, it is the version-controlled working state associated with that session.

---

## Base branch as context source

The context source of a session is defined by the branch it starts from.

This is a crucial rule.

The base branch is not merely a technical Git detail.
It defines:

- which definition snapshot the session assumes
- which prior rules and documents are treated as already established
- which semantic world this discussion is continuing from

So the base branch functions as the semantic parent of the session.

Examples:

- base `main`
  - the session continues from the current mainline definition
- base `release/...`
  - the session starts from a trusted release snapshot
- base `draft/...`
  - the session continues an earlier draft exploration line
- base `preview/...`
  - the session continues a runnable but not yet trusted alignment stage

This rule makes discussion context explicit and versioned.

---

## Layer 3: Pull Request

A pull request is the admission gate for trusted change.

Conversation is not official definition.
A working branch is not official definition.
Only reviewed pull requests can promote session outputs into the trusted definition line.

This means:

- discussion explores
- the session branch organizes
- the pull request proposes
- review decides whether the content becomes part of the official system

This separation is essential for trust.

---

## Why pull requests matter for trust

Pull requests provide several properties that are crucial for definition evolution:

### 1. Attribution
A PR records who proposed the change.

### 2. Discussion history
A PR records why the change was made and what concerns were raised.

### 3. Reviewability
A PR makes business definition changes inspectable before adoption.

### 4. Rollback capability
A merged PR becomes part of a revertable version history.

### 5. Change traceability
A PR lets the system answer:

- where did this rule come from
- who added this case
- why did this definition change
- when did this change enter the mainline

This is why trusted definition should enter through PR rather than only through chat history.

---

## What belongs in a PR

Not every session output deserves a pull request.

A PR should be used when the session produces structured, reusable definition assets such as:

- a principle
- a rule
- an invariant
- a canonical scenario
- a validation case
- a glossary clarification
- a stage definition
- an architecture note
- a decision record

Exploratory ideas that are not yet stable may remain in conversation or be abandoned with the branch.

---

## Session outcomes

Every session branch should end in one of three ways:

### 1. Promoted
The branch produces a PR and the PR is merged.

### 2. Proposed but not admitted
The branch produces a PR, but the PR is not merged.
The discussion still remains useful history.

### 3. Discarded
The branch never reaches PR quality and is abandoned.
This is acceptable.
Not all exploration should enter the official system.

This keeps the mainline clean while allowing rich exploration.

---

## Why this model is useful

This model provides several major benefits.

### Explicit context anchoring
Every meaningful discussion starts from a known definition snapshot.

### Reduced context drift
Because the session is tied to a branch and base branch, it is clear what prior assumptions are in scope.

### Better trust mechanics
Definition changes are not admitted informally.
They pass through versioned, reviewable proposals.

### Better rollback and release management
Because changes are versioned through Git, release snapshots can be trusted, compared, and reverted.

### Better parallel exploration
Different sessions can explore different directions without contaminating one another.

---

## Relationship to draft, preview, and release

This collaboration model is compatible with the project's stage model.

### Draft stage
Sessions are often discussion-heavy and definition-heavy.
Branches mainly capture evolving rules, structures, and early artifacts.

### Preview stage
Sessions often involve runnable behavior review.
Branches may include case alignment, rule adjustment, and validation refinement.

### Release stage
Sessions often begin from a trusted snapshot and explore the next round of evolution.
Branches may represent release-based refactoring, new domain pressure, or controlled business growth.

Thus, the session-branch-PR model is stage-independent.
It is the operating mechanism underneath all stages.

---

## Important boundary

This model does **not** mean that every casual conversation requires a permanent branch.

The intended meaning is:

> every meaningful session that has a clear context source and a realistic chance of producing durable definition value should be anchored to its own branch

This keeps the model practical rather than mechanical.

---

## Working interpretation

The project should operate as follows:

1. start a meaningful discussion session
2. anchor it to a dedicated Git branch
3. define the context source through the base branch
4. explore and organize the outputs on that branch
5. if durable value emerges, submit a pull request
6. admit trusted changes only through reviewable PR flow
7. delete abandoned or completed session branches to keep the repository clean

This creates a disciplined but flexible evolution loop.

---

## Final principle

> conversation is for exploration
> a session branch is for contextualized working state
> a pull request is for trusted admission

This should be treated as a foundational operating model for future Blueprint definition work.

---

## Status

Initial collaboration model recorded.
