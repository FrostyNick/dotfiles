local infile = io.open(".bash_alias", "r")
local outfile = io.open(".bash_alias_tui", "a") -- or "w"

if not infile then print("File not found for reading.") return end

local alias, url
for line in infile:lines() do
    alias, url = line:match("^alias (%S+)='[^']+ (.+)'$") -- removes any keyword before

    if alias and url then
        local newLine = alias .. "=url " .. url:gsub('"', '')
        outfile:write(newLine .. "\n")
    end
end

--[[
**Pattern**: `^alias (%S+)='(.+)'$`
- `alias`: Matches the literal word "alias".
- `(%S+)`: Captures a sequence of non-space characters (the alias name).
- `='(.+)'`: Matches an equals sign followed by a string in single quotes (the URL), capturing the URL.
--]]

infile:close()
outfile:close()
