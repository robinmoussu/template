source template.vim

" exemple of vimrc file

let s:template_path = expand('%:p:h') . '/'

let s:creation = [
            \ [ '<AUTHOR_NAME>',   'Robin Moussu' ],
            \ [ '<MAIL>',          'robin.moussu+github <at> gmail.com' ],
            \ [ '<USER>',          g:Shell_command('$USER') ],
            \ [ '<CREATION_DATE>', g:Shell_command('LANG=C; date "+%d %b %Y"')],
            \ ]

let s:update = [
            \ [ '<FILENAME>',      '\=expand("%:p:t")'],
            \ [ '<YEAR>',          g:Shell_command('LANG=C; date "+%Y"') ],
            \ [ '<CURRENT_DATE>',  g:Shell_command('LANG=C; date "+%d %b %Y"')],
            \ ]

let s:skip = [
            \ [ '<PUT DESCRIPTION HERE>', '*** Description ***' ],
            \ ]

"""""""""""""
" common_h  "
"""""""""""""

let s:template_h  = [[ 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let s:template_c  = [[ 'COMMON_HEADER' ], []]

let s:template_creation_h_c = [
            \ [ '<GUARD_NAME>',   '\=toupper(expand("%:t:r"))' ],
            \ ] + s:creation

"""""""""""""
" project_1 "
"""""""""""""

let s:project_1_h = [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let s:project_1_c = [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []]

let s:project_1_creation_h_c = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
            \ ] + s:template_creation_h_c

"""""""""""""
" project_2 "
"""""""""""""
let s:project_2_h = [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let s:project_2_c = [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []]

let s:project_2_creation_h_c= [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 2' ],
            \ ] + s:template_creation_h_c

"""""""""""
" autocmd "
"""""""""""


augroup Template
    au!
    autocmd BufNewFile    *.h
                \ if expand("%:p") =~? 'project_1'
                \|    call Template_create(s:template_path, s:project_1_h, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call Template_create(s:template_path, s:project_2_h, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call Template_create(s:template_path, s:template_h, s:template_creation_h_c, s:update, s:skip)
                \|endif

    autocmd BufWritePre   *.h
                \ if expand("%:p") =~? 'project_1'
                \|    call Template_update(s:template_path, s:project_1_h, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call Template_update(s:template_path, s:project_2_h, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call Template_update(s:template_path, s:h_header, s:h_footer, s:template_creation_h_c, s:update, s:skip)
                \|endif

    autocmd BufNewFile    *.c
                \ if expand("%:p") =~? 'project_1'
                \|    call Template_create(s:template_path, s:project_1_c, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call Template_create(s:template_path, s:project_2_c, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call Template_create(s:template_path, s:template_c, s:template_creation_h_c, s:update, s:skip)
                \|endif

    autocmd BufWritePre   *.c
                \ if expand("%:p") =~? 'project_1'
                \|    call Template_update(s:template_path, s:project_1_c, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call Template_update(s:template_path, s:project_2_c, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call Template_update(s:template_path, s:h_header, s:h_footer, s:template_creation_h_c, s:update, s:skip)
                \|endif

augroup END
