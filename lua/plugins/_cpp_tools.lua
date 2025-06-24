local M = {}

function M.config()
    require("nt-cpp-tools").setup({
        preview = {
            quit = "q",
            accept = "<C-f>",
        },
    })

    vim.keymap.set(
        { "n", "v" },
        "<Leader>cgc",
        vim.cmd.TSCppDefineClassFunc,
        { remap = false, desc = "Generate class definition" }
    )
    vim.keymap.set(
        { "n", "v" },
        "<Leader>cgi",
        vim.cmd.TSCppMakeConcreteClass,
        { remap = false, desc = "Generate concrete class from interface" }
    )
end

return M
