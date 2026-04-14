# Blueprint Permission Model (v0.1)

## Overview

Permission defines who is allowed to perform which Action on which Object scope.

Permission is a first-class Blueprint concern and must remain separate from:

- Action semantics
- Workflow state rules
- implementation logic

---

## Position in system

Object -> defines business entities
Action -> defines business capabilities
Workflow -> defines legal state transitions
Permission -> defines who may invoke which capabilities in which scope

---

## Design goals

Permission must be:

- simple
- explicit
- role-oriented
- AI-readable
- validation-friendly

---

## Core principle

Permission does not define business behavior.

It only decides whether an actor is allowed to invoke an Action or access an Object scope.

---

## Permission structure

```yaml
permissions:
  roles:
    - name:
      label:
      description:

  policies:
    - name:
      subject:
      target:
      allow:
      conditions:
```

---

## Roles

Role is the primary subject abstraction in v0.1.

```yaml
roles:
  - name: sales
    label: Sales
    description: Sales staff who create and confirm sales orders
```

Rules:
- role names must be unique
- role names should be stable and explicit

---

## Policies

A policy defines what a role may do.

```yaml
policies:
  - name: sales_can_confirm_order
    subject:
      role: sales
    target:
      object: SalesOrder
    allow:
      actions:
        - confirm_sales_order
```

---

## Subject

Defines who the policy applies to.

v0.1 only supports:

```yaml
subject:
  role: sales
```

This keeps the model simple and avoids premature complexity.

---

## Target

Defines the business scope.

```yaml
target:
  object: SalesOrder
```

Rules:
- target object must exist
- policies are anchored to object scope, not arbitrary runtime resources

---

## Allow

Defines what is allowed.

v0.1 focuses on Action-level permission:

```yaml
allow:
  actions:
    - create_sales_order
    - confirm_sales_order
```

Optional object access semantics may be added later, but Action permission is primary.

---

## Conditions

Conditions narrow the policy scope.

v0.1 should remain minimal.

Examples:

```yaml
conditions:
  - rule: object_state_in
    values: [draft]
```

or:

```yaml
conditions:
  - rule: actor_department_matches_object
```

Conditions should be used sparingly in v0.1.

---

## Design principles

### Single path
Permission is the only layer that decides who may invoke actions.

### Action-first authorization
The primary authorization unit is Action, not raw CRUD or field mutation.

### Object-scoped policies
Policies should remain tied to business objects to keep reasoning stable.

### Simple role model first
v0.1 uses role-based permission before more advanced subject models.

---

## Example

```yaml
permissions:
  roles:
    - name: sales
      label: Sales
      description: Sales staff
    - name: warehouse
      label: Warehouse
      description: Warehouse operators

  policies:
    - name: sales_order_actions
      subject:
        role: sales
      target:
        object: SalesOrder
      allow:
        actions:
          - create_sales_order
          - confirm_sales_order
          - cancel_sales_order

    - name: warehouse_order_actions
      subject:
        role: warehouse
      target:
        object: SalesOrder
      allow:
        actions:
          - allocate_sales_order
          - ship_sales_order
```

---

## Validation examples

- unknown role
- unknown target object
- unknown action
- policy action does not belong to target object scope
- duplicate or conflicting policies

---

## Status

v0.1 draft. Focused on role-based action authorization.
