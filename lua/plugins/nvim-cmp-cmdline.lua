return {
  "hrsh7th/cmp-cmdline",
  dependencies = {
  "hrsh7th/nvim-cmp",
  },
  init = function ()
    local cmp = require("cmp")

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' }
          }
        }
      })
    })
  end
}
