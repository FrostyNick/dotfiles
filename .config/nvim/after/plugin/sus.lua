-- inspired by 
--
--    TarunDaCoder
--    /
--    sus.nvim
--
-- (Ps: My inspired plugin doesn't exist.)

local function notsus()
    print("(test) line count? " .. vim.api.nvim_buf_line_count(0))
end

notsus()

