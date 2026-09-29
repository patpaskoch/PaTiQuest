# PaTiQuest

<img src="assets/icon-128.png" width="96" alt="PaTiQuest icon">

Shows the quest selected in your quest log and its objectives, for World of Warcraft: Forever (Interface 16001).
Display only.

> Status: 0.1.0, in development, not yet released. Not yet tested in game since the rework.

## Features
- Title and objectives of the selected quest; a hint when no quest is selected or the quest API is not available
- ••• menu: Settings, Lock, Collapse, Test Mode, Hide. Settings: language, scale, lock.
  Languages: English, Deutsch (others fall back to English)

## Installation
1. Download the release zip (`PaTiQuest-<version>.zip`).
2. Unpack it and copy the folder `PaTiQuest` into `World of Warcraft/<client>/Interface/AddOns/`.
3. Start WoW and enable PaTiQuest in the AddOns list.

## First steps
- Select a quest in your quest log — PaTiQuest shows it
- `/phq test` shows an example quest

## Settings
`/phq settings` or ••• → Settings: language, scale, window lock.

## Commands
`/phq` or `/patiquest` — alone: show/hide · `settings` · `test` · `show` · `hide` · `lock` · `unlock` ·
`reset` (position) · `debug` · `version`

## Known limitations
- Only the selected quest, no quest list.

## License
MIT — see [LICENSE](LICENSE). Copyright (c) 2026 Patrick Koch.
