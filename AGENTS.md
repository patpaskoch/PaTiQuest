# AGENTS.md — PaTiQuest

**Read the suite rules first: [`../../PaTiAdmin/AGENTS.md`](../../PaTiAdmin/AGENTS.md).** They apply here in full.
Addon facts: `../../PaTiAdmin/docs/ARCHITECTURE.md` · open issues: `../../PaTiAdmin/docs/FOLLOW_UPS.md`.

## This addon
- Purpose: the quest selected in the quest log and its objectives. Display only.
- Files: `Logic.lua` (settings, quest lines; pure, tested) · `PaTiQuest.lua` (quest API adapter, window, settings,
  commands, events) · `Locales/` · `Shared/` (PaTiShared, synced — never edit).
- SavedVariables: `PaTiQuestDB` (per character), schema 1: x, y (+ point/relativePoint once dragged), locked, collapsed, scale, language.
- Quest API: every `C_QuestLog.*` call stays in `readSelectedQuest()`, existence-checked and `pcall`-guarded.
- Secure / combat-sensitive: none. No addon communication: duo sync needs `PaTiAdmin/docs/PROTOCOL.md` first.
- Slash commands: `/phq` (kept for compatibility, FOLLOW_UPS F11), `/patiquest`.

## Checks
`bash ../../PaTiAdmin/tools/check.sh .` before every commit. Manual WoW tests: `../../PaTiAdmin/docs/TESTING.md`.
