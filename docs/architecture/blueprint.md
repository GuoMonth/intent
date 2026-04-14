# Blueprint Architecture (v0.1)

## Overview

Blueprint is the core intermediate representation in the system.

It connects:

- human intent
- AI-generated system design
- platform primitives
- plugin generation
- runtime execution

---

## Position in system

Natural language
    ↓
Blueprint (this layer)
    ↓
Plugin (runtime artifact)
    ↓
Runtime execution

---

## Design goals

Blueprint must be:

1. AI-generatable
2. platform-validatable
3. incrementally repairable
4. compilable into plugin artifacts

---

## Core concepts (v0.1)

### Domain
Defines business scope

### Object
Business entity definition

### Field
Attributes of objects

### Relation
Connections between objects

### Action
Executable business capability

### Workflow
State transition rules

### Permission
Access control definition

### Attachment / ImportExport
Extended business capabilities

---

## Structural principles

- Object-centric model
- Action as capability, not CRUD wrapper
- Workflow as state machine, not full BPM
- Permission as platform-level enforcement
- Blueprint as design artifact, not runtime config

---

## Validation expectations

Blueprint should support validation such as:

- missing required object fields
- invalid relations
- inconsistent workflows
- permission conflicts
- undefined action targets

---

## Compilation expectation

Blueprint should be transformed into:

- plugin manifest
- object definitions
- action definitions
- workflow configuration
- permission policies
- import/export mappings

---

## Status

v0.1 conceptual definition. Field-level schema not finalized.
