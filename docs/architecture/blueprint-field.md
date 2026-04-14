# Blueprint Field Model (v0.1)

## Purpose

Field is the smallest structured business attribute unit inside an Object.

A Field defines:

- what data an Object carries
- what the data means
- what type constraints apply
- whether the data is required, derived, mutable, or identifying

Field is not merely a database column abstraction.
It is a business-semantic attribute definition.

---

## Position in Blueprint

Blueprint v0.1 treats Field as a child element of Object.

Fields do not exist independently at the top level.
They are always defined in the context of an Object.

---

## Field v0.1 minimal fields

### 1. name
Stable field identifier within the object.

Examples:
- sku
- name
- order_number
- quantity
- unit_price

Rules:
- required
- unique within the object
- stable enough for references from identity, actions, imports/exports, and views

### 2. label
Human-readable display name.

Examples:
- SKU
- Product Name
- Order Number
- Unit Price

Rules:
- required
- used for human display and AI explanation

### 3. description
Short semantic explanation of the field.

Examples:
- Unique stock keeping unit for the product
- External-facing order number
- Quantity currently available in the warehouse

Rules:
- recommended
- useful for AI generation, validation, and repair

### 4. type
Semantic field type.

Initial v0.1 types:
- string
- text
- integer
- decimal
- boolean
- date
- datetime
- enum
- object_ref

Rules:
- required
- should describe business data meaning, not low-level storage implementation

### 5. required
Whether the field must be present for the object to be considered valid.

Rules:
- required
- boolean

### 6. default
Optional default value or default strategy.

Examples:
- 0
- false
- current_datetime

Rules:
- optional
- should remain simple in v0.1

### 7. enum_values
Allowed values when type is enum.

Examples:
- [draft, confirmed, shipped, completed]

Rules:
- required when type is enum
- not allowed for non-enum fields

### 8. reference
Target object reference when type is object_ref.

Examples:
- Product
- Customer
- Warehouse

Rules:
- required when type is object_ref
- target object must exist in Blueprint

### 9. traits
Optional semantic field traits.

Examples:
- business_key
- immutable
- searchable
- filterable
- sortable
- system_managed
- derived

Rules:
- optional in v0.1
- useful for compilation and AI guidance

---

## Field type semantics

### string / text
Used for textual business data.

### integer / decimal
Used for quantities, prices, counts, and numeric business data.

### boolean
Used for yes/no business flags.

### date / datetime
Used for time-related business values.

### enum
Used for constrained symbolic values.

### object_ref
Used for direct object reference fields.
This should not replace Relation as a higher-level business relationship model, but may support certain reference semantics.

---

## Field design principles

### Field is business-semantic
A field should be defined in terms of business meaning, not raw storage shape.

### Field is stable
Field names should be stable enough for references from identity, actions, imports, views, and validation.

### Field is explicit
Important semantic behaviors should be explicit rather than implied.

### Field supports AI reasoning
Labels, descriptions, and traits should help AI understand how the field is used.

---

## Example

```yaml
fields:
  - name: sku
    label: SKU
    description: Unique stock keeping unit for the product
    type: string
    required: true
    traits:
      - business_key
      - searchable
  - name: unit_price
    label: Unit Price
    description: Standard selling price of the product
    type: decimal
    required: false
    default: 0
```

---

## Open questions

- should field validation rules be attached here in v0.1 or later?
- should object_ref stay as a field type or be deferred in favor of explicit relations only?
- should field traits be free-form or enumerated?

---

## Status

v0.1 draft. Intended to support Object schema stabilization.
