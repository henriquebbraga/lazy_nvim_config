local jdtls = require("jdtls")
local on_attach = require("custom.lsp_handler").on_attach -- change to yours

function main()
  local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1])
  local home = os.getenv("HOME")
  local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  -- vim.uv.os_setenv("JAVA_HOME",  "/opt/homebrew/Cellar/openjdk@21/21.0.9/libexec/openjdk.jdk/Contents/Home")

  vim.cmd(":set tabstop=4")
  vim.cmd(":set shiftwidth=4")

  local config = {
    on_attach = on_attach,
    cmd = {
      "jdtls",                                                       -- need to be on your PATH
      "--jvm-arg=-javaagent:" .. home .. "/tools/lombok/lombok.jar", -- need for lombok magic
      -- "-configuration",
      -- home .. "/tools/jdtls/config_mac",
      "-data",
      eclipse_workspace,
    },
    root_dir = root_dir,
  }

  jdtls.start_or_attach(config)
end

local success = pcall(main)

if not success then
  vim.defer_fn(main, 1000)
end
