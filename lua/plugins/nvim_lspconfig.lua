return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason-lspconfig").setup_handlers {
      -- default
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
      end,

      -- specific implementation
      ["jdtls"] = function()
      end,

      ["lua_ls"] = function()
        require 'lspconfig'.lua_ls.setup {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
              end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              runtime = {
                version = 'LuaJIT'
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME
                }
              }
            })
          end,
          settings = {
            Lua = {
              workspace = {
                library = {
                  string.format("%s/.hammerspoon/Spoons/EmmyLua.spoon/annotations", os.getenv("HOME")),
                },
              },
            }
          }
        }
      end,

      ["groovyls"] = function()
        local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
        local files = {}
        local filesIterator = vim.fs.dir(root_dir, {})

        local keepgoing = true
        while keepgoing do
          local file, type = filesIterator()
          if file == nil then
            keepgoing = false
          else
            if type == 'directory' then
              table.insert(files, file)
            end
          end
        end

        local classpath = {
          root_dir .. "/target"
        }
        for _, dir in ipairs(files) do
          table.insert(classpath, root_dir .. "/" .. dir .. "/target")
        end

        require 'lspconfig'.groovyls.setup {
          cmd = { "groovy-language-server" },
          root_dir = root_dir,
          settings = {
            groovy = {
              classpath = classpath
            }
          }
        }
      end
    }
  end,
}
