# Decision 0004 - Relation vs object_ref semantics

## Context

The Blueprint model includes both:

- Relation as a first-class business relationship definition
- object_ref as a possible field type

Without a clear boundary, AI and plugin generation may produce duplicated or conflicting models, such as defining the same business connection both as a Relation and as a field reference.

---

## Decision

In Blueprint v0.1:

- **Relation** is the canonical way to define business relationships between Objects
- **object_ref** is allowed only for weak reference semantics or system-oriented references

Examples of allowed `object_ref` usage:
- created_by
- approved_by
- last_modified_by

Examples that should use `Relation` instead:
- SalesOrder -> Customer
- SalesOrder -> SalesOrderLine
- InventoryItem -> Warehouse
- InventoryItem -> Product

---

## Why

This keeps the business graph explicit and prevents duplicated relationship semantics.

It also improves:

- AI generation consistency
- Blueprint validation clarity
- plugin compilation determinism
- future architecture evolution

---

## Consequences

- business object relationships should not be modeled as plain reference fields
- relation schema must be strong enough to capture direction, cardinality, and inverse meaning
- object_ref should remain a narrow and carefully interpreted field type
