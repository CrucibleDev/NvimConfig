return {
    {
        dir = vim.fn.stdpath("config") .. "/lua/Crucible",
        config = function()
            require('Crucible.plugins.project-finder') -- Load your project-finder module
            -- Set the key mapping for opening the project finder
            vim.keymap.set("n", "<leader>sr",
                '<cmd>lua require("Crucible.plugins.project-finder").open_project_finder()<CR>',
                { desc = "[S]earch di[R]ectory" })
        end
    }
}
