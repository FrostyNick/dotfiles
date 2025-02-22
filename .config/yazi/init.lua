require("git"):setup()
require("bookmarks"):setup({
  persist = "vim", -- none(default)|all|vim - bookmarks persist like in vim (global letters save; lowercase don't)
})
