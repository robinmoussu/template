ru template_file/template_user.vim

let template_h#template  = [[ 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]

let template_h#creation = [
            \ [ '<GUARD_NAME>',   '\=toupper(expand("%:t:r"))' ],
            \ ] + template_user#creation
