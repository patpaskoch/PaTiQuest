-- PaTiQuest settings and quest lines. Run via PaTiAdmin/tools/check.sh.
local wow = require("wow_api")

local function load()
    return wow.loadAddonFile("Logic.lua", {}).Logic
end

local never = function() return false end

describe("Logic.Migrate", function()
    it("creates defaults and keeps the 0.1.0 position and lock", function()
        local db = load().Migrate({ x = 330, y = 150, locked = true })
        assert.equal(330, db.x)
        assert.equal(150, db.y)
        assert.is_true(db.locked)
        assert.is_false(db.collapsed)
        assert.equal(1, db.scale)
        assert.equal(1, db.schema)
    end)

    it("keeps saved false values", function()
        local db = load().Migrate({ schema = 1, locked = false, collapsed = false, scale = 0.9 })
        assert.is_false(db.locked)
        assert.equal(0.9, db.scale)
    end)
end)

describe("Logic.RestoreDefaults", function()
    it("keeps the position", function()
        local db = load().RestoreDefaults({ x = 1, y = 2, scale = 1.5, locked = true })
        assert.equal(1, db.x)
        assert.equal(1, db.scale)
        assert.is_false(db.locked)
    end)
end)

describe("Logic.QuestLines", function()
    it("returns the title and every objective text in order", function()
        local title, objectives = load().QuestLines({ title = "Wölfe jagen", objectives = {
            { text = "Wolfsfelle: 3/8" }, { text = "Rudelführer besiegt: 0/1" } } }, never)
        assert.equal("Wölfe jagen", title)
        assert.same({ "Wolfsfelle: 3/8", "Rudelführer besiegt: 0/1" }, objectives)
    end)

    it("skips empty, broken and secret values", function()
        local secret = {}
        local isSecret = function(value) return rawequal(value, secret) end
        local title, objectives = load().QuestLines({ title = secret, objectives = {
            { text = "ok" }, { text = "" }, "not a table", { text = secret }, { finished = true } } }, isSecret)
        assert.is_nil(title)
        assert.same({ "ok" }, objectives)
    end)

    it("copes with missing objectives", function()
        local title, objectives = load().QuestLines({ title = "Q" }, never)
        assert.equal("Q", title)
        assert.same({}, objectives)
    end)
end)

describe("Collapse state", function()
    it("a saved collapsed = true stays; Restore Defaults expands (documented) and keeps the position", function()
        local Logic = load()
        local db = Logic.Migrate({ x = 7, collapsed = true })
        assert.is_true(db.collapsed)
        Logic.RestoreDefaults(db)
        assert.is_false(db.collapsed)
        assert.equal(7, db.x)
    end)
end)

describe("Window settings (panel opacity)", function()
    it("old saves get 75 %; a saved value stays; Restore Defaults resets it; an old snapWindows is ignored", function()
        local M = load()
        local db = M.Migrate({ x = 12, y = 34 })
        assert.equal(0.75, db.opacity)
        assert.equal(12, db.x)
        db = M.Migrate({ opacity = 0.4, snapWindows = false })
        assert.equal(0.4, db.opacity)
        db = M.RestoreDefaults({ opacity = 0.4, snapWindows = false, bindings = {}, bindingRanks = {}, watch = {} })
        assert.equal(0.75, db.opacity)
    end)
end)
