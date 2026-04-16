# Definition Change PR Rules

## Purpose

This document defines when a business-definition change should be promoted into a pull request, and what minimum structure such a pull request should contain.

The goal is to make pull requests the trusted admission gate for evolving business definition, rather than treating PRs as generic document updates.

This document works together with:

- `docs/architecture/session-branch-pr-model.md`
- `docs/architecture/draft-preview-release-evolution-model.md`

---

## Core principle

Exploration may happen through conversation.
A session branch may contain drafts, notes, and partial thinking.

But a pull request should only be opened when the session has produced a structured definition asset that is meaningful enough to be reviewed, traced, and potentially admitted into the trusted definition line.

So the operating principle is:

> conversation explores
> a session branch organizes
> a pull request proposes trusted definition change

---

## What counts as a definition asset

A definition asset is a structured artifact that changes how the system defines, evaluates, or evolves business meaning.

Typical examples include:

- a principle
- a rule
- an invariant
- a canonical scenario
- a validation case
- a stage definition
- a glossary clarification
- a decision record
- an architecture note
- a collaboration rule

These assets are more durable than casual discussion and therefore deserve PR-based review.

---

## What should usually require a PR

The following changes should normally enter the system through pull requests:

### 1. Core principles
Examples:

- definition-over-implementation positioning
- trust and admission rules
- collaboration rules
- release evolution principles

### 2. Rules and invariants
Examples:

- business constraints
- semantic boundaries
- quantity relations
- state legality rules

### 3. Canonical scenarios
Examples:

- representative business situations that help define meaning
- important domain patterns that AI should repeatedly learn from

### 4. Validation cases
Examples:

- expected state transitions
- expected inventory impact
- expected rejection cases
- behavior assertions tied to definition

### 5. Stage model definitions
Examples:

- draft / preview / release definitions
- stage entry interpretation
- release snapshot rules

### 6. Important terminology definitions
Examples:

- meanings of rule, case, scenario, invariant, release, trust, preview

### 7. Decision records
Examples:

- explicit architectural or semantic decisions that should remain reviewable and traceable

---

## What does not always need a PR

The following may remain in session discussion or be discarded without PR if they do not mature into durable definition assets:

- temporary exploration
- clarifying conversation that does not change system meaning
- unstable ideas
- local examples that do not yet rise to representative case quality
- early drafts that are later abandoned
- partial notes that are not worth long-term preservation

This prevents PR noise.

---

## PR admission threshold

A session outcome is ready for PR when most of the following are true:

### 1. It has durable value
The content is likely to remain useful beyond the current conversation.

### 2. It changes or clarifies system definition
It affects how business meaning, trust, validation, or evolution is understood.

### 3. It can be structured clearly
The content can be expressed as a document, rule set, case set, decision record, or other stable artifact.

### 4. It is reviewable
A reviewer can meaningfully assess whether it should be admitted.

### 5. It is separate enough from pure brainstorming
The proposal is no longer just speculation or free-form exploration.

This threshold helps distinguish formal definition proposals from raw discussion residue.

---

## Minimum PR structure

Every definition change PR should include a minimal structured description.

### Required fields

#### 1. Change type
What kind of definition asset is being proposed?

Suggested values:

- principle
- rule
- invariant
- scenario
- validation_case
- stage_definition
- glossary
- decision_record
- architecture_note
- other

#### 2. What changed
A concise description of the proposed change.

#### 3. Why
Why is this change needed?

Typical reasons:

- rule clarification
- ambiguity reduction
- better validation
- better trust and traceability
- better stage control
- better AI generation guidance

#### 4. Scope / impact
What area of the system does this affect?

Examples:

- business definition only
- validation only
- trust / process only
- stage semantics
- future release interpretation

#### 5. Review focus
What should reviewers pay special attention to?

---

## Recommended extended fields

These are not always mandatory, but are strongly recommended when relevant.

### 6. Related concepts
Which rules, stages, scenarios, or prior documents does this connect to?

### 7. Validation implications
Does this require:

- new validation cases
- updated validation interpretation
- no immediate validation update

### 8. Stage impact
Does this affect:

- Draft understanding
- Preview understanding
- Release understanding
- no stage impact

### 9. Release impact
Should this be treated as:

- future-facing only
- affects current mainline interpretation
- may change release readiness judgment

---

## Lightweight PR template

A simple starting template can be:

```md
## Change type
- principle | rule | invariant | scenario | validation_case | stage_definition | glossary | decision_record | architecture_note | other

## What changed
- 

## Why
- 

## Scope / impact
- 

## Review focus
- 

## Validation implications
- none | existing validation still sufficient | new validation cases needed

## Stage impact
- none | draft | preview | release
```

This is intentionally minimal.

---

## How this connects to trust

The reason PRs matter is not only change control.
They also support trust by making definition evolution:

- attributable
- reviewable
- discussable
- revertable
- historically traceable

In this project, trusted business definition should not enter the system only through informal conversation.
It should enter through reviewable PR flow.

---

## Relationship to the stage model

This PR rule set works across all stages.

### Draft-stage PRs
Often introduce:

- principles
- core rules
- early scenarios
- collaboration rules

### Preview-stage PRs
Often introduce:

- refined cases
- rule adjustments from observed behavior
- validation improvements

### Release-stage PRs
Often introduce:

- trusted stage clarifications
- release gating notes
- feedback-driven refinements
- base snapshots for the next evolution cycle

So the PR system does not replace the stage model.
It serves as the trusted change mechanism within and across stages.

---

## Current working consensus

The current consensus is:

- not every session needs a PR
- not every branch artifact deserves admission
- only structured and durable definition assets should enter through PR
- PRs should carry enough structure to support meaningful review
- trust is strengthened when business definition evolves through attributable, reviewable, and revertable proposals

This is the current admission logic for trusted definition evolution.

---

## Final principle

> not every idea deserves a PR
> but every trusted definition change should enter through a PR

This should be treated as the current operating rule for definition evolution.

---

## Status

Initial PR admission rules recorded.
