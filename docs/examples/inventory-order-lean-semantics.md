# Inventory / Order Semantic Example (Lean-oriented)

## Purpose

This document provides a concrete example of how Blueprint semantic concepts can be mapped into a Lean-oriented model.

It is not a full Lean project yet.
It is a semantic bridge between Blueprint definition and Lean formalization.

---

## Entities

- Product
- Warehouse
- Inventory
- SalesOrder
- SalesOrderLine

---

## Key relationships

- SalesOrder contains multiple SalesOrderLine
- SalesOrderLine references Product and Warehouse
- Inventory represents (Product × Warehouse)

---

## Core invariant examples

- available = onHand - reserved
- reserved ≤ onHand
- reservation does not change onHand
- shipment decreases onHand and reserved consistently

---

## Action examples

### ConfirmOrder

Preconditions:

- order.status = Draft
- order.lines is not empty
- all line.qty > 0

Postconditions:

- order.status = Confirmed

---

### ReserveInventory

Preconditions:

- order.status = Confirmed
- for each line: inventory.available ≥ line.qty

Postconditions:

- inventory.reserved increases
- order.status = Reserved

---

### ShipOrder

Preconditions:

- order.status = Reserved

Postconditions:

- inventory.onHand decreases
- inventory.reserved decreases
- order.status = Shipped

---

### CancelOrder

Preconditions:

- order.status ∈ {Draft, Confirmed, Reserved}

Postconditions:

- if reserved, release inventory
- order.status = Cancelled

---

## Algorithm focus: deduction

A simplified all-or-nothing deduction algorithm:

Input:

- inventory state
- order lines

Guarantees:

- succeeds only if all lines can be satisfied
- no partial deduction
- total deduction equals sum of line quantities
- state remains unchanged on failure

---

## What should be proven in Lean

- deduction never produces negative inventory semantics
- deduction preserves total consistency
- failure leaves state unchanged
- reserve followed by release restores original reserved value

---

## How this connects to generation

From this semantic definition, the system should be able to derive:

- Python / Go domain logic skeletons
- validation tests
- negative test cases
- workflow transition tests

The Lean formalization acts as the reference truth.

---

## Next step

Convert this document into actual Lean structures:

- structure definitions
- invariant predicates
- action specs
- executable state transitions
- algorithm definitions + proofs

Then connect it to test and code generation.
