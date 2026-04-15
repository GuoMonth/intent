# Product Variant Modeling Pattern

## Purpose

This document defines a reusable modeling pattern for representing:

- abstract product definitions
- sellable product variants
- inventory tied to sellable units
- order lines tied to sellable units

This pattern exists to help AI use the existing platform primitives to construct a realistic business model **without turning domain concepts such as SKU into platform primitives**.

---

## Why this pattern exists

In many business domains, there is a difference between:

- a generic product definition
- a concrete sellable or stockable unit

Examples:

- T-shirt vs T-shirt / red / L
- phone model vs phone model / black / 256GB
- service plan vs service plan / annual / premium

The platform should not hard-code `SKU` as a primitive just because many domains need this distinction.

Instead, the distinction should be modeled compositionally.

---

## Pattern intent

This pattern answers the question:

> how can AI model a product family and its concrete sellable variants using existing primitives?

The answer is to use:

- one Object for the abstract product definition
- one Object for the concrete sellable variant
- Relations between them
- Identity at the appropriate level
- downstream business objects such as InventoryItem and SalesOrderLine linked to the concrete variant

---

## Pattern structure

### Object roles

#### ProductModel
Represents the shared product definition.

Typical meaning:
- product family
- common business name
- reusable category and descriptive fields

#### ProductVariant
Represents a concrete sellable / stockable unit.

Typical meaning:
- one combination of distinguishing attributes
- one business identity used in inventory and ordering

---

## Recommended primitive composition

```yaml
objects:
  - name: ProductModel
    identity:
      business_keys: [model_code]

  - name: ProductVariant
    identity:
      business_keys: [variant_code]
    relations:
      - name: product_model
        type: many_to_one
        target: ProductModel
        inverse: variants
```

This keeps the model explicit without adding a new platform primitive.

---

## Semantic guidance

### What should belong to ProductModel

Examples:
- model_code
- product name
- category
- generic description
- common brand / family-level metadata

### What should belong to ProductVariant

Examples:
- variant_code
- spec_summary
- sellable or stockable identity
- optional concrete pricing / availability semantics

---

## Variant expression

This pattern does **not** require the platform to define a built-in `SKU` primitive.

A business domain may choose to name the concrete object:

- ProductVariant
- SKU
- SellableUnit
- ItemVariant

But at the platform semantic level, it is still just an Object created through the same primitive system.

This distinction is important:

- platform primitive remains stable
- domain naming stays flexible
- AI learns composition instead of memorizing special-case platform objects

---

## Inventory linkage pattern

Inventory should attach to the concrete sellable unit, not to the abstract product family.

```yaml
objects:
  - name: InventoryItem
    identity:
      business_keys: [inventory_key]
    relations:
      - name: product_variant
        type: many_to_one
        target: ProductVariant
        inverse: inventory_items
```

Why:
- stock is held for concrete units
- inventory logic needs a precise sellable identity
- product family alone is too abstract for stock operations

---

## Order linkage pattern

Sales order lines should also attach to the concrete sellable unit.

```yaml
objects:
  - name: SalesOrderLine
    identity:
      business_keys: [line_key]
    relations:
      - name: order
        type: many_to_one
        target: SalesOrder
        inverse: lines
      - name: product_variant
        type: many_to_one
        target: ProductVariant
        inverse: sales_order_lines
```

Why:
- the order must point to the actually purchasable unit
- pricing, stock reservation, and fulfillment all depend on the concrete variant

---

## Identity guidance

### ProductModel identity
Should identify the abstract family.

Example:
- model_code

### ProductVariant identity
Should identify the concrete sellable unit.

Example:
- variant_code

### InventoryItem identity
Should identify the concrete stock record.
In more advanced domains this may eventually involve composition such as:
- variant + location
- variant + location + batch

But the pattern does not force the platform to introduce special inventory primitives at this stage.

---

## AI guidance

When AI encounters a domain that appears to need `SKU`, it should ask:

1. Is there a difference between an abstract product definition and a concrete sellable unit?
2. Does inventory attach to the concrete unit?
3. Do order lines attach to the concrete unit?

If yes, AI should first try this pattern:

- ProductModel
- ProductVariant
- InventoryItem
- SalesOrderLine

before asking for new platform primitives.

---

## When to use this pattern

Use this pattern when:

- a business distinguishes product families from concrete sellable units
- inventory must be tied to a more concrete identity than the generic product
- ordering must reference a concrete variant

---

## When not to use this pattern

Do not force this pattern when:

- the domain truly has no distinction between product family and sellable unit
- there is only a single concrete form and no meaningful variant layer
- adding the extra layer would reduce clarity without adding business value

In such cases, a single Product object may remain sufficient.

---

## Why this pattern matters

This pattern demonstrates the core design goal of the platform:

> build minimal, clear, composable, and AI-learnable LEGO-like primitives

It shows that realistic business modeling should first be attempted through composition.

Only repeated failure of composition should justify the introduction of new primitives.

---

## Status

Initial modeling pattern for Phase 2 semantic validation.
