ru pattern_file/template_user.vim

let template_default#creation = [
            \ [ '<USER>',          template#Shell_command('$USER') ],
            \ [ '<CREATION_DATE>', template#Shell_command('LANG=C; date "+%d %b %Y"')],
            \ ] + template_user#creation

let template_default#update = [
            \ [ '<FILENAME>',      '\=expand("%:p:t")'],
            \ [ '<YEAR>',          template#Shell_command('LANG=C; date "+%Y"') ],
            \ [ '<CURRENT_DATE>',  template#Shell_command('LANG=C; date "+%d %b %Y"')],
            \ ]

let template_default#skip = [
            \ [ '<PUT DESCRIPTION HERE>', '*** Description ***' ],
            \ ]
