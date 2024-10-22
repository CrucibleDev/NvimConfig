return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { 
        {
            "echasnovski/mini.icons", 
            opts = {
                -- Corrected conditional expression to set 'ascii' if nerd font is not available
                style = vim.g.have_nerd_font and 'nerdfont' or 'ascii',
            } 
        } 
    },
    config = function()
        -- Get the operating system type
        local os_type = vim.loop.os_uname().sysname

        -- Setup oil.nvim
        require('oil').setup {}

        -- Key mapping for opening parent directory
        vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
