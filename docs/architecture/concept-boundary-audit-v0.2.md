# Concept Boundary Audit (v0.2)

## Purpose

This document defines the semantic boundaries between core Blueprint concepts.

Each concept must answer exactly one type of question and must not overlap with others.

---

## Core questions mapping

| Concept     | Question it answers                         |
|-------------|---------------------------------------------|
| Object      | What exists in the system?                  |
| Field       | What attributes does it have?               |
| Relation    | How are objects connected?                  |
| Action      | What can be done?                           |
| Workflow    | When is a state change allowed?             |
| Permission  | Who is allowed to do it?                    |
| Error Model | What went wrong and what should be done?    |

---

## Boundary examples

### Example 1: Confirm sales order

#### Object

```yaml
object: SalesOrder
```

#### Action

```yaml
action: confirm_sales_order
```

#### Workflow

```yaml
from: draft -> to: confirmed
```

#### Permission

```yaml
role: sales can execute confirm_sales_order
```

---

## Anti-patterns

### ❌ State rule inside Action

```yaml
preconditions:
  - rule: status_in
    values: [draft]
```

Should be in Workflow instead.

---

### ❌ Actor permission logic inside Action

```yaml
preconditions:
  - rule: actor_is_creator
```

Should be expressed in Permission layer.

---

### ❌ Business relation expressed as field reference

```yaml
customer_id: object_ref(Customer)
```

Should be expressed as Relation.

---

## Correct decomposition

```yaml
relations:
  - name: customer
    type: many_to_one
    target: Customer
```

---

## Expanded examples

### Example 2: Cancel order created by current actor

#### Correct split

```yaml
permissions:
  policies:
    - name: creator_can_cancel_order
      subject:
        role: sales
      target:
        object: SalesOrder
      allow:
        actions:
          - cancel_sales_order
      conditions:
        - rule: actor_is_creator
```

```yaml
workflows:
  - name: sales_order_workflow
    object: SalesOrder
    initial_state: draft
    states: [draft, confirmed, cancelled]
    transitions:
      - name: cancel
        from: draft
        to: cancelled
        action: cancel_sales_order
```

```yaml
actions:
  - name: cancel_sales_order
    target:
      object: SalesOrder
    preconditions:
      - object: SalesOrder
        rule: must_exist
```

#### Incorrect split

```yaml
actions:
  - name: cancel_sales_order
    preconditions:
      - rule: actor_is_creator
      - rule: status_in
        values: [draft]
```

The incorrect version mixes:

- authorization
- state legality
- action contract

inside one concept.

---

## Error model example

```yaml
error:
  code: INVALID_STATE
  context:
    current_state: confirmed
  ai_focus:
    - workflow
  suggested_next_steps:
    - fetch current state
    - evaluate next valid transition
```

---

## Key principle

Each concept must remain single-purpose.

If a rule appears in multiple places, it is likely a design error.

---

## Status

v0.2 boundary audit with extended examples
