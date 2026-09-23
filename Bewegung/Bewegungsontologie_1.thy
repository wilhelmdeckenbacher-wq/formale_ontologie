theory Bewegungsontologie_Hemmung
  imports Main   (* oder: imports Bewegungsontologie_2, falls im selben Ordner *)
begin

datatype Sukzession = s_1 | Nachfolger Sukzession

fun vor :: "Sukzession ⇒ Sukzession ⇒ bool" where
  "vor s (Nachfolger s') = (s = s' ∨ vor s s')" |
  "vor s s_1 = False"

typedecl Bewegung

consts staerke :: "Bewegung ⇒ Sukzession ⇒ nat"
consts WW_Punkt :: "Bewegung ⇒ Bewegung ⇒ Sukzession ⇒ bool"

definition Hemmungsanteil :: "Bewegung ⇒ Bewegung ⇒ Sukzession ⇒ nat" where
  "Hemmungsanteil Fx Fy s = min (staerke Fx s) (staerke Fy s)"

definition Restkraft :: "Bewegung ⇒ Bewegung ⇒ Sukzession ⇒ nat" where
  "Restkraft Fx Fy s = staerke Fx s - Hemmungsanteil Fx Fy s"

definition vollstaendig_gehemmt :: "Bewegung ⇒ Bewegung ⇒ Sukzession ⇒ bool" where
  "vollstaendig_gehemmt Fx Fy s ⟷ Restkraft Fx Fy s = 0"

lemma Hemmungsanteil_symmetrisch:
  "Hemmungsanteil Fx Fy s = Hemmungsanteil Fy Fx s"
  unfolding Hemmungsanteil_def by (simp add: min.commute)

lemma Zerlegung:
  "staerke Fx s = Restkraft Fx Fy s + Hemmungsanteil Fx Fy s"
  unfolding Restkraft_def Hemmungsanteil_def by (simp add: min_def)

theorem vollstaendig_gehemmt_iff:
  "vollstaendig_gehemmt Fx Fy s ⟷ staerke Fx s ≤ staerke Fy s"
  unfolding vollstaendig_gehemmt_def Restkraft_def Hemmungsanteil_def by (simp add: min_def)

end
