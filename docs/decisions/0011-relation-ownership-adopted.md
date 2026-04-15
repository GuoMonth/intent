# Decision 0011 - Adopt Relation.ownership into Blueprint v1

## Context

Phase 2 semantic validation introduced `Relation.ownership` as a candidate semantic enhancer.

The purpose of this enhancer was to test whether a small, domain-agnostic addition could significantly reduce modeling ambiguity without introducing semantic overlap or business-specific bias.

The evaluated form was:

```yaml
ownership: owned | referenced
```

Validation used an order-and-inventory scenario and compared v0.2 and v0.3 Blueprint examples.

---

## Decision

`Relation.ownership` is formally adopted into Blueprint v1.

The allowed values in v1 are strictly limited to:

- `owned`
- `referenced`

No additional ownership modes are introduced at this stage.

---

## Why

Validation shows that `Relation.ownership` provides strong semantic compression:

- parent-child relations become explicit
- child-vs-reference meaning becomes easier for AI to interpret
- lifecycle semantics become clearer without introducing a workflow or action overlap
- modeling ambiguity is reduced with only a very small syntax increase

---

## Example

### Owned relation

```yaml
relations:
  - name: order
    type: many_to_one
    target: SalesOrder
    inverse: lines
    ownership: owned
```

### Referenced relation

```yaml
relations:
  - name: product_variant
    type: many_to_one
    target: ProductVariant
    inverse: sales_order_lines
    ownership: referenced
```

---

## Boundary constraints

`Relation.ownership` must not:

- become a replacement for Workflow
- encode authorization logic
- introduce direct execution semantics
- expand into a complex lifecycle language

It only clarifies relation meaning.

---

## Consequences

- Blueprint relation definitions should support `ownership`
- documentation should treat `ownership` as part of the core relation model
- future validation may revisit ownership granularity, but v1 remains strictly binary
- `Object.kind` is not adopted at this stage and remains under evaluation

---

## Final note

This decision follows the project principle:

> add as little semantic surface as possible, but enough to significantly reduce ambiguity
