local M = {}

local function clean_title(title)
  if not title or title == "" then
    return nil
  end

  title = title:gsub("[%c\127]", ""):gsub("^%s+", ""):gsub("%s+$", "")
  if title == "" then
    return nil
  end

  return title
end

local function command_basename(command)
  if not command or command == "" then
    return nil
  end

  local argv0 = command:match("^%s*(%S+)")
  if not argv0 or argv0 == "" then
    return nil
  end

  return vim.fn.fnamemodify(argv0, ":t")
end

local function terminal_name_from_buffer(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local command = name:match("^term://.*//%d+:(.+)$")
  return command_basename(command)
end

function M.terminal_name(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local title = clean_title(vim.b[bufnr].term_title)

  -- If the title still has Neovim's default terminal-buffer shape, reduce it
  -- to the executable name instead of showing `$PID:/path/to/program`.
  if title then
    local pid_command = title:match("^%d+:(.+)$") or title:match("^%$PID:(.+)$")
    if pid_command then
      return command_basename(pid_command) or title
    end

    if not title:match("^term://") then
      return title
    end
  end

  return terminal_name_from_buffer(bufnr) or "terminal"
end

function M.statusline_filename(name)
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].buftype == "terminal" then
    return M.terminal_name(bufnr)
  end

  return name
end

local function current_cwd_name()
  local cwd = vim.fn.getcwd()

  if vim.g.window_title_shorten_home ~= false then
    cwd = vim.fn.fnamemodify(cwd, ":~")
  end

  return clean_title(cwd)
end

local function current_buffer_name(bufnr)
  if vim.bo[bufnr].buftype == "terminal" then
    return M.terminal_name(bufnr)
  end

  local name = clean_title(vim.fn.expand("%:t")) or "[No Name]"
  if vim.bo[bufnr].modified then
    name = name .. " +"
  end

  return name
end

function M.window_title(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local parts = { current_buffer_name(bufnr), current_cwd_name(), "nvim" }
  return table.concat(
    vim.tbl_filter(function(part)
      return part and part ~= ""
    end, parts),
    " - "
  )
end

function M.apply_window_title()
  vim.o.title = true

  -- 'titlestring' is statusline-expanded, so literal percent signs in terminal
  -- titles must be escaped before assigning the rendered title.
  vim.o.titlestring = M.window_title():gsub("%%", "%%%%")
  pcall(vim.cmd.redraw)
end

function M.toggle_home_path()
  vim.g.window_title_shorten_home = vim.g.window_title_shorten_home == false
  M.apply_window_title()

  local home_format = vim.g.window_title_shorten_home ~= false and "~" or vim.fn.expand("~")
  vim.notify("Window title home path: " .. home_format, vim.log.levels.INFO)
end

return M
