theory Bewegungsontologie
  imports Main
begin

datatype Sukzession = s_1 | Nachfolger Sukzession

fun vor :: "Sukzession ⇒ Sukzession ⇒ bool" where
  "vor s (Nachfolger s') = (s = s' ∨ vor s s')" |
  "vor s s_1 = False"

typedecl Bewegung
consts existiert :: "Bewegung ⇒ Sukzession ⇒ bool"

(* "eine notwendige Bewegung ist eine Bewegung die existiert" *)
definition notwendig :: "Bewegung ⇒ Sukzession ⇒ bool" where
  "notwendig δ s ⟷ existiert δ s"

(* Möglich(x) := ¬Notwendig(Unmöglich(x)); Unmöglich(x) := Notwendig(Gegenteil(x)) *)
definition unmoeglich :: "Bewegung ⇒ Sukzession ⇒ bool" where
  "unmoeglich δ s ⟷ ¬ existiert δ s"

definition moeglich :: "Bewegung ⇒ Sukzession ⇒ bool" where
  "moeglich δ s ⟷ existiert δ s"

(* Energie: nicht möglich jetzt, aber notwendig-existierend später *)
definition Energie :: "Bewegung ⇒ Sukzession ⇒ bool" where
  "Energie δ s ⟷ ¬ moeglich δ s ∧ (∃s'. vor s s' ∧ notwendig δ s')"

theorem existiert_impliziert_notwendig:
  "existiert δ s ⟶ notwendig δ s"
  unfolding notwendig_def by simp

end
