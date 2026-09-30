-- PaTiQuest: saved settings and quest line building, no WoW API calls (tested in tests/logic_spec.lua).
local _, ns = ...
local Logic = {}
ns.Logic = Logic

Logic.SCHEMA = 1
Logic.SCALES = { 0.8, 0.9, 1, 1.1, 1.25, 1.5 }

Logic.DEFAULTS = {
    opacity = 0.75, -- panel body opacity (PaTiShared window; 0.3–1)
    snapWindows = true, -- snap to other PaTi windows at the end of a drag
    locked = false,
    collapsed = false,
    scale = 1,
    language = "auto",
}

-- 0.1.0 saved x, y (CENTER offsets) and locked; they are kept as they are, so the window stays where it was.
function Logic.Migrate(db)
    db = db or {}
    for key, value in pairs(Logic.DEFAULTS) do
        if db[key] == nil then db[key] = value end
    end
    db.schema = Logic.SCHEMA
    return db
end

-- "Restore Defaults": settings back, position kept.
function Logic.RestoreDefaults(db)
    for key, value in pairs(Logic.DEFAULTS) do db[key] = value end
    return db
end

-- quest (from the adapter): { title?, objectives = { raw objective tables } }.
-- Returns the display lines: the title (or nil, then the caller shows a localized "Quest <id>"), followed by
-- every readable objective text. Unreadable values (secret, missing, wrong type) are skipped, never compared.
function Logic.QuestLines(quest, isSecret)
    local title = quest.title
    if isSecret(title) or type(title) ~= "string" or title == "" then title = nil end
    local objectives = {}
    for _, objective in ipairs(type(quest.objectives) == "table" and quest.objectives or {}) do
        if type(objective) == "table" then
            local text = objective.text
            if not isSecret(text) and type(text) == "string" and text ~= "" then objectives[#objectives + 1] = text end
        end
    end
    return title, objectives
end
