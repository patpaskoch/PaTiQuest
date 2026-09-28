-- PaTiQuest strings, English (source and fallback). One key per line: L.KEY = "Text".
local _, ns = ...
ns.Locales = ns.Locales or {}
local L = ns.Locales.enUS or {}
ns.Locales.enUS = L

L.NO_API = "The quest API is not available in this client."
L.NO_SELECTION = "Select a quest in the quest log."
L.TEST_HINT = "/phq test shows a preview."
L.QUEST_ID = "Quest %d"
L.TEST_QUEST = "TEST QUEST"
L.TEST_OBJECTIVE_1 = "Collect 8 crystals: 3 / 8"
L.TEST_OBJECTIVE_2 = "Defeat the Frost Walker: 0 / 1"
L.LOCK_WINDOW = "Lock window"
L.SCALE = "Scale"
L.HIDDEN_HINT = "hidden. /phq show brings it back."
L.HELP = "/phq show, hide, test, lock, unlock, reset, settings, debug, version"
L.VERSION = "version %s"
