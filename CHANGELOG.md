# Changelog

Format: `## [Unreleased]` / `## [x.y.z] - YYYY-MM-DD` with Added, Changed, Fixed, Removed, Known Issues.
History before this file: `git log`.

## [Unreleased]
### Added
- PaTiShared window with ••• menu (Settings, Lock/Unlock, Collapse/Expand, Test Mode, Hide), settings modal
  (language, scale, lock), `/phq settings, reset, debug, version`; `/phq` alone shows/hides the window.
- English texts, German translation.
### Changed
- AddOns list description in English with a German translation (`## Notes-deDE`); README rewritten for players
  (features, installation, first steps, commands, known limitations).
- New PaTiShared look instead of the legacy panel (gear, chevron, close button).
- Settings in PaTiQuestDB get a schema; the 0.1.0 position and lock state are kept.
### Fixed
- The addon did not load: the TOC listed both Lua files on one line with a literal `` `r`n `` between them.
- Unreadable quest data (secret, empty or unexpected values) is skipped instead of being compared or concatenated.
- Saving defaults into the saved variables on every login (`x = x or 330`) is gone.
### Removed
- `PaTiSharedPanel.lua` (legacy shared panel global).
### Known Issues
- Not tested in game yet; the quest API of this client (`C_QuestLog.GetSelectedQuest` …) is unconfirmed (`/phq debug`).
