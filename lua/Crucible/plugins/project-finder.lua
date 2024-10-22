local vim = vim
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local M = {}

function M.open_project_finder(opts)
    local function get_folders(path)
        local folders = {}
        for entry, type in vim.fs.dir(path, { depth = 5 }) do
            if type == "directory" or type == "link" then
                table.insert(folders, { label = entry, file = entry })
            end
        end
        return folders
    end

    local root_path = "~/"
    local folders = get_folders(root_path)
    local opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "Projects: ",
            finder = finders.new_table({
                results = folders,
                entry_maker = function(entry)
                    return {
                        value = entry.file,
                        ordinal = entry.file,
                        display = entry.label,
                        path = root_path .. "/" .. entry.label,
                    }
                end,
            }),
            sorter = sorters.get_fuzzy_file(),
            on_confirm = function(item, _, action)
                -- Open selected folder
                if action.event.key == " " then
                    vim.cmd("cd " .. item.file)
                end
            end,
        })
        :find()
end

return M
