# Decision 0005 - Single-path semantics

## Context

The platform is intended to be used heavily by AI for generation, repair, and operation.

If the same concept can be modeled in multiple different ways, the system may appear flexible to humans, but it becomes ambiguous for AI and harder to validate, compile, and maintain.

This is especially risky at the Blueprint layer, where semantic ambiguity can cascade into:

- inconsistent plugin generation
- unstable runtime behavior
- confusing repair loops
- long-term model drift

---

## Decision

Blueprint should follow a **single-path semantics** principle:

> one concept should preferably have one canonical modeling path

Multiple overlapping representations should be avoided unless they are strictly necessary and their boundaries are explicitly defined.

---

## Examples

### Object relationships
Use `Relation` as the canonical path for business relationships.
Do not model the same business relationship both as `Relation` and as `object_ref` field.

### State transitions
Use `Workflow` as the canonical path for state progression.
Do not define state progression inside Object.

### Identity
Use `identity.business_keys` as the canonical structural definition of business identity.
Do not rely on loose trait combinations to express the same thing.

---

## Why

This principle improves:

- AI generation stability
- semantic clarity
- validation determinism
- plugin compilation consistency
- documentation quality
- long-term maintainability

---

## Consequences

- blueprint design should prefer one canonical representation per concern
- convenience shortcuts should be treated carefully
- future extensions must be evaluated against semantic overlap risk
- flexibility is allowed only when semantic boundaries remain explicit
