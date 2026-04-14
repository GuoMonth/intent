# Documentation Structure

This repository keeps two things in parallel:

1. raw discussion records
2. distilled decisions and their downstream artifacts

The goal is:

> Preserve thinking -> Extract decisions -> Build system

## Structure

### discussions/
- raw discussions
- evolving thoughts
- early ideas and debates

### decisions/
- finalized or temporary decisions
- each decision includes:
  - context
  - options
  - decision
  - consequences

### product/
- product vision
- positioning
- roadmap
- MVP definition

### architecture/
- system structure
- primitives
- plugin model
- execution model
- interfaces

### technical/
- implementation planning
- service breakdown
- API surface
- storage model
- runtime details

## Workflow

1. Discuss ideas
2. Record in `discussions/`
3. Extract decisions into `decisions/`
4. Derive product & architecture
5. Plan implementation

## Key principle

> Discussions are messy.
> Decisions must be clear.
> Architecture must be stable.
> Implementation must be replaceable.
