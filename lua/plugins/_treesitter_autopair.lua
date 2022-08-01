local M = {}

function M.config()
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    local cond = require('nvim-autopairs.conds')
    local ts_conds = require('nvim-autopairs.ts-conds')
    npairs.setup({})
    npairs.add_rules({
        Rule('<', '>', 'rust')
            :with_pair(ts_conds.is_ts_node({
                'type_identifier',
                'let_declaration',
                'parameters',
                'function_item',
                'return_type',
            }))
            :with_cr(cond.none()),
    })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

return M
