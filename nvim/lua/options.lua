local options = {
    --------------------
    -- Encoding
    --------------------
    -- Internal encoding
    encoding = "UTF-8",

    -- Current buffer encoding
    fileencoding = "UTF-8",

    --------------------
    -- Indent
    --------------------
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 0,

    -- Tab to space
    smarttab = true,
    expandtab = true,

    -- autoindent
    autoindent = true,

    --------------------
    -- UI
    --------------------
    -- Display number
    number = true,

    -- Display window title
    title = true,

    -- Always display status
    laststatus = 2,

    --------------------
    -- Search
    --------------------
    -- Include both uppercase and lowercase
    ignorecase = true,

    -- Distinguish in case of uppercase input
    smartcase = true,

    -- Searches wrap around the end
    wrapscan = true,

    -- Realtime search
    incsearch = true,

    -- Display search highlight
    hlsearch = true,

    --------------------
    -- Other
    --------------------
    -- No bell
    visualbell = true,

    -- Override  mouse options
    mouse = ""
}

for k, v in pairs(options) do
    vim.opt[k] = v
end
