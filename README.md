# PaTiQuest

<img src="assets/icon-128.png" width="96" alt="PaTiQuest icon">

Shows the quest selected in your quest log and its objectives, for World of Warcraft: Forever (Interface 16001).
Display only.

> Status: 0.1.0, in development, not yet released. Not yet tested in game since the rework.

## Features
- Title and objectives of the selected quest; a hint when no quest is selected or the quest API is not available
- ••• menu: Settings, Lock, Collapse, Test Mode, Hide. Settings: language, scale, lock.
  Languages: English, Deutsch (others fall back to English)

## PaTiSuite

This addon is part of the **PaTiSuite** — a collection of small addons for World of Warcraft: Forever.
Each one is installed on its own and works on its own; none of them is needed by another.

- [PaTiSuite](https://github.com/patpaskoch/PaTiSuite) – optional control panel to show and hide the PaTi windows
- [PaTiHeal](https://github.com/patpaskoch/PaTiHeal) – healer party frames and click casting
- [PaTiAuras](https://github.com/patpaskoch/PaTiAuras) – buff, aura and proc watcher
- [PaTiTank](https://github.com/patpaskoch/PaTiTank) – tank HUD and aggro monitor
- [PaTiGroup](https://github.com/patpaskoch/PaTiGroup) – raid markers, ready check and pull timer
- **PaTiQuest** – selected quest and its objectives *(this addon)*
- [PaTiDungeon](https://github.com/patpaskoch/PaTiDungeon) – instance, group and combat status
- [PaTiSocial](https://github.com/patpaskoch/PaTiSocial) – "Party Social": quick emote and message buttons
- [PaTiAlerts](https://github.com/patpaskoch/PaTiAlerts) – one window for open problems

### Goes well with (optional)

- [PaTiDungeon](https://github.com/patpaskoch/PaTiDungeon) – instance, group and combat status — a fitting companion while questing in groups
- [PaTiSuite](https://github.com/patpaskoch/PaTiSuite) – shows and hides this window together with the other PaTi windows

## Installation
1. Download the release zip (`PaTiQuest-<version>.zip`).
2. Unpack it and copy the folder `PaTiQuest` into `World of Warcraft/<client>/Interface/AddOns/`.
3. Start WoW and enable PaTiQuest in the AddOns list.

## First steps
- Select a quest in your quest log — PaTiQuest shows it
- `/phq test` shows an example quest

## Settings
`/phq settings` or ••• → Settings: language, scale, window lock.
- **Window:** panel opacity (30–100 %)

## Commands
`/phq` or `/patiquest` — alone: show/hide · `settings` · `test` · `show` · `hide` · `lock` · `unlock` ·
`reset` (position) · `debug` · `version`

## Known limitations
- Only the selected quest, no quest list.

## Development

Architecture, tests and engineering rules of the suite: [PaTiAdmin](https://github.com/patpaskoch/PaTiAdmin). PaTiAdmin is not a WoW addon — players do not install it. The shared UI code (PaTiShared) is already embedded in this addon's `Shared/` folder; there is nothing extra to install.

## License
MIT — see [LICENSE](LICENSE). Copyright (c) 2026 Patrick Koch.
