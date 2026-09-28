local DB
local testMode = false
local frame = CreateFrame("Frame", "PaTiQuestFrame", UIParent, "BackdropTemplate")
frame:SetSize(300, 150)
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })

local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("TOPLEFT", 14, -12)
title:SetText("PaTiQuest")
local body = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
body:SetPoint("TOPLEFT", 14, -38)
body:SetPoint("BOTTOMRIGHT", -14, 14)
body:SetJustifyH("LEFT")
title:Hide()
PaTiSharedPanel.Attach(frame,"PaTiQuest",{body},"/phq test zeigt die Vorschau.\n/phq lock und /phq unlock sperren das Fenster.")

local function update()
    if testMode then
        body:SetText("TESTQUEST\nSammle 8 Kristalle: 3 / 8\nBesiege den Frostwandler: 0 / 1")
        return
    end
    if not C_QuestLog or not C_QuestLog.GetSelectedQuest or not C_QuestLog.GetTitleForQuestID then
        body:SetText("Quest-API ist in diesem Client nicht verfuegbar.")
        return
    end
    local ok, questID = pcall(C_QuestLog.GetSelectedQuest)
    if not ok or not questID or questID == 0 then
        body:SetText("Waehle eine Quest im Questlog aus.\n/phq test zeigt die Vorschau.")
        return
    end
    local okTitle, questTitle = pcall(C_QuestLog.GetTitleForQuestID, questID)
    local lines = { okTitle and questTitle or ("Quest " .. questID) }
    if C_QuestLog.GetQuestObjectives then
        local okObjectives, objectives = pcall(C_QuestLog.GetQuestObjectives, questID)
        if okObjectives and type(objectives) == "table" then
            for _, objective in ipairs(objectives) do
                if type(objective) == "table" and objective.text then
                    lines[#lines + 1] = objective.text
                end
            end
        end
    end
    body:SetText(table.concat(lines, "\n"))
end

frame:SetScript("OnDragStart", function(self) if not DB.locked then self:StartMoving() end end)
frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); local _,_,_,x,y=self:GetPoint(); DB.x=x; DB.y=y end)
local events=CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("QUEST_LOG_UPDATE")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        PaTiQuestDB=PaTiQuestDB or {}; DB=PaTiQuestDB; DB.x=DB.x or 330; DB.y=DB.y or 150; DB.locked=DB.locked or false
        frame:ClearAllPoints(); frame:SetPoint("CENTER", UIParent, "CENTER", DB.x, DB.y)
    end
    update()
end)
SLASH_PATIQUEST1="/patiquest"
SLASH_PATIQUEST2="/phq"
SlashCmdList.PATIQUEST=function(message)
    local command=(message or ""):match("^%s*(.-)%s*$"):lower()
    if command=="test" then testMode=not testMode; update()
    elseif command=="show" then frame:Show()
    elseif command=="hide" then frame:Hide()
    elseif command=="lock" then DB.locked=true
    elseif command=="unlock" then DB.locked=false
    else print("|cff68caffPaTiQuest:|r /phq test, show, hide, lock, unlock") end
end
