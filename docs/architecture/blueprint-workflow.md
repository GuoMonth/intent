# Blueprint Workflow Model (v0.1)

## Overview

Workflow is defined as a **state constraint model**, not a general-purpose orchestration engine.

Its sole responsibility is to define how object state may legally change.

---

## Position in system

Object -> defines structure
Action -> defines behavior
Workflow -> defines allowed state transitions
Permission -> defines who can trigger actions

---

## Design goals

Workflow must be:

- simple
- deterministic
- AI-readable
- validation-friendly

---

## Workflow structure

```yaml
workflows:
  - name:
    label:
    description:
    object:
    initial_state:
    states:
    transitions:
```

---

## Fields

### name
Stable identifier

### label
Human-readable name

### description
Explains lifecycle purpose

### object
Target object this workflow governs

### initial_state
Default starting state

### states
List of valid states

### transitions
List of allowed state transitions

---

## Transition structure

```yaml
transitions:
  - name: confirm
    from: draft
    to: confirmed
    action: confirm_sales_order
```

---

## Rules

- each transition must map to exactly one action
- each transition must define one `from` and one `to`
- action must exist
- states must be predefined

---

## Responsibilities

Workflow defines:

- what states exist
- how state can change
- which action triggers which transition

Workflow does NOT define:

- how the action is implemented
- complex branching logic
- cross-object orchestration

---

## Validation examples

- invalid state reference
- missing action
- unreachable state
- conflicting transitions

---

## Example

```yaml
workflows:
  - name: sales_order_workflow
    object: SalesOrder
    initial_state: draft
    states:
      - draft
      - confirmed
      - shipped
      - completed
    transitions:
      - name: confirm
        from: draft
        to: confirmed
        action: confirm_sales_order
      - name: ship
        from: confirmed
        to: shipped
        action: ship_sales_order
      - name: complete
        from: shipped
        to: completed
        action: complete_sales_order
```

---

## Key principle

Workflow is the single source of truth for state transitions.

---

## Status

v0.1 minimal lifecycle model
