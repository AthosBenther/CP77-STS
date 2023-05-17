Sandbox = {
    description = "Yet another scope mod"
}


local YASM = {}


function YASM.init()
    registerForEvent("onInit", function()
        DBG.Alala()
    end)
    return {
        dbg = DBG
    }
end

function YASM.Alala()
    print("Sandbox says: Alala!")
    local scopes = dofile("scopes.lua")

    for kind, indexes in pairs(scopes) do
        for index, stats in pairs(indexes) do
            for stat, value in pairs(stats) do
                SetScopeStat(kind, index, stat, value)
            end
        end
    end

    print("wololo")
end

function SetScopeStat(scopeKind, scopeIndex, stat, value)
    local path = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline0"
    TweakDB:SetFlatNoUpdate(path .. ".statType", "BaseStats." .. stat)
    TweakDB:SetFlatNoUpdate(path .. ".value", value)
    TweakDB:Update(path)
end

return YASM.init()

-- print(Dump(GetMod("Sandbox"), false))
-- print(Dump(TweakDB:GetRecord("Items.w_att_scope_short_04")))
-- Items.w_att_scope_short_04_inline0

-- TweakDB:SetFlatNoUpdate("Items.w_att_scope_short_04_inline0.modifierType = Additive")
-- TweakDB:SetFlatNoUpdate("Items.w_att_scope_short_04_inline0.statType = BaseStats.ZoomLevel")
-- TweakDB:SetFlatNoUpdate("Items.w_att_scope_short_04_inline0.value = 5")
-- TweakDB:Update("Items.w_att_scope_short_04_inline0")
