local wk = require('which-key')

wk.register({
  ["ll"] =     { "Preview" } 
}, { prefix = "<localleader>" })


vim.keymap.set('n','<localleader>ll',vim.cmd.MarkdownPreview)
