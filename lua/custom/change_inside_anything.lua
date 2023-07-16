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

local function get_closing(character)
  if character == "(" then
    return ")"
  end
  if character == "[" then
    return "]"
  end
  if character == "{" then
    return "}"
  end
  if character == "<" then
    return ">"
  end
  return character
end

function HBChangeInsideAnything()
  local or_pattern = "\\|"
  local find_termcode = vim.api.nvim_replace_termcodes(
    "?"
      .. "("
      .. or_pattern
      .. "["
      .. or_pattern
      .. "{"
      .. or_pattern
      .. '"'
      .. or_pattern
      .. "'"
      .. or_pattern
      .. "`"
      .. or_pattern
      .. "<"
      .. "<CR>",
    true,
    false,
    true
  )

  local find_termcode_no_quotes = vim.api.nvim_replace_termcodes(
    "?" .. "(" .. or_pattern .. "[" .. or_pattern .. "{" .. or_pattern .. "<" .. "<CR>",
    true,
    false,
    true
  )
  local main_co = coroutine.create(function()
    local initial_pos = vim.api.nvim_win_get_cursor(0)

    coroutine.yield()

    vim.api.nvim_feedkeys(find_termcode, "t", false)

    coroutine.yield()

    if vim.treesitter.get_node():type() == "string_content" then
      vim.api.nvim_feedkeys(find_termcode, "t", false)
    end

    coroutine.yield()

    local col = vim.api.nvim_win_get_cursor(0)[2]
    local char = vim.api.nvim_get_current_line():sub(col + 1, col + 1)

    local succeeded, result = pcall(string.find, "\"'`", char)
    if succeeded and result then
      vim.cmd("norm l")
      coroutine.yield()
      local is_string_content = vim.treesitter.get_node():type() == "string_content"
        or vim.treesitter.get_node():type() == "escape_sequence"

      vim.cmd("norm h")
      coroutine.yield()
      if is_string_content then
      else
        vim.api.nvim_feedkeys(find_termcode_no_quotes, "t", false)
        coroutine.yield()
        while vim.treesitter.get_node():type() == "string_content" do
          vim.api.nvim_feedkeys(find_termcode_no_quotes, "t", false)
          coroutine.yield()
        end
        local col_ = vim.api.nvim_win_get_cursor(0)[2]
        char = vim.api.nvim_get_current_line():sub(col_ + 1, col_ + 1)
        print(char)
      end
    end

    -- test if it was inside
    local open_limiter_pos = vim.api.nvim_win_get_cursor(0)
    coroutine.yield()
    local find_closing_pos = vim.api.nvim_replace_termcodes("/" .. get_closing(char) .. "<CR>", true, false, true)
    vim.api.nvim_feedkeys(find_closing_pos, "t", false)
    coroutine.yield()
    local close_limiter_pos = vim.api.nvim_win_get_cursor(0)
    if
      open_limiter_pos[1] < initial_pos[1]
      or (open_limiter_pos[1] == initial_pos[1] and open_limiter_pos[2] <= initial_pos[2])
    then
      if
        close_limiter_pos[1] > initial_pos[1]
        or (close_limiter_pos[1] == initial_pos[1] and close_limiter_pos[2] >= initial_pos[2])
      then
        coroutine.yield()
        vim.api.nvim_win_set_cursor(0, open_limiter_pos)
        coroutine.yield()
        vim.cmd("nohl")
        vim.api.nvim_feedkeys("ci" .. char, "t", false)
        return
      end
    end
    vim.cmd("nohl")
    vim.api.nvim_win_set_cursor(0, initial_pos)
  end)
  co_recursive(main_co)
end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<BS>a", ":lua HBChangeInsideAnything()<Cr>", opts)
