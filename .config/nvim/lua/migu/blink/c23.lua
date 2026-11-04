local M = {}

local keywords = {
    "constexpr",
    "typeof",
    "typeof_unqual",
    "static_assert",
    "alignas",
    "alignof",
    "thread_local",
    "true",
    "false",
    "bool",
}

function M.new()
    return setmetatable({}, { __index = M })
end

function M:get_completions(_, callback)
    local kind = require("blink.cmp.types").CompletionItemKind.Keyword
    local items = {}
    for _, kw in ipairs(keywords) do
        items[#items + 1] = {
            label = kw,
            kind = kind,
            insertText = kw,
        }
    end
    callback({
        items = items,
        is_incomplete_forward = false,
        is_incomplete_backward = false,
    })
    return function() end -- cancellation no-op
end

return M
