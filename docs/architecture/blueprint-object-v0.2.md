# Blueprint Object Model (v0.2)

## Overview

Object remains the central business entity abstraction in Blueprint.

This version refines v0.1 by:

- removing `state_model` from Object
- strengthening Relation semantics
- aligning Field and Identity semantics

---

## Core definition

An Object defines:

- a business entity
- its attributes (fields)
- how it is identified (identity)
- how it relates to other objects (relations)
- optional semantic traits

Object does NOT define state transitions directly.
State is handled by Workflow.

---

## Object v0.2 structure

```yaml
object:
  name:
  label:
  description:

  identity:
    business_keys: []

  fields: []

  relations: []

  traits: []
```

---

## Field integration

Fields are defined separately but used inside Object.

Each field must follow the Field schema.

Identity must reference existing fields.

---

## Relation v0.2 structure

Relations are now strongly defined:

```yaml
relations:
  - name: order_lines
    type: one_to_many
    target: SalesOrderLine
    inverse: order
```

### Required attributes

- name
- type (one_to_one, one_to_many, many_to_one)
- target (object name)
- inverse (optional but recommended)

---

## Identity semantics (refined)

Identity is separated from Field traits.

```yaml
identity:
  business_keys: [sku]
```

Rules:
- must reference fields
- expresses business-level uniqueness

Field trait `business_key` is optional and informational.

---

## Traits (refined)

Traits should be limited to a controlled set in v0.1:

- attachable
- importable
- exportable
- auditable

Traits influence platform behavior but do not replace explicit configuration.

---

## Design principles (reinforced)

### Object is business-first
Object models business meaning, not storage.

### Object is relation-driven
Business connections must be modeled through Relation, not implicit references.

### Object is workflow-neutral
State transitions are not defined here.

### Object is AI-stable
Structure must be predictable for AI generation and repair.

---

## Example

```yaml
objects:
  - name: Product
    label: Product
    description: Sellable product definition
    identity:
      business_keys: [sku]
    fields:
      - name: sku
        type: string
        label: SKU
        required: true
      - name: name
        type: string
        label: Product Name
        required: true
      - name: unit_price
        type: decimal
        label: Unit Price
    traits:
      - importable
      - exportable
```

---

## Status

v0.2 refined model. Ready for Action model design.
