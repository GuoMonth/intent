# Batch / Inventory Modeling Pattern

## Purpose

This document explores a deeper inventory pattern under a realistic order-and-inventory background.

The goal is to test the boundary between:

- what should be expressed directly by core primitives
- what should be expressed as modeling patterns
- what should be left to AI-driven glue logic calling Actions

The business background includes:

- product inbound
- product outbound
- stock count confirmation
- stock reservation after order submission
- stock restoration after cancellation or return

---

## Why this pattern matters

ERP inventory behavior is often much more complex than a simple quantity field.

Real systems may include:

- inbound records
- outbound records
- reservations
- adjustments
- stock count confirmation
- batch or lot tracking
- standard and non-standard operations

This creates strong pressure on the semantic system.

The key question is not only:

> can the model express it?

But also:

> which parts should be native semantic structure, and which parts should remain programmable behavior?

---

## Initial boundary question

A minimal semantic system should avoid introducing too many domain-specific primitives.

However, if the model is too sparse, realistic inventory operations may become too indirect or too dependent on custom code.

This pattern therefore examines where the correct boundary should be.

---

## Candidate sub-scenarios

1. inventory inbound
2. inventory outbound
3. stock count confirmation
4. reservation after order submission
5. restoration after cancellation or return

---

## Current working assumption

At the current stage, likely candidates are:

### Likely semantic structure
- ProductVariant
- InventoryItem
- maybe StockMovement or InventoryAdjustment as normal Objects if needed
- Relation ownership where needed
- Action contracts for inventory operations
- Workflow only where true state lifecycle exists

### Likely programmable behavior
- reservation orchestration across multiple related objects
- custom restoration logic after return or cancellation
- non-standard operational sequences
- exception handling flows and compensation logic

---

## Status

Initial exploration draft. No final conclusion yet.
