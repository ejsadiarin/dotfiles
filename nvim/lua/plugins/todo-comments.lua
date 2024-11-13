return {
    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            signs = false,
        },
        keys = {
            { '<leader><leader>', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
            { '<leader>ek',       '<cmd>Trouble todo toggle<cr>',                                   desc = 'Todo (Trouble)' },
        },
    },
}
