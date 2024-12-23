return {
    {
        'pest-parser/pest.vim',
        ft = 'pest',
        build = "cargo install pest-language-server",
        opts = {},
    },
}
