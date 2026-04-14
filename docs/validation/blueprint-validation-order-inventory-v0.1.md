# Blueprint Validation - Order & Inventory (v0.1)

## Purpose

This document defines a minimal Blueprint example based on a simple business scenario:

- product category and SKU definition
- inventory inbound
- sales order creation and confirmation

The goal is to validate whether the current semantic model is sufficient and consistent.

---

## Domain

```yaml
domain: order_inventory
```

---

## Objects

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
      - name: category
        type: string
        label: Category
    traits:
      - importable
      - exportable

  - name: InventoryItem
    label: Inventory Item
    description: Inventory record for a product in a location
    identity:
      business_keys: [product_sku]
    fields:
      - name: product_sku
        type: string
        label: Product SKU
        required: true
      - name: quantity
        type: integer
        label: Quantity
        required: true
    relations:
      - name: product
        type: many_to_one
        target: Product

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
    description: Line item inside a sales order
    identity:
      business_keys: []
    fields:
      - name: product_sku
        type: string
        label: Product SKU
        required: true
      - name: quantity
        type: integer
        label: Quantity
        required: true
    relations:
      - name: order
        type: many_to_one
        target: SalesOrder
      - name: product
        type: many_to_one
        target: Product
```

---

## Actions

```yaml
actions:
  - name: create_product
    target:
      object: Product
    input:
      fields:
        - name: sku
          type: string
          required: true
        - name: name
          type: string
          required: true

  - name: inbound_inventory
    target:
      object: InventoryItem
    input:
      fields:
        - name: product_sku
          type: string
          required: true
        - name: quantity
          type: integer
          required: true

  - name: create_sales_order
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

  - name: confirm_sales_order
    target:
      object: SalesOrder
    input:
      fields:
        - name: order_number
          type: string
          required: true
    effects:
      - type: request_transition
        target: SalesOrder
        to: confirmed
```

---

## Workflow

```yaml
workflows:
  - name: sales_order_workflow
    object: SalesOrder
    initial_state: draft
    states: [draft, confirmed]
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
    - name: sales

  policies:
    - name: sales_order_basic
      subject:
        role: sales
      target:
        object: SalesOrder
      allow:
        actions:
          - create_sales_order
          - confirm_sales_order
```

---

## Initial observations

This example intentionally avoids:

- complex workflow
- multi-object orchestration
- advanced permission conditions

The focus is to test:

- object relationships clarity
- action boundaries
- workflow interaction

---

## Open validation questions

1. Is Product category sufficiently modeled as a simple field?
2. Should SKU spec be a separate object instead of field?
3. Is InventoryItem identity definition sufficient?
4. Should SalesOrderLine require its own identity?
5. Are actions sufficiently expressive without extra abstraction?

---

## Status

Initial validation blueprint draft.
