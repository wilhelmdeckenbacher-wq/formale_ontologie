# Bewegungsontologie — Formalisierungs-Log (Isabelle/HOL)

Zusammenfassung der Isabelle-Formalisierung von tenebris' Bewegungsontologie (keine Possible-Worlds-Semantik, sondern eine einzige Welt mit einer Kette von Sukzessionspunkten). Dient als Einstiegspunkt für Fortsetzung/Review.

## Theorien im Überblick

| Datei | Inhalt |
|---|---|
| `Bewegungsontologie.thy` | Grundtypen (`Sukzession`, `Bewegung`), Basisdefinitionen `notwendig`/`moeglich`/`unmoeglich`/`Energie` |
| `Bewegungsontologie_2.thy` | Frühere Fassung mit `Zeit` statt `Sukzession`; abgelöst, aber als Referenz erhalten |
| `Bewegungsontologie_Hemmung.thy` | `staerke`, paarweise `Hemmungsanteil`/`Restkraft`/`vollstaendig_gehemmt`; `existiert` als Disjunktion aus `Bewegt`/`Energie` |
| `Bewegungsontologie_Resultierend.thy` | n-äre Wechselwirkung: `ProMenge`/`ContraMenge`, `GesamtPro`/`GesamtContra`, `NettoBewegung`, `Annaeherung` |

Importkette: `Resultierend` → `Hemmung` → `Main` (Typen/Konstanten werden nicht doppelt deklariert, sondern vererbt).

## Zentrale Definitionen

- **Sukzession**: induktive Kette `s_1, Nachfolger s_1, Nachfolger (Nachfolger s_1), …`; strikte Vorher-Relation `vor` (kein Element ist vor sich selbst oder vor `s_1`)
- **Notwendig(δ,s) :⇔ existiert(δ,s)** — an einem festen Sukzessionspunkt fallen möglich/notwendig/wirklich zusammen (einzeitlich-aktualistische Ontologie, keine unrealisierten Alternativen im Jetzt)
- **Energie(δ,s)** — δ ist bei s nicht möglich, existiert aber garantiert bei einem späteren s'
- **Kraft(δ)** — δ ist irgendwann in der Kette notwendig/existent
- **Hemmung** (Hemmungsanteil/Restkraft) — paarweiser Anteil, um den zwei entgegengesetzte Kräfte sich neutralisieren; `vollständig gehemmt ⇔ eigene Stärke ≤ Gegnerstärke`
- **existiert(δ,s) :⇔ Bewegt(δ,s) ∨ Energie(δ,s)** — Existenz zerfällt in zwei disjunkte Modi: freie Bewegung vs. gespeichertes Bewegungspotenzial
- **GesamtPro/GesamtContra/NettoBewegung** — n-äre Verallgemeinerung: alle auf ein ZdK-Ziel wirkenden Kräfte werden pro/contra aufsummiert, erst danach verglichen (nicht paarweise)
- **Annaeherung(x,s) :⇔ NettoBewegung(x,s) > 0**

## Bewiesene Theoreme

1. `existiert_impliziert_notwendig`: existiert ⟶ notwendig (trivial nach Umbenennung)
2. `moeglich_gdw_existiert_oder_notwendig`: möglich ⟷ existiert ∨ notwendig
3. `existiert_impliziert_Kraft`: existiert ⟶ Kraft
4. `vollstaendig_gehemmt_iff`: vollständig gehemmt ⟷ eigene Stärke ≤ Gegnerstärke
5. `Annaeherung_iff`: Annäherung ⟷ GesamtPro > GesamtContra

Alle Beweise: `unfolding ... by blast`/`by simp` — keine der Aussagen war beweistechnisch schwer; die eigentliche Arbeit lag im korrekten Formalisieren der Begriffe, nicht im Beweisen selbst.

## Korrigierte Fehlformalisierungen (Verlauf)

- `möglich` fälschlich als "existiert jetzt oder später" statt "existiert jetzt" definiert → führte zu falschem Gegenmodell
- `notwendig` fälschlich mit dem verwechselt, was eigentlich `Energie` heißen sollte (zukunftsgerichtetes „existiert noch nicht, aber wird") — korrekt ist: `notwendig` = `existiert jetzt`
- Hemmung fälschlich als feste 1:1-Gegenbewegung statt als n-äre Pro-/Contra-Summe modelliert
- Zwei technische Isabelle-Fehler (fehlende `.thy`-Endung; fehlende bzw. doppelte Typ-Imports zwischen Theorien) — keine inhaltlichen Fehler, sondern Environment-Stolpersteine

## Offene Fragen

- Verhältnis `Kraft` (irgendwann existent) zu einer möglichen **Persistenz-Annahme** (bleibt eine Kraft für immer "abrufbar"?) — aktuell ungeklärt, betrifft `Kraft_ohne_aktuelle_Bewegung_ist_Hemmung`
- **„Tote" Kraft** (existiert jetzt, nie wieder danach) noch nicht formal erfasst — Vorschlag `tot(δ,s)` liegt vor, ungeprüft
- Eindeutigkeit des Umschlagpunkts s' bei `Energie` (`∃!`) — vermutlich aus der linearen Kettenstruktur ableitbar, nicht separat bewiesen
- Umrechnung `NettoBewegung → ΔD_ZdK` (Distanzverringerung zum Ziel): 1:1 oder über eigene Funktion/Kopplungskonstante α? — noch offen
- Kopplungskonstante α (aus der parallelen rWW-Formalisierung) kommt in diesem Strang bewusst noch nicht vor

## Fazit zu Isabelle vs. Lean (siehe Chat für volle Diskussion)

- Beweisautomatisierung (`blast`/`simp`) war für den bisherigen Formalisierungsgrad in beiden Systemen mühelos ausreichend — kein echter Unterschied
- Isabelle/jEdit-UX: kein Erfolgssignal wie Leans Infoview-Häkchen; „Stille = korrekt" statt aktiver Bestätigung — spürbarer Nachteil beim Einstieg
- Isar-Beweise sind lesbarer/papierähnlicher als Lean-Taktiken; Leans Typsyntax ist konsistenter als Isabelles String-quotierte Typen
- Lean+Paperproof bietet einen visuellen Beweisbaum (Hypothesen/Ziele/Taktiken als Diagramm) ohne Isabelle-Äquivalent — potenziell nützlich für tenebris' Prüfprotokoll-Dokumentation
- Der eigentliche Engpass war in beiden Fällen nicht das Tool, sondern die iterative Übersetzung diskursiver Begriffe in formale Definitionen
