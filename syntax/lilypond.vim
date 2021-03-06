" LilyPond syntax file
" Language:     LilyPond
" Maintainer:   Heikki Junes <hjunes@cc.hut.fi>
" Last Change:  2016 December 29
"
" Installed As:         vim/syntax/lilypond.vim
" Uses Generated File:  vim/syntax/lilypond-words.vim
"
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the LilyPond syntax match groups:
"   lilyKeyword, lilyReservedWord, lilyNote
if version < 600
  so <sfile>:p:h/lilypond-words.vim
else
  runtime! syntax/lilypond-words.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
endif

" Match also parethesis of angle type
setlocal mps+=<:>

" Case matters
syn case match

syn cluster lilyMatchGroup contains=lilyMatcher,lilyString,lilyComment,lilyStatement,lilyNumber,lilySlur,lilySpecial,lilyNote,lilyKeyword,lilyArticulation,lilyReservedWord,lilySchemeMarker,lilyMisplacedModifier

syn region lilyMatcher matchgroup=Delimiter start="{" skip="\\\\\|\\[<>]" end="}" contains=@lilyMatchGroup fold
syn region lilyMatcher matchgroup=Delimiter start="\[" end="]" contains=@lilyMatchGroup fold
syn region lilyMatcher matchgroup=Delimiter start="<" skip="\\\\\|\\[{<>}]" end=">" contains=@lilyMatchGroup fold

syn region lilyString start=/"/ end=/"/ skip=/\\"/
syn region lilyComment start="%{" skip="%$" end="%}"
syn region lilyComment start="%\([^{]\|$\)" end="$"

syn match lilyNumber "[-_^.]\?\d\+[.]\?"
syn match lilySlur "[(~)]"
syn match lilySlur "\\[()]"
syn match lilySpecial "\\[<!>\\]"
" avoid highlighting the extra character in situations like
" c--\mf c^^\mf c__\mf
syn match lilyArticulation "[-_^][-_^+|>.]"

" Catch accidental entries like "c4," in place of "c,4".
syn match lilyMisplacedModifier "\a\+[^a-z,'?! \t\n]\S*\\\@<![,'?!]"

" Include Scheme syntax highlighting, where appropriate.
"
" Note that the default Scheme syntax file clobbers the 'iskeyword'
" setting. This causes problems because it makes the `<` character a
" keyword, which affects chords in Lilypond. In particular, it means
" that the first note in a chord like `<c e g>` will not be matched as a
" `lilyNote`. To prevent this, we save and restore the variable.
let s:old_iskeyword = &iskeyword
syn include @embeddedScheme syntax/scheme.vim
let &iskeyword = s:old_iskeyword
unlet b:current_syntax
syn match lilySchemeMarker "#" nextgroup=@embeddedScheme

" Rest of syntax highlighting rules start here
"
" " Define the default highlighting.
" " For version 5.7 and earlier: only when not done already
" " For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lily_syn_inits")
  if version < 508
    let did_lily_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink Delimiter        Identifier

  HiLink lilyString       String
  HiLink lilyComment      Comment

  HiLink lilyNote         Identifier
  HiLink lilyArticulation PreProc
  HiLink lilyKeyword      Keyword
  HiLink lilyReservedWord Type

  HiLink lilyMisplacedModifier  Error

  HiLink lilyNumber       Constant
  HiLink lilySpecial      Special
  HiLink lilySlur         ModeMsg

  HiLink lilySchemeMarker Special

  delcommand HiLink
endif

let b:current_syntax = "lilypond"
