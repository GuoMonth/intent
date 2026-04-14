# Architecture Overview

## Layers

1. Data Layer (PostgreSQL)
2. Runtime Layer (Go / Rust)
3. Plugin Layer (Lua / WASM)
4. AI Layer (Builder + Operator)
5. Interface Layer (MCP / CLI / API)

---

## Key rules

- DB is source of truth
- runtime enforces logic
- plugins extend behavior
- AI never bypasses runtime
