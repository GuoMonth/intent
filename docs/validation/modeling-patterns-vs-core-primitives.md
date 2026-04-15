# Modeling Patterns vs Core Primitives

## Purpose

This document clarifies an important validation principle:

> not every recurring business concept should become a platform primitive

The platform aims to build:

> minimal, clear, composable, and AI-learnable LEGO-like primitives

This means the platform should avoid expanding its core model every time a realistic business concept appears.

---

## Core principle

When a validation scenario reveals modeling pressure, we must ask:

1. is this a true semantic gap in the platform core?
2. or is this a domain modeling pattern that can be composed from existing primitives?

Only the first category should influence core semantic expansion.

---

## Why this matters

If every business concept becomes a platform primitive, the model will rapidly bloat.

Examples of risky concept expansion:

- SKU
- batch
- serial number
- BOM
- shipment
- invoice
- approval chain

This would eventually turn the platform into a prebuilt ERP-like concept library instead of a composable semantic system.

---

## Desired semantic goal

The platform should aim for:

- minimal primitives
- clear boundaries
- composable building blocks
- AI-learnable semantics

A useful metaphor is:

> build LEGO bricks, not pre-glued toys

---

## SKU as an example

SKU is important in many business domains, but it should not automatically become a platform primitive.

Instead, SKU should first be treated as a **domain modeling pattern**.

It may be modeled using existing concepts such as:

- Object
- Field
- Relation
- Identity
- Action

For example, a domain may choose to define:

- ProductModel
- ProductVariant
- InventoryItem

without requiring the platform itself to define a special `SKU` primitive.

---

## Core primitive vs modeling pattern

### Core primitive

A concept belongs in the platform core when:

- it is broadly necessary across many domains
- it cannot be cleanly expressed using current primitives
- its absence creates repeated semantic ambiguity
- adding it improves clarity more than it increases complexity

### Modeling pattern

A concept should remain a modeling pattern when:

- it is domain-specific or industry-shaped
- it can be composed from existing primitives
- its structure may vary significantly by business context
- making it a primitive would increase platform bias or bloat

---

## Validation implication

During semantic validation:

- do not immediately add new primitives because a scenario feels realistic
- first test whether the scenario can be expressed as a composition pattern
- only promote a concept into the core model if repeated validation proves a true semantic gap

---

## Current judgment

At the current stage:

- SKU is better treated as a modeling pattern, not a core primitive
- the validation task is to test whether the current primitives can express product variants, inventory, and orders clearly enough
- the burden of proof for adding new primitives should remain high

---

## Status

Guideline for Phase 2 semantic validation.
