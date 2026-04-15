# Blueprint Validation - Fruit Wholesale (v1)

## Purpose

This document turns the fruit wholesale scenario into a Blueprint-oriented semantic validation draft.

The goal is not to finalize domain design or runtime behavior.
The goal is to verify whether the current semantic primitives plus modeling patterns are sufficient to express a more realistic ERP-like scenario with:

- mixed measurement units
- inbound and sales records
- reservation and fulfillment separation
- daily stock count and adjustment
- multiple inventory decrease reasons

---

## Validation stance

This draft follows the current Phase 2 principles:

- prefer composition over primitive expansion
- keep stable meaning in semantics
- keep dynamic coordination in orchestration
- treat domain-heavy concepts as modeling patterns first

This document therefore intentionally avoids introducing new platform primitives.

---

## Domain

```yaml
domain: fruit_wholesale
```

---

## Objects

```yaml
objects:
  - name: Product
    label: Product
    description: Sellable and stockable fruit item
    identity:
      business_keys: [product_code]
    fields:
      - name: product_code
        type: string
        label: Product Code
        required: true
      - name: name
        type: string
        label: Product Name
        required: true
      - name: category
        type: string
        label: Category
        required: false
      - name: default_stock_unit
        type: string
        label: Default Stock Unit
        required: true
    traits:
      - auditable
      - importable
      - exportable

  - name: UnitConversionRule
    label: Unit Conversion Rule
    description: Conversion rule between one business unit and the normalized stock unit for a product
    identity:
      business_keys: [conversion_key]
    fields:
      - name: conversion_key
        type: string
        label: Conversion Key
        required: true
      - name: from_unit
        type: string
        label: From Unit
        required: true
      - name: to_unit
        type: string
        label: To Unit
        required: true
      - name: multiplier
        type: decimal
        label: Multiplier
        required: true
      - name: rounding_policy
        type: string
        label: Rounding Policy
        required: false
    relations:
      - name: product
        type: many_to_one
        target: Product
        inverse: unit_conversion_rules
        ownership: referenced
    traits:
      - auditable

  - name: InventoryBalance
    label: Inventory Balance
    description: Current stock balance for one product in one location expressed in normalized stock unit
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
      - name: on_hand_quantity
        type: decimal
        label: On-hand Quantity
        required: true
      - name: reserved_quantity
        type: decimal
        label: Reserved Quantity
        required: true
      - name: available_quantity
        type: decimal
        label: Available Quantity
        required: true
      - name: stock_unit
        type: string
        label: Stock Unit
        required: true
    relations:
      - name: product
        type: many_to_one
        target: Product
        inverse: inventory_balances
        ownership: referenced
    traits:
      - auditable

  - name: InboundBatch
    label: Inbound Batch
    description: One inbound batch or truck arrival
    identity:
      business_keys: [batch_number]
    fields:
      - name: batch_number
        type: string
        label: Batch Number
        required: true
      - name: inbound_time
        type: datetime
        label: Inbound Time
        required: true
      - name: supplier_name
        type: string
        label: Supplier Name
        required: false
      - name: location_code
        type: string
        label: Location Code
        required: true
    traits:
      - auditable

  - name: InboundLine
    label: Inbound Line
    description: One product entry within an inbound batch
    identity:
      business_keys: [inbound_line_key]
    fields:
      - name: inbound_line_key
        type: string
        label: Inbound Line Key
        required: true
      - name: entered_quantity
        type: decimal
        label: Entered Quantity
        required: true
      - name: entered_unit
        type: string
        label: Entered Unit
        required: true
      - name: normalized_quantity
        type: decimal
        label: Normalized Quantity
        required: true
    relations:
      - name: batch
        type: many_to_one
        target: InboundBatch
        inverse: lines
        ownership: owned
      - name: product
        type: many_to_one
        target: Product
        inverse: inbound_lines
        ownership: referenced
    traits:
      - auditable

  - name: SalesTicket
    label: Sales Ticket
    description: Same-day actual sale ticket
    identity:
      business_keys: [ticket_number]
    fields:
      - name: ticket_number
        type: string
        label: Ticket Number
        required: true
      - name: sale_time
        type: datetime
        label: Sale Time
        required: true
      - name: customer_name
        type: string
        label: Customer Name
        required: false
      - name: total_amount
        type: decimal
        label: Total Amount
        required: false
      - name: actual_received_amount
        type: decimal
        label: Actual Received Amount
        required: false
      - name: rounding_adjustment_amount
        type: decimal
        label: Rounding Adjustment Amount
        required: false
    traits:
      - auditable
      - attachable

  - name: SalesTicketLine
    label: Sales Ticket Line
    description: One sales line within a sales ticket
    identity:
      business_keys: [ticket_line_key]
    fields:
      - name: ticket_line_key
        type: string
        label: Ticket Line Key
        required: true
      - name: entered_quantity
        type: decimal
        label: Entered Quantity
        required: true
      - name: entered_unit
        type: string
        label: Entered Unit
        required: true
      - name: normalized_quantity
        type: decimal
        label: Normalized Quantity
        required: true
      - name: standard_unit_price
        type: decimal
        label: Standard Unit Price
        required: false
      - name: actual_unit_price
        type: decimal
        label: Actual Unit Price
        required: true
      - name: line_amount
        type: decimal
        label: Line Amount
        required: true
    relations:
      - name: ticket
        type: many_to_one
        target: SalesTicket
        inverse: lines
        ownership: owned
      - name: product
        type: many_to_one
        target: Product
        inverse: sales_ticket_lines
        ownership: referenced
    traits:
      - auditable

  - name: ReservationOrder
    label: Reservation Order
    description: Future pickup reservation order that locks inventory before actual sale
    identity:
      business_keys: [reservation_number]
    fields:
      - name: reservation_number
        type: string
        label: Reservation Number
        required: true
      - name: reserved_at
        type: datetime
        label: Reserved At
        required: true
      - name: pickup_date
        type: date
        label: Pickup Date
        required: true
      - name: customer_name
        type: string
        label: Customer Name
        required: false
    traits:
      - auditable
      - attachable

  - name: ReservationLine
    label: Reservation Line
    description: One reserved product line within a reservation order
    identity:
      business_keys: [reservation_line_key]
    fields:
      - name: reservation_line_key
        type: string
        label: Reservation Line Key
        required: true
      - name: entered_quantity
        type: decimal
        label: Entered Quantity
        required: true
      - name: entered_unit
        type: string
        label: Entered Unit
        required: true
      - name: normalized_quantity
        type: decimal
        label: Normalized Quantity
        required: true
      - name: expected_unit_price
        type: decimal
        label: Expected Unit Price
        required: false
    relations:
      - name: reservation_order
        type: many_to_one
        target: ReservationOrder
        inverse: lines
        ownership: owned
      - name: product
        type: many_to_one
        target: Product
        inverse: reservation_lines
        ownership: referenced
    traits:
      - auditable

  - name: DailyStockCount
    label: Daily Stock Count
    description: End-of-day stock count baseline for the next day
    identity:
      business_keys: [stock_count_number]
    fields:
      - name: stock_count_number
        type: string
        label: Stock Count Number
        required: true
      - name: stock_date
        type: date
        label: Stock Date
        required: true
      - name: location_code
        type: string
        label: Location Code
        required: true
      - name: count_mode
        type: string
        label: Count Mode
        required: true
    traits:
      - auditable

  - name: StockAdjustment
    label: Stock Adjustment
    description: Inventory change caused by loss, count difference, or other adjustment reason
    identity:
      business_keys: [adjustment_number]
    fields:
      - name: adjustment_number
        type: string
        label: Adjustment Number
        required: true
      - name: reason_code
        type: string
        label: Reason Code
        required: true
      - name: quantity_delta
        type: decimal
        label: Quantity Delta
        required: true
      - name: stock_unit
        type: string
        label: Stock Unit
        required: true
      - name: note
        type: string
        label: Note
        required: false
    relations:
      - name: product
        type: many_to_one
        target: Product
        inverse: stock_adjustments
        ownership: referenced
      - name: stock_count
        type: many_to_one
        target: DailyStockCount
        inverse: adjustments
        ownership: referenced
    traits:
      - auditable
```

---

## Actions

```yaml
actions:
  - name: create_product
    label: Create Product
    description: Create a product definition for a stockable and sellable fruit item
    target:
      object: Product
    input:
      fields:
        - name: product_code
          type: string
          required: true
        - name: name
          type: string
          required: true
        - name: default_stock_unit
          type: string
          required: true
    preconditions:
      - object: Product
        rule: unique_identity_required

  - name: define_unit_conversion_rule
    label: Define Unit Conversion Rule
    description: Define how one unit converts into the normalized stock unit for a product
    target:
      object: UnitConversionRule
    input:
      fields:
        - name: conversion_key
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: from_unit
          type: string
          required: true
        - name: to_unit
          type: string
          required: true
        - name: multiplier
          type: decimal
          required: true
    preconditions:
      - object: Product
        rule: must_exist

  - name: create_inbound_batch
    label: Create Inbound Batch
    description: Create one inbound batch header
    target:
      object: InboundBatch
    input:
      fields:
        - name: batch_number
          type: string
          required: true
        - name: inbound_time
          type: datetime
          required: true
        - name: location_code
          type: string
          required: true
    preconditions:
      - object: InboundBatch
        rule: unique_identity_required

  - name: add_inbound_line
    label: Add Inbound Line
    description: Add one product line to an inbound batch and express both entered and normalized quantity
    target:
      object: InboundLine
    input:
      fields:
        - name: inbound_line_key
          type: string
          required: true
        - name: batch_number
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: entered_quantity
          type: decimal
          required: true
        - name: entered_unit
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: InboundBatch
        rule: must_exist
      - object: Product
        rule: must_exist

  - name: apply_inbound_to_inventory
    label: Apply Inbound To Inventory
    description: Increase inventory balance using the normalized inbound quantity
    target:
      object: InventoryBalance
    input:
      fields:
        - name: inventory_key
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: location_code
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: Product
        rule: must_exist

  - name: create_sales_ticket
    label: Create Sales Ticket
    description: Create a draft same-day sales ticket
    target:
      object: SalesTicket
    input:
      fields:
        - name: ticket_number
          type: string
          required: true
        - name: sale_time
          type: datetime
          required: true
    preconditions:
      - object: SalesTicket
        rule: unique_identity_required

  - name: add_sales_ticket_line
    label: Add Sales Ticket Line
    description: Add one actual sale line with entered unit, normalized quantity, and actual price
    target:
      object: SalesTicketLine
    input:
      fields:
        - name: ticket_line_key
          type: string
          required: true
        - name: ticket_number
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: entered_quantity
          type: decimal
          required: true
        - name: entered_unit
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
        - name: actual_unit_price
          type: decimal
          required: true
    preconditions:
      - object: SalesTicket
        rule: must_exist
      - object: Product
        rule: must_exist

  - name: confirm_sales_ticket
    label: Confirm Sales Ticket
    description: Confirm a sales ticket and request actual inventory deduction
    target:
      object: SalesTicket
    input:
      fields:
        - name: ticket_number
          type: string
          required: true
    preconditions:
      - object: SalesTicket
        rule: must_exist
    effects:
      - type: request_transition
        target: SalesTicket
        to: confirmed
    error_model:
      known_errors:
        - code: TICKET_NOT_FOUND
          description: Sales ticket does not exist
          ai_focus:
            - object
        - code: INVALID_STATE
          description: Sales ticket is not in a state that allows confirmation
          ai_focus:
            - workflow
        - code: INVENTORY_NOT_AVAILABLE
          description: Inventory is not sufficient for the normalized sold quantity
          ai_focus:
            - object
            - action

  - name: deduct_inventory_for_sale
    label: Deduct Inventory For Sale
    description: Deduct normalized quantity from inventory because of actual sale
    target:
      object: InventoryBalance
    input:
      fields:
        - name: inventory_key
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: InventoryBalance
        rule: must_exist

  - name: create_reservation_order
    label: Create Reservation Order
    description: Create a draft reservation order for future pickup
    target:
      object: ReservationOrder
    input:
      fields:
        - name: reservation_number
          type: string
          required: true
        - name: reserved_at
          type: datetime
          required: true
        - name: pickup_date
          type: date
          required: true
    preconditions:
      - object: ReservationOrder
        rule: unique_identity_required

  - name: add_reservation_line
    label: Add Reservation Line
    description: Add one reserved product line that will later require stock lock
    target:
      object: ReservationLine
    input:
      fields:
        - name: reservation_line_key
          type: string
          required: true
        - name: reservation_number
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: entered_quantity
          type: decimal
          required: true
        - name: entered_unit
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: ReservationOrder
        rule: must_exist
      - object: Product
        rule: must_exist

  - name: confirm_reservation_order
    label: Confirm Reservation Order
    description: Confirm a reservation order and request inventory lock
    target:
      object: ReservationOrder
    input:
      fields:
        - name: reservation_number
          type: string
          required: true
    preconditions:
      - object: ReservationOrder
        rule: must_exist
    effects:
      - type: request_transition
        target: ReservationOrder
        to: reserved

  - name: reserve_inventory
    label: Reserve Inventory
    description: Lock inventory for a confirmed reservation order without deducting actual stock yet
    target:
      object: InventoryBalance
    input:
      fields:
        - name: inventory_key
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: InventoryBalance
        rule: must_exist

  - name: fulfill_reservation_order
    label: Fulfill Reservation Order
    description: Convert a reserved order into an actual sale and request actual inventory deduction
    target:
      object: ReservationOrder
    input:
      fields:
        - name: reservation_number
          type: string
          required: true
    preconditions:
      - object: ReservationOrder
        rule: must_exist
    effects:
      - type: request_transition
        target: ReservationOrder
        to: fulfilled

  - name: release_reserved_inventory
    label: Release Reserved Inventory
    description: Release locked inventory when a reservation order is cancelled
    target:
      object: InventoryBalance
    input:
      fields:
        - name: inventory_key
          type: string
          required: true
        - name: normalized_quantity
          type: decimal
          required: true
    preconditions:
      - object: InventoryBalance
        rule: must_exist

  - name: cancel_reservation_order
    label: Cancel Reservation Order
    description: Cancel a reservation order and request inventory release if inventory was locked
    target:
      object: ReservationOrder
    input:
      fields:
        - name: reservation_number
          type: string
          required: true
    preconditions:
      - object: ReservationOrder
        rule: must_exist
    effects:
      - type: request_transition
        target: ReservationOrder
        to: cancelled

  - name: create_daily_stock_count
    label: Create Daily Stock Count
    description: Create the end-of-day stock count document for one location and date
    target:
      object: DailyStockCount
    input:
      fields:
        - name: stock_count_number
          type: string
          required: true
        - name: stock_date
          type: date
          required: true
        - name: location_code
          type: string
          required: true
        - name: count_mode
          type: string
          required: true
    preconditions:
      - object: DailyStockCount
        rule: unique_identity_required

  - name: record_stock_adjustment
    label: Record Stock Adjustment
    description: Record inventory delta caused by count difference, loss, or other explicit reason
    target:
      object: StockAdjustment
    input:
      fields:
        - name: adjustment_number
          type: string
          required: true
        - name: product_code
          type: string
          required: true
        - name: reason_code
          type: string
          required: true
        - name: quantity_delta
          type: decimal
          required: true
        - name: stock_unit
          type: string
          required: true
    preconditions:
      - object: Product
        rule: must_exist

  - name: confirm_daily_stock_count
    label: Confirm Daily Stock Count
    description: Confirm the daily stock count and request next-day baseline update
    target:
      object: DailyStockCount
    input:
      fields:
        - name: stock_count_number
          type: string
          required: true
    preconditions:
      - object: DailyStockCount
        rule: must_exist
    effects:
      - type: request_transition
        target: DailyStockCount
        to: confirmed
```

---

## Workflows

```yaml
workflows:
  - name: sales_ticket_workflow
    label: Sales Ticket Workflow
    description: Lifecycle of a same-day actual sale ticket
    object: SalesTicket
    initial_state: draft
    states:
      - draft
      - confirmed
      - voided
    transitions:
      - name: confirm
        from: draft
        to: confirmed
        action: confirm_sales_ticket

  - name: reservation_order_workflow
    label: Reservation Order Workflow
    description: Lifecycle of a reservation order before actual sale fulfillment
    object: ReservationOrder
    initial_state: draft
    states:
      - draft
      - reserved
      - fulfilled
      - cancelled
    transitions:
      - name: confirm
        from: draft
        to: reserved
        action: confirm_reservation_order
      - name: fulfill
        from: reserved
        to: fulfilled
        action: fulfill_reservation_order
      - name: cancel
        from: draft
        to: cancelled
        action: cancel_reservation_order
      - name: cancel_reserved
        from: reserved
        to: cancelled
        action: cancel_reservation_order

  - name: daily_stock_count_workflow
    label: Daily Stock Count Workflow
    description: Lifecycle of an end-of-day stock count baseline document
    object: DailyStockCount
    initial_state: draft
    states:
      - draft
      - confirmed
    transitions:
      - name: confirm
        from: draft
        to: confirmed
        action: confirm_daily_stock_count
```

---

## Permission

```yaml
permissions:
  roles:
    - name: product_admin
      label: Product Admin
      description: Maintains product definitions and conversion rules
    - name: warehouse_operator
      label: Warehouse Operator
      description: Manages inbound, inventory, stock count, and adjustments
    - name: sales_operator
      label: Sales Operator
      description: Manages same-day sales tickets and reservation orders

  policies:
    - name: product_admin_actions
      subject:
        role: product_admin
      target:
        object: Product
      allow:
        actions:
          - create_product
          - define_unit_conversion_rule

    - name: warehouse_inbound_actions
      subject:
        role: warehouse_operator
      target:
        object: InboundBatch
      allow:
        actions:
          - create_inbound_batch
          - add_inbound_line
          - apply_inbound_to_inventory

    - name: warehouse_inventory_actions
      subject:
        role: warehouse_operator
      target:
        object: InventoryBalance
      allow:
        actions:
          - apply_inbound_to_inventory
          - deduct_inventory_for_sale
          - reserve_inventory
          - release_reserved_inventory

    - name: warehouse_stock_count_actions
      subject:
        role: warehouse_operator
      target:
        object: DailyStockCount
      allow:
        actions:
          - create_daily_stock_count
          - record_stock_adjustment
          - confirm_daily_stock_count

    - name: sales_actions
      subject:
        role: sales_operator
      target:
        object: SalesTicket
      allow:
        actions:
          - create_sales_ticket
          - add_sales_ticket_line
          - confirm_sales_ticket
          - create_reservation_order
          - add_reservation_line
          - confirm_reservation_order
          - fulfill_reservation_order
          - cancel_reservation_order
```

---

## Semantic interpretation

### 1. Unit conversion remains a modeling pattern

This draft introduces `UnitConversionRule` as a normal Object.

This is intentional.
The scenario clearly needs unit conversion, but the current evidence still supports treating conversion as a reusable modeling pattern rather than a new platform primitive.

### 2. Entered quantity and normalized quantity should coexist

For inbound, sales, and reservation lines, the model keeps both:

- entered quantity + entered unit
- normalized quantity

This preserves business traceability while keeping inventory operations comparable.

### 3. Reservation and actual sale should remain separate semantic objects

`ReservationOrder` is not modeled as a state of `SalesTicket`.

This keeps the semantic boundary clear:

- reservation locks inventory
- actual sale deducts inventory and records real payment

This separation reduces hidden inference pressure on AI.

### 4. Inventory decrease reason should stay explicit

Inventory change caused by actual sale should not be semantically merged with loss or count difference.

This draft therefore keeps `StockAdjustment` as a separate object for explicit non-sale deltas.

### 5. Daily stock count is a baseline authority, not just a note

The stock count object is modeled with its own workflow because the scenario says the confirmed result becomes the next-day baseline.

That makes it more than a passive attachment.

---

## Boundary judgment

### Best fit for semantic layer

The following appear stable enough for semantic modeling:

- Product
- UnitConversionRule
- InventoryBalance
- InboundBatch / InboundLine
- SalesTicket / SalesTicketLine
- ReservationOrder / ReservationLine
- DailyStockCount
- StockAdjustment
- reusable Actions for inbound, reservation, sale, adjustment, and stock count confirmation

### Best fit for orchestration layer

The following still appear orchestration-heavy:

- choosing which conversion rule applies under ambiguous real-world conditions
- cross-location allocation when one reservation line can be satisfied from multiple locations
- partial reservation success and fallback decisions
- transforming a fulfilled reservation into one or more actual sales artifacts
- automatic end-of-day computation before human stock count confirmation
- compensation logic after mixed operational failures

---

## Validation findings from this draft

### Positive signals

- current primitives can express the scenario without obvious primitive explosion
- ownership remains useful for header-line structure
- workflow remains useful for reservation and stock count lifecycle authority
- explicit action contracts help keep reservation and sale behavior separate

### Pressure points

- quantity normalization becomes a repeated modeling pattern
- inventory balance and inventory movement semantics may need a dedicated pattern library
- reservation fulfillment may later require a more formal cross-object execution pattern
- decimal precision and rounding semantics may need stronger cross-document guidance

### Current judgment

The fruit wholesale scenario increases complexity significantly, but it still does not yet prove that the platform needs a new core primitive.

The strongest conclusion at this stage is:

> the platform likely needs more reusable modeling patterns before it needs more primitives

---

## Status

Initial fruit wholesale Blueprint validation draft recorded.
