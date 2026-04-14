# Action ↔ Workflow ↔ Permission Boundary (v0.1)

## Overview

This document defines the strict semantic boundaries between:

- Action
- Workflow
- Permission

The goal is to enforce:

> single-path semantics and clear responsibility separation

---

## Responsibilities

### Object
Defines business entities

### Action
Defines executable business capabilities

### Workflow
Defines allowed state transitions

### Permission
Defines who can invoke actions

---

## Key separation rules

### Rule 1: Action is the only execution entry

- all behavior must go through Action
- no direct object mutation

---

### Rule 2: Workflow is the only state authority

- only Workflow defines valid state transitions
- Action may trigger transitions but not define legality

---

### Rule 3: Permission is the only authorization authority

- only Permission decides who can call Action
- Action should not embed role logic

---

## Interaction flow

```text
AI -> Action -> Permission check -> Workflow validation -> Execution -> Result or Error
```

---

## Example flow

1. AI calls confirm_sales_order
2. Permission checks role
3. Workflow checks current state
4. If valid -> execute
5. If invalid -> structured error

---

## Anti-patterns

### ❌ Action defining state rules

- leads to duplicated logic

### ❌ Permission embedded inside Action

- leads to hidden authorization logic

### ❌ Workflow embedding execution logic

- leads to mixed concerns

---

## Design principle

Each layer answers exactly one question:

- Action: what can be done?
- Workflow: is it allowed in current state?
- Permission: who is allowed to do it?

---

## Result

This separation ensures:

- deterministic validation
- stable AI reasoning
- predictable system behavior
- easier debugging and repair

---

## Status

v0.1 enforced boundary model
