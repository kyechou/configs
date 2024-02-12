--
-- https://github.com/rightson/vim-p4-syntax
--

-- NOTE:
-- The P4 syntax support is not great with any syntax plugin. When I have time,
-- consider adding P4LS (https://github.com/dmakarov/p4ls) to the mason registry
-- (https://github.com/mason-org/mason-registry).
-- Also see https://github.com/jafingerhut/p4-guide/blob/master/README-editor-support.md

return {
    'rightson/vim-p4-syntax',
    ft = { 'p4' },
}
