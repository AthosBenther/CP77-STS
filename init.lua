local STS = {
    description = "Scopes that Scope",
    configs = dofile("configs.lua")
}

function STS.init()
    registerForEvent("onInit", function()
        local scopes = STS.configs.load()

        STS.settings = GetMod("nativeSettings")
        STS.settings.addTab("/STS", "Scopes that Scope")

        for scopeKind, scopeIndexes in pairs(scopes) do
            for scopeIndex, stats in pairs(scopeIndexes) do
                STS.settings.addSubcategory("/STS/" .. stats['name'], ucfirst(scopeKind) .. ": " .. ucfirst(stats['name']))
                --path, label, desc, min, max, step, currentValue, defaultValue, callback
                STS.settings.addRangeFloat(
                    "/STS/" .. stats['name'],            --path
                    "Zoom Level",                        --label
                    "Zoom Level",                        --description
                    0,                                   --min
                    12,                                  --max
                    0.25,                                --step
                    "%.2f",                              --format
                    stats['ZoomLevel']['custom'] + 0.0,  --currentValue
                    stats['ZoomLevel']['default'] + 0.0, --defaultValue
                    function(value)                      --callback
                        SetScopeZoom(scopeKind, scopeIndex, value)
                        scopes[scopeKind][scopeIndex]['ZoomLevel']['custom'] = value
                        STS.configs.save(scopes)
                    end
                )
                STS.settings.addRangeFloat(
                    "/STS/" .. stats['name'],             --path
                    "Range",                              --label
                    "Range",                              --description
                    0,                                    --min
                    200,                                  --max
                    1,                                    --step
                    "%.0f",                                --format
                    stats['RangeBonus']['custom'] + 0.0,  --currentValue
                    stats['RangeBonus']['default'] + 0.0, --defaultValue
                    function(value)                       --callback
                        SetScopeRange(scopeKind, scopeIndex, value)
                        scopes[scopeKind][scopeIndex]['RangeBonus']['custom'] = value
                        STS.configs.save(scopes)
                    end
                )
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
