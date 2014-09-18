if exists("g:loaded_plugin_template#default_vimrc")
  finish
endif
let g:loaded_plugin_template#default_vimrc = 1

let s:template_path = '~/.vim/bundle/template/template_file/'

let template_user#creation = [
            \ [ '<AUTHOR_NAME>',   'Robin Moussu' ],
            \ [ '<MAIL>',          'robin.moussu+github <at> gmail.com' ],
            \ ]

let template_user#update   = []
let template_user#skip     = []

let template_default#creation = [
            \ [ '<USER>',          template#Shell_command('$USER') ],
            \ [ '<CREATION_DATE>', template#Shell_command('LANG=C; date "+%d %b %Y"')],
            \ [ '<GUARD_NAME>',    '\=toupper(expand("%:t:r"))' ],
            \ ] + template_user#creation

let template_default#update = [
            \ [ '<FILENAME>',      '\=expand("%:p:t")'],
            \ [ '<YEAR>',          template#Shell_command('LANG=C; date "+%Y"') ],
            \ [ '<CURRENT_DATE>',  template#Shell_command('LANG=C; date "+%d %b %Y"')],
            \ ] + template_user#update

let template_default#skip = [
            \ [ '<PUT DESCRIPTION HERE>', '*** Description ***' ],
            \ ] + template_user#skip

call template#add ({
            \'pattern'  : '*.c',
            \'priority' : 100,
            \'template' : [[ 'COMMON_HEADER' ], []],
            \'creation' : template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip,
            \})

call template#add ({
            \'pattern'  : '*.h',
            \'priority' : 100,
            \'template' : [[ 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]],
            \'creation' : template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip
            \})

call template#add ({
            \'pattern'  : '*/project_1/*/*.c',
            \'priority' : 50,
            \'template' : [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []],
            \'creation' : [
                \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
                \ ] + template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip
            \})

call template#add ({
            \'pattern'  : '*/project_1/*/*.h',
            \'priority' : 50,
            \'template' : [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]],
            \'creation' : [
                \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
                \ ] + template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip
            \})

call template#add ({
            \'pattern'  : '*/project_2/*/*.c',
            \'priority' : 50,
            \'template' : [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []],
            \'creation' : [
                \ [ '<SOFTWARE_NAME>', 'PROJECT 2' ],
                \ ] + template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip
            \})

call template#add ({
            \'pattern'  : '*/project_2/*/*.h',
            \'priority' : 50,
            \'template' : [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]],
            \'creation' : [
                \ [ '<SOFTWARE_NAME>', 'PROJECT 2' ],
                \ ] + template_default#creation,
            \'update'   : template_default#update,
            \'skip'     : template_default#skip,
            \})

augroup Template
    au!
    autocmd BufNewFile  * call template#Template_create(s:template_path)
    autocmd BufWritePre * call template#Template_update(s:template_path)
augroup END
