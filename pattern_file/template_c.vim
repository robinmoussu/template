ru pattern_file/template_user.vim

let template_c#template  = [[ 'COMMON_HEADER' ], []]

let template_c#creation = [
            \ [ '<GUARD_NAME>',   '\=toupper(expand("%:t:r"))' ],
            \ ] + template_user#creation
