-- https://github.com/LazyVim/LazyVim/discussions/4094#discussioncomment-10178217
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", "/home/pcino/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
