local terminal_titles = require("config.terminal_titles")

return {
  "akinsho/bufferline.nvim",
  init = function()
    vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "TermLeave", "TermRequest" }, {
      group = vim.api.nvim_create_augroup("terminal_bufferline_titles", { clear = true }),
      callback = function()
        vim.schedule(function()
          pcall(vim.cmd.redrawtabline)
        end)
      end,
    })
  end,
  opts = {
    options = {
      name_formatter = function(buf)
        if vim.bo[buf.bufnr].buftype == "terminal" then
          return terminal_titles.terminal_name(buf.bufnr)
        end
      end,
    },
  },
}
