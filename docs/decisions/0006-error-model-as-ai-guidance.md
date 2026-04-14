# Decision 0006 - Error model as AI guidance

## Context

In an AI-native platform, errors are not only for human debugging.

Errors must help AI:

- understand what failed
- understand why it failed
- inspect relevant context
- decide what to do next
- recover or retry safely

If Action error handling only returns a short code or message, AI may fail to repair effectively or may take unstable actions.

---

## Decision

Action error models must be designed as structured AI guidance objects.

An error model should not only contain:

- error code
- description

It should also be able to contain:

- relevant contextual data
- diagnostic hints
- recommended focus areas
- suggested next steps
- safe recovery guidance

---

## Required intent

The purpose of the error model is:

1. make failures machine-readable
2. support AI debugging and repair
3. reduce ambiguous recovery behavior
4. guide AI toward the right parts of the system model

---

## Consequences

- error handling becomes part of the Action contract
- error models should be documented explicitly in Blueprint
- runtime implementations should try to preserve structured error output
- plugin generation should not treat errors as plain strings only
