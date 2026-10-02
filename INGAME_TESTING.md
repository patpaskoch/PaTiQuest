# Ingame Testing – PaTiQuest

World of Warcraft: Forever
Interface: 16001

Diese Datei dokumentiert ausschließlich Tests im echten WoW-Client.

Automatisierte Tests, CI und Code Review zählen NICHT als Ingame-Verifikation.
Regeln und Eintragen von Ergebnissen: [PaTiAdmin/docs/TESTING.md](https://github.com/patpaskoch/PaTiAdmin/blob/main/docs/TESTING.md#in-game-test-files).

Scope: nur die ausgewählte Quest mit ihren Zielen (keine Questliste, keine Duo-Funktionen).

## Legende

- [ ] offen / noch nicht bestätigt
- [x] vom Owner im echten Client bestätigt
- ❌ FAIL = im echten Client fehlgeschlagen
- 🔧 FIX IMPLEMENTED = Codefix vorhanden, Retest noch offen
- ✅ VERIFIED = erfolgreich im echten Client bestätigt
- MANUAL RETEST REQUIRED = erneuter Test notwendig

## Installation / Laden

- [ ] PT-QUEST-001 Fresh Install aus dem Release-ZIP: genau ein Ordner `PaTiQuest/`, Addon lädt allein
- [ ] PT-QUEST-002 PaTiQuest erscheint in der AddOn-Liste mit Beschreibung
- [x] PT-QUEST-003 Icon in der AddOn-Liste korrekt, keine weiße oder fehlende Textur
  - ✅ VERIFIED 2026-10-02
  - Owner: die Icons erscheinen im Spiel in der AddOn-Liste korrekt.
- [ ] PT-QUEST-004 Login ohne Lua-Fehler
- [ ] PT-QUEST-005 `/reload` ohne Lua-Fehler

## Fenster

- [ ] PT-QUEST-010 `/phq` bzw. `/patiquest` blendet das Fenster ein und aus; `/phq show`, `/phq hide`
- [ ] PT-QUEST-011 Fenster am Header verschieben (entsperrt)
- [ ] PT-QUEST-012 Position bleibt nach `/reload`
- [ ] PT-QUEST-013 Lock/Unlock (••• und `/phq lock` / `unlock`): gesperrt nicht verschiebbar
- [ ] PT-QUEST-014 Größe (Scale) wirkt
- [ ] PT-QUEST-015 Einstellungen öffnen (`/phq settings` und •••) und speichern
- [ ] PT-QUEST-016 Collapse/Expand über •••, Zustand bleibt nach `/reload`
- [ ] PT-QUEST-017 Test Mode `/phq test` zeigt eine Beispielquest
- [ ] PT-QUEST-018 Panel-Deckkraft 30–100 %: nur der Hintergrund ändert sich
- [ ] PT-QUEST-019 Keine Einrast-Einstellung mehr, Fenster frei verschiebbar
- [ ] PT-QUEST-020 `/phq reset` setzt die Position zurück

## SavedVariables

- [ ] PT-QUEST-030 Einstellungen bleiben nach `/reload`
- [ ] PT-QUEST-031 Einstellungen bleiben nach Relog
- [ ] PT-QUEST-032 Update mit alten Einstellungen: Position und Werte bleiben
- [ ] PT-QUEST-033 „Standard wiederherstellen“ setzt die Einstellungen zurück

## Sprachen

- [ ] PT-QUEST-040 deDE: alle Texte deutsch, Questtexte aus dem Client
- [ ] PT-QUEST-041 Sprache enUS in den Einstellungen: nach `/reload` englisch
- [ ] PT-QUEST-042 zhCN/zhTW/koKR: Englisch als Rückfall, keine Schlüsselnamen oder Kästchen
- [ ] PT-QUEST-043 Keine abgeschnittenen wichtigen Texte (deDE), lange Questnamen und Ziele

## Quest

- [ ] PT-QUEST-050 Ausgewählte Quest wird angezeigt
- [ ] PT-QUEST-051 Questname stimmt
- [ ] PT-QUEST-052 Ziele (Objectives) stimmen
- [ ] PT-QUEST-053 Andere Quest im Questlog auswählen → Fenster aktualisiert sich
- [ ] PT-QUEST-054 Questfortschritt (z. B. 3/8 → 4/8) aktualisiert sich
- [ ] PT-QUEST-055 Keine Quest ausgewählt → Hinweis statt leerem Fenster
- [ ] PT-QUEST-056 Ausgewählte Quest bleibt nach `/reload` angezeigt

## Combat / Sicherheit

- [ ] PT-QUEST-060 Kein Lua-Fehler im Kampf
- [ ] PT-QUEST-061 Keine `ADDON_ACTION_BLOCKED` / `ADDON_ACTION_FORBIDDEN`
- [ ] PT-QUEST-062 `taint.log` (`/console taintLog 1`) ohne PaTiQuest-Eintrag

## Combined

- [ ] PT-QUEST-070 Zusammen mit allen PaTi-Addons geladen: kein Lua-Fehler
- [ ] PT-QUEST-071 Keine Slash-Command-Kollision: `/phq` und `/patiquest` antworten nur PaTiQuest
- [ ] PT-QUEST-072 Eigene Einstellungen speichern nur PaTiQuest-Werte; Fenster erscheint in PaTiSuite
