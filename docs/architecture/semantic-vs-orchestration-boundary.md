# Semantic vs Orchestration Boundary

## Purpose

This document defines one of the most important boundaries in the system:

> what should be modeled as stable platform semantics, and what should be left to AI-driven orchestration or glue logic

This boundary becomes especially important in realistic ERP-like scenarios where standard and non-standard operations coexist.

---

## Why this boundary matters

If too much business behavior is pushed into the semantic model, the platform will bloat and become rigid.

If too much behavior is pushed into orchestration code, the platform loses structure, validation power, and AI-readable consistency.

The correct design goal is:

> keep stable, reusable, and validateable business meaning in semantics
> keep dynamic, situational, and complex coordination in orchestration

---

## Core distinction

### Semantic layer should model

- stable business objects
- stable relationships
- stable identity rules
- reusable business actions
- lifecycle and state legality
- explicit authorization boundaries
- structured error contracts

### Orchestration layer should handle

- multi-step coordination
- conditional branching across multiple objects
- exception handling strategies
- compensation logic
- non-standard operational flows
- dynamic sequencing of actions

---

## Rule of thumb

A concern should stay in the semantic layer when it is:

- reusable across many cases
- conceptually stable
- valuable for validation
- important for AI reasoning even before execution

A concern should stay in the orchestration layer when it is:

- situational
- highly branch-dependent
- implementation-shaped
- better expressed as stepwise logic calling actions

---

## ERP inventory scenario analysis

### 1. Inventory inbound

#### Semantic layer
- ProductVariant
- InventoryItem
- inbound_inventory Action

#### Orchestration layer
- usually not needed for the minimal case

#### Judgment
Inventory inbound is a strong candidate for semantic modeling as a reusable atomic capability.

---

### 2. Inventory outbound

#### Semantic layer
- ProductVariant
- InventoryItem
- outbound_inventory Action

#### Orchestration layer
- usually not needed for the minimal case

#### Judgment
Inventory outbound is also a reusable atomic capability and belongs in the semantic layer.

---

### 3. Stock count confirmation

#### Semantic layer
- InventoryItem
- maybe InventoryAdjustment as a normal Object if needed
- confirm_inventory_count or adjust_inventory Action

#### Orchestration layer
- usually minimal unless a domain introduces exceptional handling

#### Judgment
This still belongs primarily in the semantic layer.

---

### 4. Reservation after order submission

#### Semantic layer
- SalesOrder
- SalesOrderLine
- InventoryItem
- reserve_inventory Action
- SalesOrder Workflow

#### Orchestration layer
- multi-line coordination
- partial reservation behavior
- fallback strategy if inventory is insufficient
- cross-location allocation strategies

#### Judgment
Reservation sits on the boundary.

The semantic layer should provide the reusable atomic action and state constraints.
The orchestration layer should coordinate the dynamic multi-step behavior.

---

### 5. Inventory restoration after cancellation or return

#### Semantic layer
- cancel_order Action
- restore_inventory Action
- Workflow transitions where applicable

#### Orchestration layer
- partial restoration logic
- conditional restoration based on shipment or return status
- compensation sequences
- exceptional business recovery paths

#### Judgment
This is primarily an orchestration-heavy scenario.

The semantic layer should expose the right reusable actions.
The orchestration layer should coordinate when and how to call them.

---

## Boundary principle for Actions

Actions should represent:

> atomic, reusable business capabilities

Actions should not attempt to encode:

- all orchestration logic
- all fallback logic
- all cross-object compensation logic

This keeps Actions stable and composable.

---

## Boundary principle for Workflow

Workflow should remain the authority for:

- object lifecycle states
- legal state transitions

Workflow should not become:

- a general orchestration engine
- a compensation engine
- a branching script layer

---

## Boundary principle for AI glue logic

AI-driven glue logic should be allowed to:

- decide which actions to call in sequence
- react to structured error outputs
- branch based on current object state and runtime context
- implement custom or non-standard operational sequences

But glue logic should not replace:

- core object semantics
- action contracts
- workflow authority
- permission authority

---

## Practical interpretation

The system is not trying to model every ERP process inside Blueprint.

Instead, Blueprint should provide:

- stable semantic building blocks
- action-level capabilities
- enough explicit structure for AI to reason safely

Then AI orchestration can compose those capabilities into standard or non-standard operational flows.

---

## Final principle

> semantic layer defines stable meaning
> orchestration layer defines dynamic execution strategy

This is the intended long-term boundary.

---

## Status

Initial boundary document for Phase 2 validation.
