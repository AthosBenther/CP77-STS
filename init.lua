local STS = {
    description = "Scopes that Scope",
    configs = dofile("configs.lua")
}

function STS.init()
    registerForEvent("onInit", function()
        local scopes = STS.configs.load()

        for scopeKind, scopeIndexes in pairs(scopes) do
            for scopeIndex, stats in pairs(scopeIndexes) do
                SetScopeZoom(scopeKind, scopeIndex, stats['ZoomLevel']['custom'] + 0.0)
                SetScopeRange(scopeKind, scopeIndex, stats['RangeBonus']['custom'] + 0.0)
            end
        end
    end
    )
    return {
        STS = STS
    }
end

function ucfirst(string)
    return string:sub(1, 1):upper() .. string:sub(2)
end

function SetScopeZoom(scopeKind, scopeIndex, zoomLevel)
    local zoomLevelPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline0"
    local zoomQualityMultiplierPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline1"

    --zoomLevel
    TweakDB:SetFlat(zoomLevelPath .. ".value", zoomLevel)

    --zoomQualityMultiplier
    TweakDB:SetFlat(zoomQualityMultiplierPath .. ".modifierType", "Invalid")

    --print("STS: " .. scopeKind .. " " .. scopeIndex .. " Zoom set to " .. value)
end

function SetScopeRange(scopeKind, scopeIndex, rangeBonus)
    local rangeBonusPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline2"
    local rangeQualityMultiplierPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline3"

    --rangeBonus
    TweakDB:SetFlat(rangeBonusPath .. ".value", rangeBonus)

    --rangeQualityMultiplier
    TweakDB:SetFlat(rangeQualityMultiplierPath .. ".modifierType","Invalid")

    --print("STS: " .. scopeKind .. " " .. scopeIndex .. " Range set to " .. value)
end

return STS.init()
