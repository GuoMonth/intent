namespace Blueprint

-- Inventory domain

structure Inventory where
  onHand : Nat
  reserved : Nat

-- derived value
def available (inv : Inventory) : Nat :=
  inv.onHand - inv.reserved

-- invariant

def validInventory (inv : Inventory) : Prop :=
  inv.reserved <= inv.onHand

-- deduction result

inductive DeductResult
| success (inv : Inventory)
| failure

-- all-or-nothing deduction

def deduct (inv : Inventory) (qty : Nat) : DeductResult :=
  if h : available inv >= qty then
    DeductResult.success { inv with onHand := inv.onHand - qty }
  else
    DeductResult.failure

-- property: success never violates invariant

theorem deduct_preserves_non_negative
  (inv : Inventory)
  (qty : Nat)
  (hvalid : validInventory inv)
  (h : available inv >= qty) :
  match deduct inv qty with
  | DeductResult.success inv' => validInventory inv'
  | DeductResult.failure => True := by
  simp [deduct, available] at *
  split
  · simp [validInventory]
    exact Nat.sub_le _ _
  · contradiction

end Blueprint
