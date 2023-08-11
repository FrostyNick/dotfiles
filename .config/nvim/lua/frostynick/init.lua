vim.opt.shada = "!,%5,'200,f1,<50,s10,h" -- 200 oldfiles now. :help 'shada'

require("frostynick.set")
require("frostynick.lazy")
require("frostynick.remap")

-- Move below to frostynick.??? later 
local msg = {"sus", "yes", "~hiii :3", "learn quickfix. nowww",
"my purpose is to outlive you",
"Your account has been terminated for security reasons. Please enter your SSN to continue exiting vim.",
[[In terminal, type <C-\><C-n> to enter normal mode.]]}
local a = math.random(#msg + 1)
if a > #msg then
    a = #msg
end

print("Nuwuvim: "..msg[a])
