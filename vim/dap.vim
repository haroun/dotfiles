" Highlighting group
if !hlexists('DAPBreakpointSign')
  highlight link DAPBreakpointSign error
endif
if !hlexists('DAPLogPointSign')
  highlight link DAPLogPointSign todo
endif

" Completion
au FileType dap-repl lua require('dap.ext.autocompl').attach()

" Mappings.
" nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>5 :lua require'dap'.continue()<CR>
" nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>0 :lua require'dap'.step_over()<CR>
" nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>- :lua require'dap'.step_into()<CR>
" nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>= :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" launch.json
lua require('dap.ext.vscode').load_launchjs()

lua << EOF
local dap = require('dap')

-- Signs
vim.fn.sign_define('DapBreakpoint', {text='■', texthl='DAPBreakpointSign', linehl='', numhl='DAPBreakpointSign'})
vim.fn.sign_define('DapLogPoint', {text='◆', texthl='DAPLogPointSign', linehl='', numhl='DAPLogPointSign'})
vim.fn.sign_define('DapStopped', {text='→', texthl='', linehl='debugPC', numhl=''})

-- Adapters
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/repositories/dotfiles/javascript/modules/microsoft/vscode-node-debug2/out/src/nodeDebug.js'},
}

-- Configuration
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}
EOF
