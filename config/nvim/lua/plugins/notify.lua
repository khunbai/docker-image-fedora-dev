return {
  "rcarriga/nvim-notify",
  opts = {
    stages = "slide",
    timeout = 5000,
    fps = 30,
    top_down = false,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
}

