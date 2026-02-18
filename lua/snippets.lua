local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function color_log(shortcut, color_code, name)
  return s(shortcut, {
    t('console.log(`\\x1b[' .. color_code .. 'm '),
    i(1, ' '),
    t ' \\x1b[0m`);',
    i(0),
  })
end

ls.add_snippets('javascript', {
  color_log('ccl-red', '31', 'console.log with Red'),
  color_log('ccl-green', '32', 'console.log with Green'),
  color_log('ccl-yellow', '33', 'console.log with Yellow'),
  color_log('ccl-blue', '34', 'console.log with Blue'),
  color_log('ccl-magenta', '35', 'console.log with Magenta'),
  color_log('ccl-cyan', '36', 'console.log with Cyan'),
})
