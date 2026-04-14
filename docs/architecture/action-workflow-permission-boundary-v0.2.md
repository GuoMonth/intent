# Action ↔ Workflow ↔ Permission Boundary (v0.2)

## Overview

This document refines the boundary model by addressing one final ambiguity:

> Action effects vs Workflow authority

---

## Core separation

| Concept    | Responsibility                          |
|------------|------------------------------------------|
| Action     | what can be done                         |
| Workflow   | when state change is allowed             |
| Permission | who is allowed to perform the action     |

---

## Final rule set

### Rule 1: Action is the only execution entry

All system behavior must be triggered through Action.

---

### Rule 2: Workflow is the only state authority

Only Workflow defines valid state transitions.

---

### Rule 3: Permission is the only authorization authority

Only Permission determines whether an actor may invoke an Action.

---

### Rule 4: Action effects express intent, not authority

Action may declare what it intends to change, but must not enforce state transitions directly.

---

## Interaction flow (refined)

```text
AI -> Action -> Permission check -> Workflow validation -> apply transition -> return result or structured error
```

---

## Example

### Step-by-step execution

1. AI invokes `confirm_sales_order`
2. Permission verifies actor role
3. Action requests transition to `confirmed`
4. Workflow checks if current state allows transition
5. Runtime applies change only if valid
6. Otherwise returns structured error with guidance

---

## Anti-patterns

### ❌ Action directly mutating state

```yaml
effects:
  - type: transition_workflow
```

### ❌ Workflow embedding execution logic

### ❌ Permission embedding state rules

---

## Key invariant

At runtime, state change must always pass through Workflow validation.

---

## Result

This ensures:

- no duplicated authority
- clear debugging path
- predictable AI reasoning
- stable repair loops

---

## Status

v0.2 boundary model with effect semantics
