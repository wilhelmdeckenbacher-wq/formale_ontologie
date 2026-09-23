theory Bewegungsontologie_Resultierend
  imports Bewegungsontologie_Hemmung
begin

typedecl Bewegung
typedecl Ziel   (* ZdK-Zielpunkt *)

consts staerke :: "Bewegung ⇒ Sukzession ⇒ nat"

(* welche Kräfte zu einem ZdK x hin bzw. dagegen wirken *)
consts ProMenge :: "Ziel ⇒ Sukzession ⇒ Bewegung set"
consts ContraMenge :: "Ziel ⇒ Sukzession ⇒ Bewegung set"

axiomatization where
  endlich_Pro: "finite (ProMenge x s)" and
  endlich_Contra: "finite (ContraMenge x s)"

definition GesamtPro :: "Ziel ⇒ Sukzession ⇒ nat" where
  "GesamtPro x s = (∑Fy∈ProMenge x s. staerke Fy s)"

definition GesamtContra :: "Ziel ⇒ Sukzession ⇒ nat" where
  "GesamtContra x s = (∑Fy∈ContraMenge x s. staerke Fy s)"

definition NettoBewegung :: "Ziel ⇒ Sukzession ⇒ int" where
  "NettoBewegung x s = int (GesamtPro x s) - int (GesamtContra x s)"

definition Annaeherung :: "Ziel ⇒ Sukzession ⇒ bool" where
  "Annaeherung x s ⟷ NettoBewegung x s > 0"

theorem Annaeherung_iff:
  "Annaeherung x s ⟷ GesamtPro x s > GesamtContra x s"
  unfolding Annaeherung_def NettoBewegung_def by simp

end
