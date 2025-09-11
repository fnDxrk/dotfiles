return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      render = "default",
      fps = 144,
      top_down = true,
      time_formats = {
        notification = "%H:%M",  -- <-- только часы и минуты
      },
    })
    vim.notify = require("notify")
  end
}
