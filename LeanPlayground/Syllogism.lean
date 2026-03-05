
-- https://en.wikipedia.org/wiki/Syllogism
--
-- All men are mortal.
-- Socrates is a man.
-- Therefore, Socrates is mortal.
--
-- Classic syllogism in Lean 4
-- Major premise : All humans are mortal.
-- Minor premise : Socrates is human.
-- Conclusion    : Therefore, Socrates is mortal.

section Syllogism

variable (Being : Type)
variable (Human : Being → Prop)
variable (Mortal : Being → Prop)
variable (Socrates : Being)

-- Conclusion: Socrates is mortal.
-- Major premise and minor premise are explicit arguments of the theorem.
theorem socratesMortal
    (allHumansMortal : ∀ b : Being, Human b → Mortal b)  -- Major premise: All humans are mortal.
    (socratesIsHuman : Human Socrates)                    -- Minor premise: Socrates is human.
    : Mortal Socrates :=
  allHumansMortal Socrates socratesIsHuman

-- Variant 2: tactic mode with `apply` + `assumption`
-- `apply` unifies the goal with the conclusion of allHumansMortal,
-- leaving `Human Socrates` as a subgoal.
-- `assumption` then finds `socratesIsHuman` in the local context automatically.
theorem socratesMortal2
    (allHumansMortal : ∀ b : Being, Human b → Mortal b)
    (socratesIsHuman : Human Socrates)
    : Mortal Socrates := by
  apply allHumansMortal
  assumption

-- Variant 3: tactic mode with `exact`
-- `exact` closes the goal by providing the complete proof term directly.
theorem socratesMortal3
    (allHumansMortal : ∀ b : Being, Human b → Mortal b)
    (socratesIsHuman : Human Socrates)
    : Mortal Socrates := by
  exact allHumansMortal Socrates socratesIsHuman

end Syllogism

-- Variant 4: standalone form outside the section, equivalent to #print output of socratesMortal2.
-- All variables are explicitly spelled out as ∀ parameters.
theorem socratesMortal4 :
    ∀ (Being : Type) (Human Mortal : Being → Prop) (Socrates : Being),
    (∀ (b : Being), Human b → Mortal b) → Human Socrates → Mortal Socrates :=
  fun _Being _Human _Mortal Socrates allHumansMortal socratesIsHuman =>
    allHumansMortal Socrates socratesIsHuman
