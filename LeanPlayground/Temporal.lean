-- Temporal reasoning without LTL library.
-- This is a shallow embedding: temporal operators are defined directly as Lean propositions
-- (∀, ∃), with no separate syntax layer.
-- The underlying model is Kripke semantics over a linear frame (Nat, successor):
-- each natural number is a "world", and time flows along the successor relation.

section Temporal

-- A trace maps each time point (world in the Kripke frame) to a state.
def Trace (α : Type) := Nat → α

-- □ Always: P holds at every point in time.
def always {α : Type} (P : α → Prop) (t : Trace α) : Prop :=
  ∀ n, P (t n)

-- ◇ Eventually: P holds at some point in time.
def eventually {α : Type} (P : α → Prop) (t : Trace α) : Prop :=
  ∃ n, P (t n)

-- ○ Next: P holds at the next point in time.
def next {α : Type} (P : α → Prop) (t : Trace α) : Prop :=
  P (t 1)

-- □ implies ◇: if P always holds, then P eventually holds.
theorem always_implies_eventually {α : Type} (P : α → Prop) (t : Trace α)
    (h : always P t) : eventually P t :=
  ⟨0, h 0⟩

end Temporal

-- Applying temporal reasoning to the Socrates syllogism.
section SocratesTemporal

variable (Being : Type)
variable (Human Mortal : Being → Prop)
variable (Socrates : Being)

-- If Socrates appears at time n on the trace, he is mortal at that time.
-- "Socrates will eventually be mortal" given that he appears on the trace.
theorem socratesEventuallyMortal
    (allHumansMortal : ∀ b : Being, Human b → Mortal b)
    (socratesIsHuman : Human Socrates)
    (trace : Trace Being)
    (appearsAt : ∃ n, trace n = Socrates) : eventually Mortal trace := by
  obtain ⟨n, hn⟩ := appearsAt
  exact ⟨n, hn ▸ allHumansMortal Socrates socratesIsHuman⟩

-- If every being on the trace is human, every being is eventually mortal.
theorem allEventuallyMortal
    (allHumansMortal : ∀ b : Being, Human b → Mortal b)
    (trace : Trace Being)
    (allAreHuman : ∀ n, Human (trace n)) : eventually Mortal trace :=
  ⟨0, allHumansMortal (trace 0) (allAreHuman 0)⟩

-- If P always holds on a trace, it eventually holds.
-- Instantiated for Mortal: always mortal → eventually mortal.
theorem alwaysMortal_implies_eventuallyMortal
    (trace : Trace Being)
    (h : always Mortal trace) : eventually Mortal trace :=
  always_implies_eventually Mortal trace h

end SocratesTemporal
