# Blueprint Object Model (v0.1)

## Purpose

Object is the center of the Blueprint semantic model.

It represents a business entity definition inside the platform and serves as the anchor for:

- fields
- relations
- actions
- workflows
- permissions
- attachments
- import/export mappings

Object is not defined as a direct database table abstraction.
It is defined as a business-level entity model.

---

## Position in Blueprint

Blueprint v0.1 treats Object as the primary structural unit.

A Blueprint may define multiple Objects.
Each Object may later be compiled into runtime artifacts such as:

- storage definitions
- API exposure
- action targets
- workflow state holders
- permission scopes
- import/export schemas

---

## Minimal semantic definition

An Object should answer the following questions:

1. What business entity does it represent?
2. What attributes does it contain?
3. How is it identified?
4. What other objects is it related to?
5. Does it hold state?
6. What actions can target it?
7. What permissions are meaningful on it?

---

## Object v0.1 minimal fields

### 1. name
Stable object identifier inside the Blueprint.

Examples:
- Product
- Warehouse
- InventoryItem
- SalesOrder
- SalesOrderLine

Rules:
- required
- unique within Blueprint
- stable enough for references from other sections

### 2. label
Human-readable display name.

Examples:
- Product
- Warehouse
- Sales Order

Rules:
- required
- intended for human-facing rendering and AI explanations

### 3. description
Short semantic explanation of the object.

Examples:
- Represents a sellable product definition
- Represents a customer sales order

Rules:
- recommended
- useful for AI generation and repair

### 4. fields
List of field definitions owned by the object.

Rules:
- required
- must contain at least one business field or identifier field

### 5. identity
Definition of how this object is uniquely identified at the business level.

Examples:
- sku
- order_number
- warehouse_code
- system-generated id + business number

Rules:
- required
- may reference one or more fields
- should distinguish system identity from business identity when necessary

### 6. relations
List of business relations to other objects.

Examples:
- SalesOrder has many SalesOrderLine
- InventoryItem belongs to Warehouse

Rules:
- optional in v0.1
- should reference existing object names

### 7. state_model
Optional state holder definition.

Examples:
- draft -> confirmed -> shipped -> completed
- active / inactive

Rules:
- optional
- when present, should later align with Workflow definitions

### 8. traits
Optional semantic traits that influence platform behavior.

Examples:
- attachable
- importable
- exportable
- auditable
- approvable

Rules:
- optional in v0.1
- useful for compilation and AI guidance

---

## Field model assumptions

For v0.1, each Object field is expected to carry at least:

- name
- type
- label
- description
- required

Field-level schema is not fully finalized in this document.

---

## Identity semantics

Object identity should not be reduced to only database primary key thinking.

Two identity layers may exist:

1. system identity
   - internal immutable id
2. business identity
   - human-meaningful identifier such as order number or sku

Blueprint should primarily care about business identity semantics.

---

## Object design principles

### Object is business-first
Object should reflect business meaning, not persistence layout.

### Object is stable
An Object should be a stable reference point for actions, permissions, and workflows.

### Object is composable
Objects should be designed so plugins and modules can reason about them clearly.

### Object is AI-readable
Descriptions, labels, and identities should be explicit enough for AI to use reliably.

---

## Example

```yaml
objects:
  - name: Product
    label: Product
    description: Represents a sellable product definition
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
      - name: unit_price
        type: decimal
        label: Unit Price
        required: false
    traits:
      - importable
      - exportable
      - auditable
```

---

## Open questions

- should state_model remain inside Object or only in Workflow?
- how should object inheritance / extension work in future versions?
- should traits be free-form or enumerated?
- how should object-level validation rules be attached?

---

## Status

v0.1 draft. Intended to support next-step schema design for Blueprint.
