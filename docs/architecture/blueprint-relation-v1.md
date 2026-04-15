# Blueprint Relation Model (v1)

## Overview

Relation defines how Objects are connected in the system.

In Blueprint v1, Relation includes an additional semantic field:

```yaml
ownership: owned | referenced
```

This field is introduced to improve semantic clarity and reduce ambiguity in modeling.

---

## Relation structure (v1)

```yaml
relations:
  - name:
    type:
    target:
    inverse:
    ownership:
```

---

## Fields

### name
Stable identifier for the relation

### type
Relationship type:
- one_to_one
- one_to_many
- many_to_one

### target
Target object

### inverse
Optional inverse relation name

### ownership (new in v1)

Defines whether the target object is conceptually part of the source object or just referenced.

Allowed values:

```yaml
ownership: owned | referenced
```

---

## Semantics

### owned

- target object is conceptually part of the source
- typical for line-item or child structures
- example:
  - SalesOrder → SalesOrderLine

### referenced

- target object exists independently
- source object only refers to it
- example:
  - SalesOrderLine → ProductVariant

---

## Design principle

Ownership is a semantic hint, not an execution rule.

It must not:

- replace workflow
- define lifecycle transitions
- encode permission logic

---

## Example

```yaml
relations:
  - name: order
    type: many_to_one
    target: SalesOrder
    inverse: lines
    ownership: owned

  - name: product_variant
    type: many_to_one
    target: ProductVariant
    inverse: sales_order_lines
    ownership: referenced
```

---

## Why this matters

This addition allows:

- clearer modeling of parent-child relationships
- reduced ambiguity for AI
- improved readability of Blueprint definitions

---

## Status

v1 relation model with ownership semantics
