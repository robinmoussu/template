ru pattern_file/template_user.vim
ru pattern_file/default.vim

let template_h#template = [[ 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]

let template_h#creation = [
            \ [ '<GUARD_NAME>',   '\=toupper(expand("%:t:r"))' ],
            \ ] + template_user#creation

let template_h#update   = template_default#update
let template_h#skip     = template_default#skip
