if exists("g:loaded_plugin_template#default_vimrc")
  finish
endif
let g:loaded_plugin_template#default_vimrc = 1

call template#add ({
            \'pattern'  : '*.c',
            \'priority' : 100,
            \'template' : [[ 'COMMON_HEADER' ], []],
            \'creation' : g:template#creation,
            \'update'   : g:template#update,
            \'skip'     : g:template#skip,
            \})

call template#add ({
            \'pattern'  : '*.h',
            \'priority' : 100,
            \'template' : [[ 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]],
            \'creation' : g:template#creation,
            \'update'   : g:template#update,
            \'skip'     : g:template#skip
            \})

augroup Template
    au!
    autocmd BufNewFile  * call template#Template_create()
    autocmd BufWritePre * call template#Template_update()
augroup END
