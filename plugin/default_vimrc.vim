runtime! pattern_file/*.vim

" exemple of vimrc file

let s:template_path = 'template_file/'

"""""""""""""
" project_1 "
"""""""""""""

let s:project_1_h = [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let s:project_1_c = [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []]

let s:project_1_creation_h = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
            \ ] + template_h#creation

let s:project_1_creation_c = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
            \ ] + template_c#creation

"""""""""""""
" project_2 "
"""""""""""""
let s:project_2_h = [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let s:project_2_c = [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []]

let s:project_2_creation_h = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 2' ],
            \ ] + template_h#creation

let s:project_2_creation_c = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 2' ],
            \ ] + template_c#creation

"""""""""""
" autocmd "
"""""""""""


augroup Template
    au!
    autocmd BufNewFile    *.h
                \ if expand("%:p") =~? 'project_1'
                \|    call template#Template_create(s:template_path, template_h#project_1_h, template_h#project_1_creation_h, template_h#update, template_h#skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call template#Template_create(s:template_path, template_h#project_2_h, template_h#project_2_creation_h, template_h#update, template_h#skip)
                \|else
                \|    call template#Template_create(s:template_path, template_h#template, template_h#creation, template_h#update, template_h#skip)
                \|endif

    autocmd BufWritePre   *.h
                \ if expand("%:p") =~? 'project_1'
                \|    call template#Template_update(s:template_path, s:project_1_h, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call template#Template_update(s:template_path, s:project_2_h, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call template#Template_update(s:template_path, s:h_header, s:h_footer, s:template_creation_h_c, s:update, s:skip)
                \|endif

    autocmd BufNewFile    *.c
                \ if expand("%:p") =~? 'project_1'
                \|    call template#Template_create(s:template_path, s:project_1_c, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call template#Template_create(s:template_path, s:project_2_c, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call template#Template_create(s:template_path, s:template_c, s:template_creation_h_c, s:update, s:skip)
                \|endif

    autocmd BufWritePre   *.c
                \ if expand("%:p") =~? 'project_1'
                \|    call template#Template_update(s:template_path, s:project_1_c, s:project_1_creation_h_c, s:update, s:skip)
                \|elseif expand("%:p") =~? 'project_2'
                \|    call template#Template_update(s:template_path, s:project_2_c, s:project_2_creation_h_c, s:update, s:skip)
                \|else
                \|    call template#Template_update(s:template_path, s:h_header, s:h_footer, s:template_creation_h_c, s:update, s:skip)
                \|endif

augroup END
