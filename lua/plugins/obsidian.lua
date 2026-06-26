return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/.notes/",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    follow_url_func = function(url)
      vim.ui.input({
        prompt = "f for firefox",
      }, function(input)
        if input == "f" then
          vim.fn.jobstart({
            "open",
            "-a",
            "Firefox",
            url,
          }) -- Mac OS
        else
          vim.fn.jobstart({ "open", url }) -- Mac OS
        end
      end)
    end,
  },
}
