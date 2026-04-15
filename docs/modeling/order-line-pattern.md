# Order Line Modeling Pattern

## Purpose

This document defines a reusable modeling pattern for representing:

- a transactional parent object
- one or more subordinate line items
- line items that belong to the parent transaction
- line items that also reference external business objects

This pattern exists to help AI use existing platform primitives to model transactional detail structures without introducing special-purpose primitives such as `OrderLine` into the platform core.

---

## Why this pattern exists

Many business systems need a distinction between:

- the main transactional document
- the detailed items contained inside that document

Examples:

- SalesOrder vs SalesOrderLine
- PurchaseOrder vs PurchaseOrderLine
- Invoice vs InvoiceLine
- ReturnOrder vs ReturnOrderLine

The platform should not hard-code `line item` as a primitive.

Instead, line-based structures should be modeled through existing primitives plus one important semantic rule:

- the parent-child relation is typically `owned`

---

## Pattern intent

This pattern answers the question:

> how can AI model a transactional object with subordinate detail records using current primitives and clear relation semantics?

The answer is to use:

- one Object for the main transaction
- one Object for the line item
- an `owned` relation from line item to the parent object
- `referenced` relations from line item to reusable external objects
- separate identities appropriate to parent and line layers

---

## Pattern structure

### Object roles

#### Transaction object
Represents the main business transaction.

Typical meaning:
- sales order
- purchase order
- invoice
- return order

#### Line item object
Represents a subordinate transactional detail record.

Typical meaning:
- order line
- invoice line
- return line

---

## Recommended primitive composition

```yaml
objects:
  - name: SalesOrder
    identity:
      business_keys: [order_number]

  - name: SalesOrderLine
    identity:
      business_keys: [line_key]
    relations:
      - name: order
        type: many_to_one
        target: SalesOrder
        inverse: lines
        ownership: owned
```

This keeps the line item structure explicit while avoiding any line-item-specific platform primitive.

---

## Semantic guidance

### What should belong to the transaction object

Examples:
- order_number
- customer_name
- order_date
- transaction-level status
- transaction-level attachments

### What should belong to the line item object

Examples:
- line_key
- quantity
- unit price
- per-line discount
- line-level reference to product variant or service item

---

## Ownership semantics

This pattern relies heavily on `Relation.ownership`.

### Parent relation should usually be `owned`

Example:

```yaml
- name: order
  type: many_to_one
  target: SalesOrder
  inverse: lines
  ownership: owned
```

Meaning:
- the line is conceptually part of the order
- the line should not be treated as an independent reusable object
- the line is subordinate to the transaction

### External business references should usually be `referenced`

Example:

```yaml
- name: product_variant
  type: many_to_one
  target: ProductVariant
  inverse: sales_order_lines
  ownership: referenced
```

Meaning:
- the line points to a reusable external object
- the external object does not belong to the line

---

## Identity strategy

### Transaction identity
Should identify the main transaction.

Example:
- order_number

### Line identity
The line item may still need its own business key or line-scoped identifier.

Example:
- line_key

Why this matters:
- enables line-level reference and updates
- reduces ambiguity in AI reasoning
- supports clear action inputs

This does not mean the line item becomes an independent business center.
Its identity exists for traceability and manipulation, not for semantic independence.

---

## Action boundary guidance

### Actions on the parent transaction
Examples:
- create_sales_order
- confirm_sales_order
- cancel_sales_order

These operate on the transaction object.

### Actions on line items
Examples:
- add_sales_order_line
- update_sales_order_line_quantity
- remove_sales_order_line

These operate on the line item object but remain semantically tied to the parent transaction.

Action must not redefine ownership semantics.
That meaning belongs in Relation.

---

## Workflow boundary guidance

In most cases, the main transaction carries the workflow.

Example:
- SalesOrder has states: draft, confirmed, cancelled

The line item usually does **not** need its own workflow in the minimal pattern.

This keeps the model simpler and avoids over-structuring.

If a domain later proves that lines require independent lifecycle control, that should be treated as a separate validation problem rather than assumed by default.

---

## Permission boundary guidance

Permission should usually be anchored to the transaction and its actions.

Examples:
- sales may create order
- sales may add line
- sales may confirm order

Actor-related conditions still belong to Permission.
State legality still belongs to Workflow.
Ownership still belongs to Relation.

---

## AI guidance

When AI encounters a transactional structure with repeating detail records, it should ask:

1. Is there a main transaction object?
2. Are there subordinate detail records that belong to that transaction?
3. Do those detail records also point to reusable external objects?

If yes, AI should first try this pattern:

- Transaction Object
- Line Item Object
- owned relation to parent
- referenced relation to reusable external object

before asking for a new primitive.

---

## When to use this pattern

Use this pattern when:

- a business transaction contains one or more detail rows
- detail rows are subordinate to a parent object
- detail rows reference reusable external objects such as products or services

---

## When not to use this pattern

Do not force this pattern when:

- the transaction has no meaningful subordinate detail layer
- the detail layer does not add semantic value
- a single object is sufficient and clearer

Also do not assume line items need their own workflow unless validation proves it.

---

## Why this pattern matters

This pattern demonstrates another aspect of the platform design goal:

> build minimal, clear, composable, and AI-learnable LEGO-like primitives

It shows that even common enterprise structures such as line-item documents can be modeled using the same small primitive system.

---

## Current observations

This pattern further strengthens the case for:

- `Relation.ownership` as a core semantic feature

It does **not** yet justify introducing:

- a dedicated line-item primitive
- `Object.kind` into the core model

Those remain outside the platform core unless future validation proves otherwise.

---

## Status

Initial modeling pattern for Phase 2 semantic validation.
