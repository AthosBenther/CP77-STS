local STS = {
    description = "Scopes that Scope",
    configs = dofile("app/configs.lua"),
    help = dofile('app/helpers.lua')
}

function STS.init()
    registerForEvent("onInit", function()
        local scopes = STS.configs.load()

        STS.settings = GetMod("nativeSettings")
        STS.settings.addTab("/STS", "Scopes that Scope")

        for scopeKind, scopeIndexes in pairs(scopes) do
            for scopeIndex, stats in pairs(scopeIndexes) do
                STS.settings.addSubcategory("/STS/" .. stats['name'],
                    STS.help.capitalize(scopeKind) .. ": " .. STS.help.capitalize(stats['name']))
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
                        SetScopeZoom(
                            scopeKind,
                            scopeIndex, stats['ZoomLevel']['custom'] + 0.0,
                            stats['ZoomLevel']['inlineIndex'],
                            stats['ZoomLevel']['combinedInlineIndex']
                        )

                        scopes[scopeKind][scopeIndex]['ZoomLevel']['custom'] = value
                        STS.configs.save(scopes)
                    end
                )


                if (stats['RangeBonus'] ~= nil) then
                    STS.settings.addRangeFloat(
                        "/STS/" .. stats['name'],             --path
                        "Range",                              --label
                        "Range",                              --description
                        0,                                    --min
                        200,                                  --max
                        1,                                    --step
                        "%.0f",                               --format
                        stats['RangeBonus']['custom'] + 0.0,  --currentValue
                        stats['RangeBonus']['default'] + 0.0, --defaultValue
                        function(value)                       --callback
                            SetScopeRange(
                                scopeKind,
                                scopeIndex,
                                stats['RangeBonus']['custom'] + 0.0,
                                stats['RangeBonus']['inlineIndex'],
                                stats['RangeBonus']['combinedInlineIndex']
                            )

                            scopes[scopeKind][scopeIndex]['RangeBonus']['custom'] = value
                            STS.configs.save(scopes)
                        end
                    )
                end
                SetScopeZoom(
                    scopeKind,
                    scopeIndex, stats['ZoomLevel']['custom'] + 0.0,
                    stats['ZoomLevel']['inlineIndex'],
                    stats['ZoomLevel']['combinedInlineIndex']
                )

                if (stats['RangeBonus'] ~= nil) then
                    SetScopeRange(
                        scopeKind,
                        scopeIndex,
                        stats['RangeBonus']['custom'] + 0.0,
                        stats['RangeBonus']['inlineIndex'],
                        stats['RangeBonus']['combinedInlineIndex']
                    )
                end
            end
        end
    end
    )
    return {
        STS = STS
    }
end

function SetScopeZoom(scopeKind, scopeIndex, zoomLevel, inlineIndex, combinedInlineIndex)
    local zoomLevelPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline" .. inlineIndex


    --zoomLevel
    TweakDB:SetFlat(zoomLevelPath .. ".value", zoomLevel)

    --zoomQualityMultiplier
    if (combinedInlineIndex ~= nil) then
        local zoomQualityMultiplierPath = "Items.w_att_scope_" ..
            scopeKind .. "_" .. scopeIndex .. "_inline" .. combinedInlineIndex
        TweakDB:SetFlat(zoomQualityMultiplierPath .. ".modifierType", "Invalid")
    end
end

function SetScopeRange(scopeKind, scopeIndex, rangeBonus, inlineIndex, combinedInlineIndex)
    local rangeBonusPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline" .. inlineIndex


    --rangeBonus
    TweakDB:SetFlat(rangeBonusPath .. ".value", rangeBonus)

    if (combinedInlineIndex ~= nil) then
        local rangeBonusPath = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline" .. combinedInlineIndex
        TweakDB:SetFlat(rangeBonusPath .. ".modifierType", "Invalid")
    end

    --print("STS: " .. scopeKind .. " " .. scopeIndex .. " Range set to " .. value)
end

return STS.init()
