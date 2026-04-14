# Decision 0007 - Workflow scope

## Context

With strong AI coding capabilities, the platform can rely on generated Python scripts or other programmable logic for complex orchestration, conditional behavior, integration flows, and repair loops.

This raises a key design question:

> does the platform still need a traditional workflow engine?

The risk is that a heavy workflow engine may duplicate the role of AI-generated scripts while also increasing semantic complexity.

---

## Decision

The platform will **not** treat Workflow as a general-purpose orchestration engine.

Instead, Workflow in Blueprint is limited to:

> object lifecycle and state transition constraints

Complex orchestration, procedural logic, cross-object coordination, and integration behavior should be handled by scripts, plugins, or runtime logic.

---

## Included in Workflow

- state definitions
- initial state
- allowed transitions
- action-to-transition mapping
- state-level validation constraints

---

## Excluded from Workflow

- BPM-style visual flow modeling
- arbitrary branching graphs
- heavy orchestration logic
- script execution logic
- external system integration choreography
- timer / scheduler semantics in v0.1
- multi-object process graph semantics in v0.1

---

## Why

This keeps Workflow:

- simple
- stable
- easy for AI to reason about
- aligned with the single-path semantics principle

It also avoids overlapping with the role of programmable script execution.

---

## Consequences

- Workflow should be modeled as a state authority, not as a workflow engine
- runtime should treat Workflow as a validation and transition rule layer
- advanced orchestration belongs in scripts or plugin logic
- Blueprint remains clearer and easier to validate
