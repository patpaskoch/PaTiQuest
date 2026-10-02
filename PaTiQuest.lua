-- PaTiQuest: the quest selected in the quest log and its objectives. Display only; no secure frames,
-- no addon communication.
local addonName, ns = ...
local UI, L, Logic = ns.UI, ns.UI.L, ns.Logic

local DB
local testMode = false

local WIDTH, HEIGHT, PAD = 300, 150, UI.Spacing.MD

local function say(key, ...)
    print("|cff68caffPaTiQuest:|r " .. L[key]:format(...))
end

local function isSecret(value) return issecretvalue ~= nil and issecretvalue(value) == true end

local function addonVersion()
    local getMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
    return getMetadata and getMetadata(addonName, "Version") or "?"
end

-- Quest API adapter (all calls guarded: the quest API of this client is unconfirmed) --------------

local function questApiAvailable()
    return C_QuestLog ~= nil and C_QuestLog.GetSelectedQuest ~= nil and C_QuestLog.GetTitleForQuestID ~= nil
end

-- Returns "NO_API" | "NO_SELECTION" | "OK", questID, { title, objectives }.
local function readSelectedQuest()
    if not questApiAvailable() then return "NO_API" end
    local ok, questID = pcall(C_QuestLog.GetSelectedQuest)
    if not ok or isSecret(questID) or type(questID) ~= "number" or questID == 0 then return "NO_SELECTION" end
    local quest = {}
    local okTitle, title = pcall(C_QuestLog.GetTitleForQuestID, questID)
    if okTitle then quest.title = title end
    if C_QuestLog.GetQuestObjectives then
        local okObjectives, objectives = pcall(C_QuestLog.GetQuestObjectives, questID)
        if okObjectives then quest.objectives = objectives end
    end
    return "OK", questID, quest
end

-- Window ---------------------------------------------------------------------------------------

local window = UI.CreateWindow("PaTiQuestFrame", "PaTiQuest", WIDTH, HEIGHT)
window:SetCombatMovable(true) -- no secure children: may be dragged in combat too (PaTiShared)
local body = window:CreateFontString(nil, "OVERLAY", UI.Fonts.Text)
body:SetPoint("TOPLEFT", PAD + 2, -UI.Sizes.HeaderHeight - UI.Spacing.SM)
body:SetPoint("BOTTOMRIGHT", -PAD, PAD)
body:SetJustifyH("LEFT")
body:SetJustifyV("TOP")

local function paint()
    if not DB then return end
    if testMode then
        body:SetText(table.concat({ L.TEST_QUEST, L.TEST_OBJECTIVE_1, L.TEST_OBJECTIVE_2 }, "\n"))
        return
    end
    local state, questID, quest = readSelectedQuest()
    if state == "NO_API" then
        body:SetText(L.NO_API)
    elseif state == "NO_SELECTION" then
        body:SetText(L.NO_SELECTION .. "\n" .. L.TEST_HINT)
    else
        local title, objectives = Logic.QuestLines(quest, isSecret)
        local lines = { title or L.QUEST_ID:format(questID) }
        for _, text in ipairs(objectives) do lines[#lines + 1] = text end
        body:SetText(table.concat(lines, "\n"))
    end
end

local function applyLayout()
    body:SetShown(not DB.collapsed)
    window:SetHeight(DB.collapsed and UI.Sizes.HeaderHeight or HEIGHT)
    window:SetTestMode(testMode)
end

-- Settings -------------------------------------------------------------------------------------

local modal

local function buildSettings()
    modal = UI.CreateModal("PaTiQuestSettings", function() return "PaTiQuest " .. L.SETTINGS end, 380)
    local scales = {}
    for _, scale in ipairs(Logic.SCALES) do
        scales[#scales + 1] = { value = scale, text = function() return ("%d %%"):format(scale * 100 + 0.5) end }
    end
    modal:AddSection("GENERAL")
    modal:AddRow("LANGUAGE", UI.CreateLanguageDropdown(modal, DB, 170))
    modal:AddRow("SCALE", UI.CreateDropdown(modal, 170, {
        items = function() return scales end,
        get = function() return DB.scale end,
        set = function(scale) DB.scale = scale; window:SetScale(scale) end,
    }))
    modal:AddControls(UI.CreateCheckbox(modal, "LOCK_WINDOW", {
        get = function() return window:IsLocked() end,
        set = function(locked) window:SetLocked(locked) end,
    }))
    UI.AddWindowSettings(modal, window) -- panel opacity + snapping (PaTiShared)
    modal:Finish(function()
        Logic.RestoreDefaults(DB)
        window:ApplyOpacity()
        UI.SetLanguage(DB.language)
        window:SetLocked(DB.locked)
        window:SetScale(DB.scale)
        applyLayout()
        paint()
    end)
end

local function openSettings()
    if not modal then buildSettings() end
    modal:Show()
end

-- Commands -------------------------------------------------------------------------------------

local function toggleTestMode()
    testMode = not testMode
    applyLayout()
    paint()
end

local function toggleCollapsed()
    DB.collapsed = not DB.collapsed
    applyLayout()
end

local function setShown(shown, quiet) -- no secure frames: fine in combat
    window:SetShown(shown)
    if not shown and not quiet then say("HIDDEN_HINT") end
    return true
end

-- Optional PaTiSuite control panel: the same rules as the commands, without chat lines (false = not possible now).
window.suiteSetShown = function(shown) return setShown(shown, true) end

local function resetPosition()
    DB.point, DB.relativePoint, DB.x, DB.y = nil, nil, nil, nil
    window:Attach(DB, 330, 150)
end

local function printDebug()
    local version, build, _, interface = GetBuildInfo()
    local state, questID = readSelectedQuest()
    print("|cff68caffPaTiQuest Debug:|r")
    for _, line in ipairs({
        ("Addon %s %s · PaTiShared UI %s"):format(addonName, addonVersion(), tostring(UI.VERSION)),
        ("WoW %s (build %s, interface %s) · locale %s · UI language %s"):format(tostring(version), tostring(build),
            tostring(interface), GetLocale(), UI.GetLanguage()),
        ("Quest API %s · GetQuestObjectives %s · state %s · quest %s · test mode %s"):format(
            questApiAvailable() and "yes" or "no", (C_QuestLog and C_QuestLog.GetQuestObjectives) and "yes" or "no",
            state, tostring(questID or "-"), testMode and "on" or "off"),
    }) do print("  " .. line) end
end

local COMMANDS = {
    [""] = function() setShown(not window:IsShown()) end,
    show = function() setShown(true) end,
    hide = function() setShown(false) end,
    test = toggleTestMode,
    lock = function() window:SetLocked(true) end,
    unlock = function() window:SetLocked(false) end,
    reset = resetPosition,
    settings = openSettings,
    debug = printDebug,
    version = function() say("VERSION", addonVersion()) end,
}

SLASH_PATIQUEST1 = "/patiquest"
SLASH_PATIQUEST2 = "/phq" -- kept for compatibility (see FOLLOW_UPS F11)
SlashCmdList.PATIQUEST = function(message)
    local command = COMMANDS[(message or ""):match("^%s*(.-)%s*$"):lower()]
    if command and DB then command() else say("HELP") end
end

window:SetMenu(function()
    if not DB then return {} end
    return {
        { text = "SETTINGS", onClick = openSettings },
        { text = window:IsLocked() and "UNLOCK" or "LOCK", onClick = function() window:SetLocked(not window:IsLocked()) end },
        { text = DB.collapsed and "EXPAND" or "COLLAPSE", onClick = toggleCollapsed },
        { text = "TEST_MODE", checked = testMode, onClick = toggleTestMode },
        { text = "HIDE", onClick = function() setShown(false) end },
    }
end)

-- Events ---------------------------------------------------------------------------------------

local events = CreateFrame("Frame")
for _, event in ipairs({ "PLAYER_LOGIN", "PLAYER_ENTERING_WORLD", "QUEST_LOG_UPDATE" }) do
    events:RegisterEvent(event)
end

events:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        PaTiQuestDB = Logic.Migrate(PaTiQuestDB)
        DB = PaTiQuestDB
        UI.SetLanguage(DB.language)
        window:Attach(DB, 330, 150)
        window:SetScale(DB.scale)
        applyLayout()
    end
    if not testMode then paint() end
end)
UI.OnLanguageChanged(paint)
