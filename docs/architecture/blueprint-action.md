# Blueprint Action Model (v0.1)

## Overview

Action is the only execution entry point in the system.

All business behavior must be expressed through Action.

AI interacts with the system by invoking Actions, not by directly modifying Objects.

---

## Design principles

### Single execution path
All system behavior must go through Action.

### Single intent
Each Action represents one clear business capability.

### Strong semantics
Action names must reflect business meaning, not technical operations.

### Structured input
All inputs must be structured and validated.

### Guided error model
Errors must help AI understand, diagnose, and recover.

---

## Action structure

```yaml
actions:
  - name:
    label:
    description:
    target:
    input:
    preconditions:
    effects:
    output:
    error_model:
```

---

## Target

Defines the primary object the action operates on.

```yaml
target:
  object: SalesOrder
```

Rules:
- exactly one primary target
- must reference an existing Object

---

## Input

Defines structured input parameters.

```yaml
input:
  fields:
    - name: sales_order_id
      type: string
      required: true
```

---

## Preconditions

Defines required conditions before execution.

```yaml
preconditions:
  - object: SalesOrder
    rule: must_exist
  - object: SalesOrder
    rule: status_in
    values: [draft]
```

---

## Effects

Defines the impact of the action.

```yaml
effects:
  - type: transition_workflow
    target: SalesOrder
    to: confirmed
```

---

## Output

Defines result structure.

```yaml
output:
  type: object_summary
  target: SalesOrder
```

---

## Error model (enhanced)

Error model is a structured AI guidance system.

```yaml
error_model:
  known_errors:
    - code: INVALID_STATE
      description: Sales order must be in draft state
      context:
        object: SalesOrder
        current_state: confirmed
      hints:
        - check workflow definition
        - verify allowed transitions
      ai_focus:
        - workflow
        - action.preconditions
      suggested_next_steps:
        - query current order state
        - evaluate if cancellation is required before retry
```

---

## Error model components

### code
Stable identifier

### description
Human-readable explanation

### context
Relevant structured data for debugging

### hints
Short suggestions to guide reasoning

### ai_focus
Which parts of the Blueprint or system should be inspected

### suggested_next_steps
Concrete recovery or retry strategies

---

## Key principle

Errors are not terminal outputs.

They are inputs to the next AI reasoning step.

---

## Example

```yaml
actions:
  - name: confirm_sales_order
    label: Confirm Sales Order
    description: Confirm a draft sales order

    target:
      object: SalesOrder

    input:
      fields:
        - name: sales_order_id
          type: string
          required: true

    preconditions:
      - object: SalesOrder
        rule: must_exist
      - object: SalesOrder
        rule: status_in
        values: [draft]

    effects:
      - type: transition_workflow
        target: SalesOrder
        to: confirmed

    output:
      type: object_summary
      target: SalesOrder

    error_model:
      known_errors:
        - code: ORDER_NOT_FOUND
          description: Sales order does not exist
          ai_focus:
            - object
        - code: INVALID_STATE
          description: Sales order must be in draft state
          context:
            current_state: confirmed
          hints:
            - check workflow definition
          ai_focus:
            - workflow
          suggested_next_steps:
            - fetch current state
            - decide next valid transition
```

---

## Status

v0.1 draft with AI-oriented error model.
