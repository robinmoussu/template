"--- common -----

" Save cursor current position and registers
function! s:Save_position()
    " save registers
    let s:old_a      =@a
    let s:old_search =@/

    " Save the current cursor position.
    silent! normal! ma
    " let s:old_cursor_position = getpos("a'")
    " normal! H
    " let s:old_window_position = getpos('.')
    " call setpos('.', s:old_cursor_position)

endfunction

" Restore old position and registers
function! s:Restore_position()
    " restore original state
    " Restore the previous window position.
    " call setpos('.', s:old_window_position)
    " normal! zt
    " Restore the previous cursor position.
    " call setpos('.', s:old_cursor_position)
    silent! normal! `a

    let @/ = s:old_search
    let @a = s:old_a
    let s:already_save = 0
endfunction

" Open all templates files
function! s:Open_Template(path, files_template)
    if !exists('s:do_bw')
        let s:do_bw = []
    endif

    for l:filename in a:files_template
        let l:file = a:path . l:filename
        if bufnr(l:file) == -1
            let l:current_file = bufnr('%')
            silent exec 'e ' . l:file
            silent exec 'b ' . l:current_file
            let s:do_bw += [bufnr(l:file)]
        endif
    endfor
endfunction

" Close all templates files
function! s:Close_Template()
    for template in s:do_bw
        silent exec 'bw ' . template
    endfor
    unlet s:do_bw
endfunction

" Return number of line of line of a file (that file will be opened)
function! s:Line_number(file)
    " return number of line of file
    return len(getbufline(bufnr(a:file),1, '$'))
endfunction

"-----creation-----

function! s:Header_create(path, header_file, pattern)
    " Create new header using pattern file and substitution lists

    " put template_file on top of file
    " cursor is not updated corectly, so I update it manualy
    let l:line_total = 0
    call cursor(1, 1)
    put! _
    for l:filename in a:header_file
        let l:file = a:path . l:filename
        exec "r" l:file
        let l:line_total += s:Line_number(l:file) + 1
        call cursor(l:line_total, 1)
        put _
    endfor
    0d

    let l:header_size = l:line_total

    " substitute pattern by vim command
    for l:pattern in a:pattern
        silent! exec '0,' . l:header_size . 's/' . l:pattern[0] . '/' . l:pattern[1] . '/'
    endfor
endfunction

function! s:Footer_create(path, footer_file, pattern)
    " Create new header using pattern file and substitution lists

    " put template_file on bottom of file
    " cursor is not updated corectly, so I update it manualy
    let l:foot_line_start = line('$') + 1
    call cursor(line('$'), 1)
    for l:filename in a:footer_file
        let l:file = a:path . l:filename
        call cursor(line('$'), 1)
        put _
        exec "r" l:file
    endfor

    " substitute pattern by vim command
    for l:pattern in a:pattern
        silent! exec l:foot_line_start . ',$s/' . l:pattern[0] . '/' . l:pattern[1] . '/'
    endfor
endfunction

"-----update-----

" Update current file according to pattern.
" Cursor position must match the template
function! s:Update_file(path, files_template, pattern_creation, pattern_update, pattern_skip, skip_first_lines)
    for l:filename in a:files_template
        let l:file = a:path . l:filename
        let l:can_be_skip = a:skip_first_lines

        let l:bufnum   = bufnr(l:file)
        let l:template = getbufline(l:bufnum, 1, '$')
        let l:nb_line  = len(l:template)

        for l:original in l:template
            "if line contain a template
            if l:original =~# '<.*>'

                " Somme pattern can be multi-ligne
                let l:have_skip = 0
                "skip next line if it's a skip pattern
                for l:skip in a:pattern_skip
                    if l:original =~# l:skip[0]
                        "echo 'skipped : ' . getline('.')
                        call cursor(line('.') + 1, 1)
                        let l:have_skip = 1
                        continue
                    endif
                endfor
                if l:have_skip
                    let l:can_be_skip = 1
                    continue
                end

                let l:pattern_escaped = escape(l:original, '\*.')
                let l:pattern_match   = l:pattern_escaped

                for l:pattern in a:pattern_creation
                    let l:pattern_match = substitute(l:pattern_match, l:pattern[0],  '.*',       '' )
                endfor

                let l:do_while = 1
                while l:do_while || l:can_be_skip
                    let l:do_while = 0

                    let l:new             = getline('.')

                    " Substitute all keyword by '.*' to be matched by regexp and by substituated placeholder
                    for l:pattern in a:pattern_update
                        let l:pattern_match = substitute(l:pattern_match,   l:pattern[0],  '.*',          '' )

                        if l:pattern_escaped =~# l:pattern[0]
                            let l:select_new    = substitute(l:pattern_escaped, l:pattern[0],  '\\zs.*\\ze',  '' )
                            let l:select_new    = substitute(l:select_new,      '<[^>]*>',     '.*',          'g')
                            let l:new           = substitute(l:new,             l:select_new,  l:pattern[1],  'g')
                        endif
                    endfor

                    " pattern match ?
                    if getline('.') =~# '^' . l:pattern_match . '$'
                        let l:can_be_skip=0
                        " pattern need modification ?
                        if getline('.') != l:new
                            silent call setline('.', l:new)
                        endif
                    else
                        if !l:can_be_skip
                            echoerr "line " .  line('.') . ' ' . getline(line('.')) .     " does not match with template"
                        else
                            "echo 'skipped : ' . getline('.')
                            if line('.') != line('$')
                                call cursor(line('.') + 1, 1)
                            else
                                break
                            end
                        end
                    endif
                endwhile
            endif

            call cursor(line('.') + 1, 1)
        endfor

        call cursor(line('.') + 1, 1)
    endfor
endfunction

"-----extern call-----

function! template#Template_create(path, template, pattern_creation, pattern_update, pattern_skip)
    " Create header and footer template
    call s:Save_position()
    call s:Open_Template(a:path, a:template[0] + a:template[1])
    call s:Header_create(a:path, a:template[0], a:pattern_creation + a:pattern_update + a:pattern_skip)
    call s:Footer_create(a:path, a:template[1], a:pattern_creation + a:pattern_update + a:pattern_skip)
    call s:Close_Template()
    call s:Restore_position()
endfunction

function! template#Template_update(path, template, pattern_creation, pattern_update, pattern_skip)
    call s:Save_position()
    call s:Open_Template(a:path, a:template[0] + a:template[1])

    "go to first line of current file
    call cursor(1,1)

    call s:Update_file(a:path, a:template[0], a:pattern_creation, a:pattern_update, a:pattern_skip, 0)
    call s:Update_file(a:path, a:template[1], a:pattern_creation, a:pattern_update, a:pattern_skip, 1)

    call s:Close_Template()
    call s:Restore_position()
endfunction

function! template#Shell_command(command)
    " Convert Unix command to valid vim substitution command
    " TODO maybe shellescape is not needed anymore
    return '\=systemlist(' . escape(shellescape( a:command ), '<>') . ')[0]    '
endfunction

