return {
    'saghen/blink.cmp',
    version = "1.*",

    opts = {
        keymap = { preset = "enter" },
        appearance = {
            nerd_font_variant = "mono"
        },
        completion = { documentation = { auto_show = false } },
        sources = {
            default = { "lsp", "path", "buffer" },
        },
        fuzzy = {
            implementation = "prefer_rust_with_warning"
        },
    },
    opts_extend = { "sources.default" }
}
