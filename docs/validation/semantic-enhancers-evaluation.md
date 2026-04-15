# Semantic Enhancers Evaluation (Phase 2)

## Purpose

This document evaluates potential semantic enhancers identified during Phase 2 validation.

These are not new business primitives.
They are small additions intended to reduce modeling complexity while preserving semantic clarity.

---

## Evaluation criteria

A candidate enhancer should:

1. be domain-agnostic
2. reduce expression complexity significantly
3. not introduce a second modeling path
4. not overlap with existing semantic responsibilities
5. be easy for AI to understand and apply

---

## Candidate 1: Object.kind

### Definition

```yaml
kind: master | transactional | line_item | process
```

### Value

- clarifies object role in business modeling
- reduces ambiguity in interpreting objects
- improves pattern reuse

### Risk

- may be overused or misused if not clearly documented
- could become too granular if expanded excessively

### Current assessment

- useful but not strictly required
- should be evaluated across more scenarios

---

## Candidate 2: Relation.ownership

### Definition

```yaml
ownership: owned | referenced
```

### Value

- clarifies lifecycle semantics
- reduces ambiguity in parent-child relationships
- directly improves order/inventory modeling clarity

### Risk

- minimal if kept binary
- risk increases if extended into complex ownership types

### Current assessment

- high value
- strongly validated by current scenarios
- good candidate for early inclusion

---

## Comparative summary

| Enhancer           | Value Level | Risk Level | Priority |
|--------------------|------------|------------|----------|
| Object.kind        | Medium     | Low        | Medium   |
| Relation.ownership | High       | Low        | High     |

---

## Recommendation

- do not immediately modify core model
- continue validating both candidates
- prioritize Relation.ownership in next validation iteration
- evaluate Object.kind across more domain patterns

---

## Status

Evaluation ongoing.
