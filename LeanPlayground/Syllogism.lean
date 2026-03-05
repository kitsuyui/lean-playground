
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

end Syllogism
