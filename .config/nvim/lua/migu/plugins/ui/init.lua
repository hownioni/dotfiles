local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local pywal_file = vim.fn.expand("$HOME/.cache/wal/colors.sh")
local display_server = os.getenv("XDG_SESSION_TYPE")

local require_tbl = {
    require("migu.plugins.ui.alpha"),
    require("migu.plugins.ui.image"),
    require("migu.plugins.ui.lualine"),
    require("migu.plugins.ui.neo-tree"),
}

if file_exists(pywal_file) and display_server == "x11" then
    vim.list_extend(require_tbl, {
        require("migu.plugins.ui.pywal"),
    })
elseif display_server == "wayland" then
    vim.list_extend(require_tbl, {
        require("migu.plugins.ui.wlcolors"),
    })
end

return require_tbl
