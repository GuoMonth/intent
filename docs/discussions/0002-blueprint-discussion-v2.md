# 0002 - Blueprint Discussion (v2)

## Summary

Blueprint is positioned as a semi-structured intermediate representation between natural language and plugin/runtime.

---

## Agreed direction

- Blueprint is NOT raw requirements
- Blueprint is NOT final plugin
- Blueprint IS a design-layer IR (intermediate representation)

Flow:

Natural language -> Blueprint -> Plugin -> Runtime

---

## Core semantic model (v0.1)

The following core concepts are identified:

1. Domain
2. Object
3. Field
4. Relation
5. Action
6. Workflow
7. Permission
8. Attachment / ImportExport

---

## Key semantic principles

- Object is the center of the system model
- Action represents business capability
- Workflow represents state transitions
- Permission is enforced by the platform
- Blueprint is not executable but compilable

---

## Open topics

- exact schema for each concept
- validation rules
- compilation pipeline
- AI generation strategy

---

## Next step

Define minimal field model for:

- Object
- Action
- Workflow
- Permission
