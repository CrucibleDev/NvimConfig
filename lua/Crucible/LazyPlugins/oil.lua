return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
        -- Register the custom column for icons
        local os_type = vim.loop.os_uname().sysname
        if os_type == "Windows_NT" then
            local constants = require("oil.constants")
            local FIELD_TYPE = constants.FIELD_TYPE
            local FIELD_NAME = constants.FIELD_NAME

            require("oil.columns").register("custom_icons", {
                render = function(entry)
                    if not entry or not entry[FIELD_TYPE] then
                        return { "❓", "OilIcon" }  -- Return a question mark icon for invalid entries
                    end

                    local field_type = entry[FIELD_TYPE]
                    local icon

                    -- Set icon based on the file type
                    if field_type == "directory" then
                        icon = "📁"  -- Icon for directories
                    elseif field_type == "file" then
                        local name = entry[FIELD_NAME]
                        if name then
                            local extension = name:match("^.+%.(.+)$")
                            -- Set different icons based on file extension
                            if extension == "lua" then
                                icon = "🌙"  -- Lua files
                            elseif extension == "txt" then
                                icon = "📄"  -- Text files
                            elseif extension == "md" then
                                icon = "📑"  -- Markdown files
                            elseif extension == "csv" or extension == "sql" then
                                icon = "📊"  -- CSV/SQL files
                            elseif extension == "json" then
                                icon = "🗄️"  -- JSON files
                            elseif extension == "xml" then
                                icon = "📜"  -- XML files
                            elseif extension == "html" or extension == "htm" then
                                icon = "🌐"  -- HTML files
                            elseif extension == "css" then
                                icon = "🎨"  -- CSS files
                            elseif extension == "js" then
                                icon = "💻"  -- JavaScript files
                            elseif extension == "jsx" or extension == "tsx" then
                                icon = "⚛️"  -- JSX/TSX files
                            elseif extension == "py" then
                                icon = "🐍"  -- Python files
                            elseif extension == "java" then
                                icon = "☕"  -- Java files
                            elseif extension == "c" or extension == "cpp" or extension == "h" then
                                icon = "🛠️"  -- C/C++ files and headers
                            elseif extension == "rb" then
                                icon = "💎"  -- Ruby files
                            elseif extension == "go" then
                                icon = "🐹"  -- Go files
                            elseif extension == "rs" then
                                icon = "🦀"  -- Rust files
                            elseif extension == "php" then
                                icon = "🦙"  -- PHP files
                            elseif extension == "swift" then
                                icon = "🚀"  -- Swift files
                            elseif extension == "ts" then
                                icon = "📦"  -- TypeScript files
                            elseif extension == "scss" or extension == "sass" then
                                icon = "💅"  -- SCSS/SASS files
                            elseif extension == "yaml" or extension == "yml" then
                                icon = "📝"  -- YAML files
                            elseif extension == "bat" then
                                icon = "💾"  -- Batch files
                            elseif extension == "sh" then
                                icon = "🐚"  -- Shell scripts
                            elseif extension == "ps1" then
                                icon = "🖥️"  -- PowerShell scripts
                            elseif extension == "pl" then
                                icon = "🐪"  -- Perl files
                            elseif extension == "clj" then
                                icon = "💻"  -- Clojure files
                            elseif extension == "m" then
                                icon = "📊"  -- MATLAB files
                            elseif extension == "dart" then
                                icon = "🐦"  -- Dart files
                            elseif extension == "k" then
                                icon = "🔍"  -- Kotlin files
                            elseif extension == "r" then
                                icon = "📈"  -- R files
                            elseif extension == "awk" then
                                icon = "📜"  -- AWK files
                            elseif extension == "erl" then
                                icon = "⚙️"  -- Erlang files
                            elseif extension == "d" then
                                icon = "🔄"  -- D programming files
                            elseif extension == "nim" then
                                icon = "🧶"  -- Nim files
                            elseif extension == "g" then
                                icon = "⚙️"  -- G-code files
                            elseif extension == "f" or extension == "fs" or extension == "fsi" then
                                icon = "💻"  -- F# files
                            elseif extension == "v" then
                                icon = "🔧"  -- VHDL files
                            elseif extension == "p" then
                                icon = "📦"  -- Prolog files
                            elseif extension == "tcl" then
                                icon = "📜"  -- Tcl files
                            elseif extension == "zip" or extension == "tar" or extension == "gz" or extension == "bz2" or extension == "7z" then
                                icon = "🗜️"  -- Compressed files
                            elseif extension == "jpg" or extension == "jpeg" or extension == "png" or extension == "gif" or extension == "bmp" or extension == "svg" then
                                icon = "🖼️"  -- Image files
                            elseif extension == "mp4" or extension == "avi" or extension == "mov" or extension == "wmv" or extension == "mkv" or extension == "flv" or extension == "vob" then
                                icon = "🎥"  -- Video files
                            elseif extension == "mp3" or extension == "wav" or extension == "flac" or extension == "m4a" then
                                icon = "🎶"  -- Audio files
                            elseif extension == "doc" or extension == "docx" or extension == "pdf" then
                                icon = "📃"  -- Word documents
                            elseif extension == "xls" or extension == "xlsx" then
                                icon = "📊"  -- Excel files
                            elseif extension == "ppt" or extension == "pptx" then
                                icon = "📈"  -- PowerPoint presentations
                            elseif extension == "iso" then
                                icon = "💾"  -- ISO files
                            elseif extension == "torrent" then
                                icon = "🌊"  -- Torrent files
                            elseif extension == "lnk" then
                                icon = "🔗"  -- Icon for links or other types
                            else
                                icon = "📄"  -- Default icon for unknown files
                            end
                        else
                            icon = "📄"  -- Default icon if no name found
                        end
                    else
                        icon = "🔗"  -- Icon for links or other types
                    end

                    return { icon, "OilIcon" }  -- Return icon and highlight group
                end,
                parse = function(line) return line:match("^(%S+)%s+(.*)$") end,
            })
            -- Setup oil.nvim with the custom column
            require('oil').setup {
                columns = { 'custom_icons' },  -- Use your custom icon column
                view_options = {
                    show_hidden = true,
                    is_always_hidden = function(name)
                        return vim.startswith(name, '..')
                    end,
                },
            }
        end


        -- Key mapping for opening parent directory
        vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
