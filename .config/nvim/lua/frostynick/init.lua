vim.opt.shada = "!,%5,'200,f1,<50,s10,h"
require("frostynick.set")
require("frostynick.lazy")
require("frostynick.remap")
-- local a = math.random(6)
local msg

-- Move to new file, then .gitignore it and check in lua if it exists.
-- if a == 1 then -- I'll add this as a joke later.. not good for a public config file by default lol
--     msg = [[Nuwuevim: sus]]
-- elseif a == 2 then
--     msg = [[Nuwuevim: yes]]
-- elseif a == 3 then
msg = [[Nuwuevim: ~hiii :3]]
-- elseif a == 4 then
--     msg = [[Nuwuevim: Your account has been terminated for security reasons. Please enter your SSN to continue exiting vim.]]
-- else
-- msg = [[Type <C-\><C-n> to enter insert mode.]]
-- end
print(msg)
-- :set rnu nu
