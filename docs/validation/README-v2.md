# Phase 2 - Blueprint Semantic Validation (v2)

## Purpose

This phase validates the semantic design produced in Phase 1.

The goal is not to build a runnable demo yet.
The goal is to test whether the current Blueprint concepts are sufficient, clear, and non-conflicting when applied to a small but realistic business scenario.

---

## Core design goal

The platform aims to build:

> minimal, clear, composable, and AI-learnable LEGO-like primitives

This means:

- avoid unnecessary abstraction expansion
- avoid embedding domain-specific concepts too early
- focus on stable and reusable semantic building blocks

---

## Validation strategy

We use a minimal business background:

1. product definition and variant-like modeling
2. inventory inbound
3. sales order

This scenario is intentionally small but rich enough to test:

- Object / Field / Relation modeling
- Action boundaries
- Workflow state authority
- Permission scope
- Error model direction

---

## Validation rules

During this phase:

- do not add implementation logic
- do not build runtime code
- do not optimize for UI
- do not add new primitives unless a real semantic gap is proven

---

## Key validation principle

When encountering modeling difficulty:

- first attempt composition using existing primitives
- only consider adding new primitives if repeated patterns cannot be expressed cleanly

---

## Planned validation files

- `docs/validation/blueprint-validation-order-inventory-v0.1.md`
- `docs/validation/blueprint-validation-findings.md`
- `docs/validation/modeling-patterns-vs-core-primitives.md`

---

## Expected output

This phase should reveal:

- whether the model can express the scenario cleanly
- where ambiguity remains
- whether issues are due to missing primitives or modeling patterns

---

## Status

Validation phase active.
