return {
  name = "g++ debug build",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "g++" },
      args = {
          "-Wall",
          "-Wextra",
          "-fsanitize=undefined,address",
          "-D_GLIBCXX_DEBUG",
          "-std=c++17",
          "-ggdb",
          file,
      },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
