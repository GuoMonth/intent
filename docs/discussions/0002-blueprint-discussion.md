# 0002 - Blueprint Discussion

## Purpose

This discussion focuses on the role of Blueprint inside the `intent` platform.

The core problem is:

> How should natural-language requirements be transformed into a structured, validated, and buildable intermediate representation?

That intermediate representation is currently called **Blueprint**.

---

## Why Blueprint matters

The platform vision is not just to let humans configure systems faster.

The goal is:

- humans describe intent
- AI understands requirements
- AI produces a structured system design
- the platform validates and compiles that design into plugins and runtime artifacts

Blueprint is therefore the key bridge between:

- intent
- AI reasoning
- platform primitives
- plugin generation
- runtime execution

---

## Questions to resolve

1. What is Blueprint?
   - a requirement sketch?
   - a design artifact?
   - a buildable intermediate representation?

2. What must Blueprint contain?
   - objects?
   - fields?
   - actions?
   - permissions?
   - workflows?
   - views?
   - imports/exports?

3. What is the relation between Blueprint and Plugin?
   - does Blueprint compile into Plugin?
   - is Blueprint part of the plugin itself?

4. How should AI generate Blueprint?
   - one-shot generation?
   - iterative repair?
   - validation-driven refinement?

5. What should be declarative, and what should remain programmable?

---

## Current working assumption

A likely direction is:

> Natural language -> Blueprint -> Plugin -> Runtime

But the exact boundaries are not yet finalized.

---

## Status

Open discussion. No final decision yet.
