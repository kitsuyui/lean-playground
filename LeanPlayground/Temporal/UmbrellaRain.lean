import LeanPlayground.Temporal.Temporal
import LeanPlayground.Temporal.RainUmbrella

-- "If you have an umbrella, did it rain at some point?"
-- This does NOT follow from rainPolicy alone (Rain → HasUmbrella is one-directional).
-- We need an additional assumption to reason backwards.

section UmbrellaRain

-- Attempt: from rainPolicy alone, we cannot conclude this.
-- The proof is impossible without extra assumptions; there is no proof term to fill in.
-- (Commented out to show it is not provable.)
--
-- theorem umbrella_implies_rain_UNPROVABLE
--     (t : Trace Weather)
--     (policy : rainPolicy t)
--     (h : eventually HasUmbrella t) : eventually Rain t := ...

-- To reason backwards, we need a converse assumption:
-- "you only have an umbrella if it rained at some point" (◇HasUmbrella → ◇Rain).
-- This is a separate fact about the world, not derivable from the policy.
theorem umbrella_implies_rain
    (t : Trace Weather)
    (converse : eventually HasUmbrella t → eventually Rain t)
    (h : eventually HasUmbrella t) : eventually Rain t :=
  converse h

-- Alternatively: a stronger world assumption — HasUmbrella ↔ Rain at every point.
-- With the biconditional, both directions hold.
theorem umbrella_iff_rain
    (t : Trace Weather)
    (biconditional : always (fun w => HasUmbrella w ↔ Rain w) t)
    (n : Nat)
    (h : HasUmbrella (t n)) : Rain (t n) :=
  (biconditional n).mp h

-- Proof that the converse does NOT hold in general.
-- We construct a counterexample: a trace where it never rains but you always have an umbrella.
-- This witnesses that rainPolicy does not entail (◇HasUmbrella → ◇Rain).
theorem umbrella_does_not_imply_rain :
    ¬ (∀ (t : Trace Weather), rainPolicy t → eventually HasUmbrella t → eventually Rain t) := by
  intro h
  -- Counterexample: always dry, always carrying an umbrella.
  let t : Trace Weather := fun _ => { raining := false, hasUmbrella := true }
  -- rainPolicy holds vacuously: Rain never occurs, so Rain → HasUmbrella is trivially true.
  have policy : rainPolicy t := fun _ hRain => absurd hRain (by simp [Rain])
  -- HasUmbrella holds at time 0.
  have hasUmb : eventually HasUmbrella t := ⟨0, rfl⟩
  -- Rain never holds on this trace.
  have noRain : ¬ eventually Rain t := fun ⟨_, hn⟩ => by simp [Rain] at hn
  -- Applying h gives eventually Rain t, contradicting noRain.
  exact noRain (h t policy hasUmb)

end UmbrellaRain
