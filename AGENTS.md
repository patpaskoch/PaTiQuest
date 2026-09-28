# AGENTS.md — PaTiQuest

**Read the suite rules first: [`../../PaTiAdmin/AGENTS.md`](../../PaTiAdmin/AGENTS.md).** They apply here in full
(independence, combat lockdown, no automation, localization, tests, Definition of Done, VALIDATION output).
Addon facts: `../../PaTiAdmin/docs/ARCHITECTURE.md` · open issues: `../../PaTiAdmin/docs/FOLLOW_UPS.md`.

## This addon
- Purpose: the quest selected in the quest log and its objectives.
- SavedVariables: `PaTiQuestDB` (per character): x, y, locked.
- Secure / combat-sensitive: none (no secure frames).
- Slash commands: `/phq`, `/patiquest` — test, show, hide, lock, unlock.
- Uses the legacy `PaTiSharedPanel.lua` (FOLLOW_UPS F6).
- Duo sync is planned: write `PaTiAdmin/docs/PROTOCOL.md` (prefix, versioned messages, validation) before any addon message code.

## Checks
`bash ../../PaTiAdmin/tools/check.sh .` before every commit. Manual WoW tests: `../../PaTiAdmin/docs/TESTING.md`.
