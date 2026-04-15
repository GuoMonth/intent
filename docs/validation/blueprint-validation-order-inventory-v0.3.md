# Blueprint Validation - Order & Inventory (v0.3)

## Purpose

This version evaluates one candidate semantic enhancer only:

> `Relation.ownership`

The goal is to test whether adding a small ownership semantic can reduce modeling ambiguity and improve expression clarity without introducing semantic overlap.

This document keeps the same overall scenario as v0.2:

- abstract product definition
- concrete sellable variant
- inventory record
- sales order
- sales order line

---

## Validation focus

The main question is:

> does `Relation.ownership` materially improve semantic clarity and reduce expression complexity?

The enhancer under evaluation is:

```yaml
ownership: owned | referenced
```

---

## Domain

```yaml
domain: order_inventory
```

---

## Objects

```yaml
objects:
  - name: ProductModel
    label: Product Model
    description: Abstract product definition shared by sellable variants
    identity:
      business_keys: [model_code]
    fields:
      - name: model_code
        type: string
        label: Model Code
        required: true
      - name: name
        type: string
        label: Product Name
        required: true
      - name: category
        type: string
        label: Category
        required: false
    traits:
      - importable
      - exportable

  - name: ProductVariant
    label: Product Variant
    description: Sellable product unit defined by a variant combination under a product model
    identity:
      business_keys: [variant_code]
    fields:
      - name: variant_code
        type: string
        label: Variant Code
        required: true
      - name: spec_summary
        type: string
        label: Specification Summary
        required: false
    relations:
      - name: product_model
        type: many_to_one
        target: ProductModel
        inverse: variants
        ownership: referenced
    traits:
      - importable
      - exportable
      - auditable

  - name: InventoryItem
    label: Inventory Item
    description: Inventory record for a product variant in a storage location
    identity:
      business_keys: [inventory_key]
    fields:
      - name: inventory_key
        type: string
        label: Inventory Key
        required: true
      - name: location_code
        type: string
        label: Location Code
        required: true
      - name: quantity
        type: integer
        label: Quantity
        required: true
    relations:
      - name: product_variant
        type: many_to_one
        target: ProductVariant
        inverse: inventory_items
        ownership: referenced
    traits:
      - auditable

  - name: SalesOrder
    label: Sales Order
    description: Customer sales order
    identity:
      business_keys: [order_number]
    fields:
      - name: order_number
        type: string
        label: Order Number
        required: true
      - name: customer_name
        type: string
        label: Customer Name
        required: true
    traits:
      - attachable
      - auditable

  - name: SalesOrderLine
    label: Sales Order Line
    description: Sales order line that references a sellable product variant
    identity:
      business_keys: [line_key]
    fields:
      - name: line_key
        type: string
        label: Line Key
        required: true
      - name: quantity
        type: integer
        label: Quantity
        required: true
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
    traits:
      - auditable
```

---

## Actions

```yaml
actions:
  - name: create_product_model
    label: Create Product Model
    description: Create a reusable abstract product model
    target:
      object: ProductModel
    input:
      fields:
        - name: model_code
          type: string
          required: true
        - name: name
          type: string
          required: true
    preconditions:
      - object: ProductModel
        rule: unique_identity_required

  - name: create_product_variant
    label: Create Product Variant
    description: Create a sellable product variant under a product model
    target:
      object: ProductVariant
    input:
      fields:
        - name: variant_code
          type: string
          required: true
        - name: product_model_code
          type: string
          required: true
    preconditions:
      - object: ProductModel
        rule: must_exist

  - name: inbound_inventory
    label: Inbound Inventory
    description: Increase inventory quantity for a product variant in a location
    target:
      object: InventoryItem
    input:
      fields:
        - name: inventory_key
          type: string
          required: true
        - name: variant_code
          type: string
          required: true
        - name: location_code
          type: string
          required: true
        - name: quantity
          type: integer
          required: true
    preconditions:
      - object: ProductVariant
        rule: must_exist

  - name: create_sales_order
    label: Create Sales Order
    description: Create a draft sales order
    target:
      object: SalesOrder
    input:
      fields:
        - name: order_number
          type: string
          required: true
        - name: customer_name
          type: string
          required: true
    preconditions:
      - object: SalesOrder
        rule: unique_identity_required

  - name: add_sales_order_line
    label: Add Sales Order Line
    description: Add a line to a sales order for a specific product variant
    target:
      object: SalesOrderLine
    input:
      fields:
        - name: line_key
          type: string
          required: true
        - name: order_number
          type: string
          required: true
        - name: variant_code
          type: string
          required: true
        - name: quantity
          type: integer
          required: true
    preconditions:
      - object: SalesOrder
        rule: must_exist
      - object: ProductVariant
        rule: must_exist

  - name: confirm_sales_order
    label: Confirm Sales Order
    description: Confirm a draft sales order
    target:
      object: SalesOrder
    input:
      fields:
        - name: order_number
          type: string
          required: true
    preconditions:
      - object: SalesOrder
        rule: must_exist
    effects:
      - type: request_transition
        target: SalesOrder
        to: confirmed
    error_model:
      known_errors:
        - code: ORDER_NOT_FOUND
          description: Sales order does not exist
          ai_focus:
            - object
        - code: INVALID_STATE
          description: Sales order is not in a state that allows confirmation
          ai_focus:
            - workflow
          suggested_next_steps:
            - fetch current order state
            - inspect allowed transitions
```

---

## Workflow

```yaml
workflows:
  - name: sales_order_workflow
    label: Sales Order Workflow
    description: Lifecycle of a sales order
    object: SalesOrder
    initial_state: draft
    states:
      - draft
      - confirmed
      - cancelled
    transitions:
      - name: confirm
        from: draft
        to: confirmed
        action: confirm_sales_order
```

---

## Permission

```yaml
permissions:
  roles:
    - name: product_admin
      label: Product Admin
      description: Maintains product definitions and variants
    - name: inventory_operator
      label: Inventory Operator
      description: Maintains inventory records
    - name: sales
      label: Sales
      description: Creates and confirms sales orders

  policies:
    - name: product_admin_actions
      subject:
        role: product_admin
      target:
        object: ProductModel
      allow:
        actions:
          - create_product_model
          - create_product_variant

    - name: inventory_operator_actions
      subject:
        role: inventory_operator
      target:
        object: InventoryItem
      allow:
        actions:
          - inbound_inventory

    - name: sales_order_actions
      subject:
        role: sales
      target:
        object: SalesOrder
      allow:
        actions:
          - create_sales_order
          - add_sales_order_line
          - confirm_sales_order
```

---

## Observed semantic gain from ownership

### Example 1: SalesOrderLine -> SalesOrder

In v0.2, the relation existed but lifecycle semantics were implicit.

In v0.3:

```yaml
- name: order
  type: many_to_one
  target: SalesOrder
  ownership: owned
```

This makes it explicit that the line is part of the order structure, not merely a reference.

### Example 2: SalesOrderLine -> ProductVariant

```yaml
- name: product_variant
  type: many_to_one
  target: ProductVariant
  ownership: referenced
```

This makes it explicit that the line points to a reusable external object rather than owning it.

---

## Current evaluation

### Positive

- ownership improves semantic clarity immediately
- child-vs-reference distinction becomes explicit
- AI has less hidden lifecycle inference to perform
- no business-specific primitive was introduced

### Risks to watch

- ownership must remain minimal and binary in early versions
- ownership should not evolve into a complex lifecycle engine
- ownership should clarify relation meaning, not replace workflow or action logic

---

## Status

v0.3 validation draft with `Relation.ownership` under evaluation.
