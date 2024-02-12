--
-- https://github.com/navarasu/onedark.nvim
--

return {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
        style = 'darker', -- dark, darker, cool, deep, warm, warmer, light
        transparent = false,
        ending_tildes = false,
        colors = {
            -- The original grey color for `darker` is too dim.
            grey = '#6a6a72',
        },
    },
}
