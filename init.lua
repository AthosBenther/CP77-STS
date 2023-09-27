local STS = {
    description = "Yet Another Scope Mod",
    configs = dofile("configs.lua")
}

function STS.init()
    registerForEvent("onInit", function()
        local scopes = STS.configs.load()

        -- STS.settings = GetMod("nativeSettings")
        -- STS.settings.addTab("/STS", "Scopes that Scope")

        for kind, indexes in pairs(scopes) do
            -- STS.settings.addSubcategory("/STS/" .. kind, ucfirst(kind))
            for index, stats in pairs(indexes) do
                -- STS.settings.addRangeFloat(
                --     "/STS/" .. kind,                     -- path
                --     ucfirst(stats['name']),              --label
                --     "Zoom Level",                        --description
                --     0,                                   --min
                --     12,                                  --max
                --     0.25,                                --step
                --     "%.2f",                              -- format
                --     stats['ZoomLevel']['custom'] + 0.0,  --currentValue
                --     stats['ZoomLevel']['default'] + 0.0, --defaultValue
                --     function(value)                      --callback
                --         SetScopeStat(kind, index, value)
                --         scopes[kind][index]['ZoomLevel']['custom'] = value
                --         STS.configs.save(scopes)
                --     end)

                SetScopeStat(kind, index, stats['ZoomLevel']['custom'])
                scopes[kind][index]['ZoomLevel']['custom'] = stats['ZoomLevel']['custom']
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

function SetScopeStat(scopeKind, scopeIndex, value)
    local path = "Items.w_att_scope_" .. scopeKind .. "_" .. scopeIndex .. "_inline0"
    TweakDB:SetFlatNoUpdate(path .. ".statType", "BaseStats.ZoomLevel")
    TweakDB:SetFlatNoUpdate(path .. ".value", value)
    TweakDB:Update(path)
end

return STS.init()
