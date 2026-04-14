# Decision 0009 - Actor conditions belong to Permission

## Context

As Blueprint boundaries become clearer, one recurring ambiguity remains:

> should actor-related conditions be expressed in Permission or in Action preconditions?

Examples include:

- only the creator may cancel the order
- only the assigned approver may approve the request
- only warehouse operators of the same location may allocate inventory

If these actor-related constraints are modeled inside Action preconditions, Action begins to absorb authorization logic.
This weakens semantic clarity and creates overlap with Permission.

---

## Decision

Conditions involving the **actor / subject** belong to **Permission**.

This includes conditions such as:

- actor is creator
- actor is assignee
- actor belongs to department X
- actor matches object owner
- actor belongs to same warehouse or business unit

Action preconditions must not express who is allowed to act.

---

## Action preconditions still allowed

Action preconditions may define non-actor requirements such as:

- target object exists
- required input is present
- related object exists
- dependent resource is available
- external context is ready

---

## Example

### Correct

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
actions:
  - name: cancel_sales_order
    target:
      object: SalesOrder
    preconditions:
      - object: SalesOrder
        rule: must_exist
```

### Incorrect

```yaml
actions:
  - name: cancel_sales_order
    preconditions:
      - rule: actor_is_creator
```

The incorrect version hides authorization logic inside Action.

---

## Why

This decision improves:

- semantic clarity
- single-path authorization
- AI reasoning stability
- validation consistency
- maintainability

---

## Consequences

- actor-related conditions should be modeled only in Permission
- Action remains focused on business capability contract
- future subject models can evolve in Permission without polluting Action
