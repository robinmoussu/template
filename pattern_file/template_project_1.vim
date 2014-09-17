ru pattern_file/template_default.vim

let template_project_1_h#template = [[ 'short_licence/gpl_v3', 'COMMON_HEADER', 'GUARDS_HEADER' ], [ 'GUARDS_FOOTER' ]]
let template_project_1_c#template = [[ 'short_licence/gpl_v3', 'COMMON_HEADER' ], []]

let template_project_1_h#creation = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
            \ ] + template_h#creation

let template_project_1_c#creation = [
            \ [ '<SOFTWARE_NAME>', 'PROJECT 1' ],
            \ ] + template_c#creation

let template_project_1_h#update = template_default#update
let template_project_1_c#update = template_default#update

let template_project_1_h#skip = template_default#skip
let template_project_1_c#skip = template_default#skip
