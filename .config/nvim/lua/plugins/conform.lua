return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      shfmt = {
        args = { "-i", "4", "-ci", "-bn", "-filename", "$FILENAME" },
      },
    },
  },
}
