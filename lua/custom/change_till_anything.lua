local function co_recursive(co)
  if coroutine.status(co) == "dead" then
    return
  end

  if coroutine.status(co) == "suspended" then
    coroutine.resume(co)
  end
  vim.defer_fn(function()
    co_recursive(co)
  end, 5)
end

function HBChangeTillAnything()
  local or_pattern = "\\|"
  local find_termcode = vim.api.nvim_replace_termcodes(
    "/"
      .. ")"
      .. or_pattern
      .. "]"
      .. or_pattern
      .. "}"
      .. or_pattern
      .. '"'
      .. or_pattern
      .. "'"
      .. or_pattern
      .. "`"
      .. or_pattern
      .. ">"
      .. "<CR>",
    true,
    false,
    true
  )

  local find_termcode_no_quotes = vim.api.nvim_replace_termcodes(
    "/" .. ")" .. or_pattern .. "]" .. or_pattern .. "}" .. or_pattern .. ">" .. "<CR>",
    true,
    false,
    true
  )

  local main_co = coroutine.create(function()
    vim.api.nvim_feedkeys("v", "t", false)

    coroutine.yield()

    vim.api.nvim_feedkeys(find_termcode, "t", false)

    coroutine.yield()

    vim.cmd("norm l")
    coroutine.yield()
    local is_string_content = vim.treesitter.get_node():type() == "string_content"
      or vim.treesitter.get_node():type() == "escape_sequence"
    vim.cmd("norm h")

    coroutine.yield()
    if is_string_content then
      vim.api.nvim_feedkeys(find_termcode_no_quotes, "t", false)
      coroutine.yield()
      while
        vim.treesitter.get_node():type() == "string_content"
        or vim.treesitter.get_node():type() == "escape_sequence"
      do
        vim.api.nvim_feedkeys(find_termcode_no_quotes, "t", false)
        coroutine.yield()
      end
      local col_ = vim.api.nvim_win_get_cursor(0)[2]
      vim.api.nvim_get_current_line():sub(col_ + 1, col_ + 1)
    end

    vim.api.nvim_feedkeys("hc", "t", false)

    vim.cmd("nohl")
  end)
  co_recursive(main_co)
end
