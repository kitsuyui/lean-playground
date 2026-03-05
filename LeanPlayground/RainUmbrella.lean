import LeanPlayground.Temporal

-- "If it rains, bring an umbrella."
-- This is a conditional temporal property: □(Rain → BringUmbrella).

section RainUmbrella

-- A state captures what is true at a given moment.
structure Weather where
  raining    : Bool
  hasUmbrella : Bool

-- Lift Bool fields to Prop for use in temporal operators.
def Rain       (w : Weather) : Prop := w.raining = true
def HasUmbrella (w : Weather) : Prop := w.hasUmbrella = true

-- □(Rain → HasUmbrella): at every point in time, if it rains, you have an umbrella.
def rainPolicy (t : Trace Weather) : Prop :=
  always (fun w => Rain w → HasUmbrella w) t

-- If the policy holds and it rains at time n, then you have an umbrella at time n.
theorem umbrella_when_raining
    (t : Trace Weather)
    (policy : rainPolicy t)
    (n : Nat)
    (h : Rain (t n)) : HasUmbrella (t n) :=
  policy n h

-- If the policy holds and it rains at some point, you have an umbrella at that point.
theorem umbrella_eventually
    (t : Trace Weather)
    (policy : rainPolicy t)
    (h : eventually Rain t) : eventually HasUmbrella t := by
  obtain ⟨n, hn⟩ := h
  exact ⟨n, policy n hn⟩

end RainUmbrella
