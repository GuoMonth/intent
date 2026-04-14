# Decision 0008 - State validity belongs to Workflow

## Context

As the Blueprint model evolves, one recurring ambiguity appears:

> should Action preconditions be allowed to express state legality?

For example:

- Action precondition says: order status must be `draft`
- Workflow transition says: `draft -> confirmed` via `confirm_sales_order`

If both layers express the same state rule, the system gains apparent flexibility but loses semantic clarity.
This creates duplicated logic, inconsistent validation, and unstable AI repair behavior.

---

## Decision

State legality belongs to **Workflow** only.

This means:

- Workflow is the single source of truth for whether a state transition is valid
- Action must not redefine state legality rules
- Action may reference that a state transition is expected, but may not become the authority for state validation

---

## What Action preconditions may still define

Action preconditions may define non-state requirements such as:

- target object must exist
- required input must be present
- related object must exist
- dependent resource must be available
- external context must be ready

---

## What Action preconditions must not define

Action preconditions must not redefine state legality such as:

- order status must be `draft`
- invoice status must be `pending_approval`
- shipment status must be `allocated`

These belong to Workflow.

---

## Example

### Correct

```yaml
workflows:
  - name: sales_order_workflow
    object: SalesOrder
    initial_state: draft
    states: [draft, confirmed, cancelled]
    transitions:
      - name: confirm
        from: draft
        to: confirmed
        action: confirm_sales_order
```

```yaml
actions:
  - name: confirm_sales_order
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
```

### Incorrect

```yaml
actions:
  - name: confirm_sales_order
    preconditions:
      - object: SalesOrder
        rule: status_in
        values: [draft]
```

The incorrect version duplicates Workflow state legality.

---

## Why

This decision improves:

- single-path semantics
- boundary clarity
- deterministic validation
- AI reasoning stability
- maintainability

---

## Consequences

- state legality checking must be implemented against Workflow
- Action contracts remain cleaner
- repair guidance can point AI to Workflow when state errors occur
- future design must avoid reintroducing state logic into Action
