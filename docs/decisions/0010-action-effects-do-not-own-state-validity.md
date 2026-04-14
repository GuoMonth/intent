# Decision 0010 - Action effects do not own state validity

## Context

Action includes an `effects` section to describe the expected impact of executing a business capability.

However, once Workflow is established as the single authority for state legality, a new ambiguity appears:

> if Action effects declare a state transition target, does Action become a second state authority?

For example:

```yaml
effects:
  - type: transition_workflow
    target: SalesOrder
    to: confirmed
```

At the same time, Workflow may define:

```yaml
from: draft -> to: confirmed via confirm_sales_order
```

If both are treated as equally authoritative, the system becomes ambiguous.

---

## Decision

Action effects may only declare **transition intent**, not transition validity.

This means:

- Action may state that it intends to request a transition
- Workflow remains the only authority that determines whether the transition is valid
- runtime must validate transition requests against Workflow before applying state change

---

## Preferred semantic form

Instead of treating Action effects as direct state mutation authority, the platform should interpret them as:

```yaml
effects:
  - type: request_transition
    target: SalesOrder
    to: confirmed
```

This reflects intent, not independent rule ownership.

---

## Example

### Correct

```yaml
actions:
  - name: confirm_sales_order
    target:
      object: SalesOrder
    effects:
      - type: request_transition
        target: SalesOrder
        to: confirmed
```

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

Runtime flow:
1. Action is invoked
2. Action requests transition intent
3. Workflow validates current state and allowed transition
4. Runtime applies transition only if Workflow permits it

### Incorrect

```yaml
actions:
  - name: confirm_sales_order
    effects:
      - type: transition_workflow
        target: SalesOrder
        to: confirmed
```

If interpreted as directly authoritative, this duplicates Workflow authority.

---

## Why

This decision preserves:

- single-path state authority
- separation of behavior and legality
- deterministic validation
- AI reasoning clarity
- future maintainability

---

## Consequences

- Action effects should be modeled as intent declarations
- Workflow remains the only place that decides state legality
- runtime must resolve effect requests through Workflow validation
- future docs and implementations should avoid direct state mutation semantics inside Action definitions
