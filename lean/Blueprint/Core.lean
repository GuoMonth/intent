namespace Blueprint

-- Basic semantic primitives

structure Entity where
  name : String

structure Action where
  name : String

structure Invariant where
  name : String
  holds : Prop

structure Workflow where
  name : String

end Blueprint
