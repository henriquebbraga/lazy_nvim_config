function JavaUnitTestHelper()
  local buffer_name = vim.api.nvim_buf_get_name(0)

  local isTestFile = buffer_name:find("Test%.java$")
  if isTestFile then
    local original_class_path = buffer_name:gsub("/test/java/", "/main/java/"):gsub("Test%.java$", ".java")
    pcall(vim.cmd, "vert new " .. original_class_path)
    return
  end

  local isJavaFile = buffer_name:find("%.java$")
  if isJavaFile then
    local test_buffer_name = buffer_name:gsub("/main/java/", "/test/java/"):gsub("%.java$", "Test.java")
    pcall(vim.cmd, "vert new " .. test_buffer_name)
    return
  end

  print("not a java file")
end

function JavaRunUnitTests()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  local isTestFile = buffer_name:find("Test%.java$")

  if not isTestFile then
    print("Not a java test file.")
    return
  end

  local found = buffer_name:reverse():find("/.+")
  local class_name = buffer_name:reverse():sub(6, found - 1):reverse()

  vim.cmd("vnew")
  local termChannel = vim.fn.termopen("zsh")

  vim.defer_fn(function()
    vim.api.nvim_chan_send(
      termChannel,
      'export JAVA_HOME=$(/usr/libexec/java_home -v 11) && mvn clean test -Dtest="'
      .. class_name
      .. '" -DfailIfNoTests=false \n'
    )
  end, 50)
end
