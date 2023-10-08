local configs = {
    json = dofile("app/json.lua")
}

function configs.load()
    local file = io.open("storage/scopes.json", "r");
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return configs.json.decode(content)
end

function configs.save(array)
    local content = configs.json.encode(array)
    local file = io.open("storage/scopes.json", "w+");
    if not file then return nil end
    file:write(content)
    file:close()
end

return configs;