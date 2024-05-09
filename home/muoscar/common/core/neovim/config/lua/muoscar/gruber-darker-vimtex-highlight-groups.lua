local colorscheme = {}

local p = require('gruber-darker.palette')
local M = {}

local function c(color)
    return color:to_string()
end

---@type table<string, string>
M = {
    none = c(p.none),
    fg = c(p.fg),
    ["fg+1"] = c(p["fg+1"]),
    ["fg+2"] = c(p["fg+2"]),
    white = c(p.white),
    black = c(p.black),
    ["bg-1"] = c(p["bg-1"]),
    bg = c(p.bg),
    ["bg+1"] = c(p["bg+1"]),
    ["bg+2"] = c(p["bg+2"]),
    ["bg+3"] = c(p["bg+3"]),
    ["bg+4"] = c(p["bg+4"]),
    ["red-1"] = c(p["red-1"]),
    red = c(p.red),
    ["red+1"] = c(p["red+1"]),
    green = c(p.green),
    yellow = c(p.yellow),
    brown = c(p.brown),
    quartz = c(p.quartz),
    ["niagara-2"] = c(p["niagara-2"]),
    ["niagara-1"] = c(p["niagara-1"]),
    niagara = c(p.niagara),
    wisteria = c(p.wisteria),
}

--[[
    fg:        '#e4e4ef'
    fg+1:      '#f4f4ff'
    fg+2:      '#f5f5f5'
    white:     '#ffffff'
    black:     '#000000'
    bg:-1      '#101010'
    bg:        '#181818'
    bg+1:      '#282828'
    bg+2:      '#453d41'
    bg+3:      '#484848'
    bg+4:      '#52494e'
    red-1:     '#c73c3f'
    red:       '#f43841'
    red+1:     '#ff4f58'
    green:     '#73c936'
    yellow:    '#ffdd33'
    brown:     '#cc8c3c'
    quartz:    '#95a99f'
    niagara-2: '#303540'
    niagara-1: '#565f73'
    niagara:   '#96a6c8'
    wisteria:  '#9e95c7'


nvim_set_hl({ns_id}, {name}, {*val})                           *nvim_set_hl()*
    Sets a highlight group.

    Note:
        Unlike the `:highlight` command which can update a highlight group,
        this function completely replaces the definition. For example:
        `nvim_set_hl(0, 'Visual', {})` will clear the highlight group
        'Visual'.

    Note:
        The fg and bg keys also accept the string values `"fg"` or `"bg"`
        which act as aliases to the corresponding foreground and background
        values of the Normal group. If the Normal group has not been defined,
        using these values results in an error.

    Note:
        If `link` is used in combination with other attributes; only the
        `link` will take effect (see |:hi-link|).

    Parameters: ~
      • {ns_id}  Namespace id for this highlight |nvim_create_namespace()|.
                 Use 0 to set a highlight group globally |:highlight|.
                 Highlights from non-global namespaces are not active by
                 default, use |nvim_set_hl_ns()| or |nvim_win_set_hl_ns()| to
                 activate them.
      • {name}   Highlight group name, e.g. "ErrorMsg"
      • {val}    Highlight definition map, accepts the following keys:
                 • fg (or foreground): color name or "#RRGGBB", see note.
                 • bg (or background): color name or "#RRGGBB", see note.
                 • sp (or special): color name or "#RRGGBB"
                 • blend: integer between 0 and 100
                 • bold: boolean
                 • standout: boolean
                 • underline: boolean
                 • undercurl: boolean
                 • underdouble: boolean
                 • underdotted: boolean
                 • underdashed: boolean
                 • strikethrough: boolean
                 • italic: boolean
                 • reverse: boolean
                 • nocombine: boolean
                 • link: name of another highlight group to link to, see
                   |:hi-link|.
                 • default: Don't override existing definition |:hi-default|
                 • ctermfg: Sets foreground of cterm color |ctermfg|
                 • ctermbg: Sets background of cterm color |ctermbg|
                 • cterm: cterm attribute map, like |highlight-args|. If not
                   set, cterm attributes will match those from the attribute
                   map documented above.

]]
--
-- color definitions

local err_color = M.red

local arg_color = M.brown
local opt_color = M.white
local cmd_color = M.yellow

local math_zone_color = M.white
local math_zone_delim_color = M.brown
local math_cmd_color = M.niagara
-- local math_cmd_color = M.red
local math_delim_color = M.green
local math_operator_color = M.yellow

function colorscheme.set_highlights()
    vim.api.nvim_set_hl(0, 'texMathCmd', { -- \Dot or \frac
        fg = math_cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdGreek', { -- \alpha or \phi
        fg = M.white,
    })
    vim.api.nvim_set_hl(0, 'texMathSymbol', { -- \partial or \int
        fg = M.white,
    })
    -- vim.api.nvim_set_hl(0, 'Normal', { -- \partial or \int
    --     fg = M['red-1'],
    -- })

    --[[
Table 1: A list of groups that are only primitive link targets.

  GROUP                DEFAULT
  ----------------------------------------------------------------------------
  VimtexMsg            ModeMsg
  VimtexInfo           Question
  VimtexTodo           Todo
  VimtexWarning        WarningMsg
  VimtexError          ErrorMsg
  VimtexFatal          Error
  VimtexSuccess        Statement
  texCmdType           Type
  texParm              Special
  texZone              PreCondit
  texSymbol            SpecialChar
  texError             VimtexError

]]

    --vim.api.nvim_set_hl(0, 'VimtexMsg', {	-- ModeMsg
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'VimtexInfo', {	-- Question
    --fg=,
    --})
    vim.api.nvim_set_hl(0, 'VimtexTodo', { -- Todo
        fg = M.bg,
        bg = M.yellow,
        italic = false,
    })
    --vim.api.nvim_set_hl(0, 'VimtexWarning', {	-- WarningMsg
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'VimtexError', {	-- ErrorMsg
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'VimtexFatal', {	-- Error
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'VimtexSuccess', {	-- Statement
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texCmdType', {	-- Type
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texParm', {	-- Special
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texZone', {	-- PreCondit
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texSymbol', {	-- SpecialChar
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texError', {	-- VimtexError
    --fg=,
    --})

    --[[
Table 2: A list of the most common normal LaTeX groups.

  GROUP                DEFAULT      EXAMPLE
  ----------------------------------------------------------------------------
  texComment           Comment      % COMMENT
  texCommentTodo       VimtexTodo   % TODO
  texDelim             Delimiter    {, }, [, and ]
  texCmd               Statement    \CMD
  texOpt               Identifier   \cmd[OPT]
  texOptSep            NormalNC     [a, b] (commas)
  texOptEqual          texSymbol    [a=b]
  texArg               Include      \cmd[...]{ARG}
  texSpecialChar       SpecialChar  \S, \P, \$, \;, ...
  texCmdInput          texCmd       \INPUT
                                    \INCLUDE
                                    \INCLUDEONLY
                                    \INCLUDEGRAPHICS
  texCmdBib            texCmd       \BIBLIOGRAPHY
                                    \BIBLIOGRAPHYSTYLE
  texCmdClass          texCmd       \DOCUMENTCLASS
  texCmdPackage        texCmd       \USEPACKAGE
                                    \REQUIREPACKAGE
  texFileOpt           texOpt       \includegraphics[PACKAGE OPTIONS]
                                    \documentclass[CLASS OPTIONS]
  texFileArg           texArg       \input{FILE}
                                    \include{FILE}
                                    \includegraphics[...]{FILE}
                                    \bibliographystyle{FILE}
                                    \documentclass[...]{CLASS}
  texFilesOpt          texFileOpt   \usepackage[PACKAGE OPTIONS]
                                    \RequirePackage[PACKAGE OPTIONS]
  texFilesArg          texFileArg   \includeonly{FILE1, FILE2}
                                    \bibliography{FILE1, FILE2}
                                    \usepackage[...]{PACKAGE1, PACKAGE2}
                                    \RequirePackage[...]{PACKAGE1, PACKAGE2}
  texCmdTitle          texCmd       \TITLE
  texTitleArg          Underlined   \title{MAIN TITLE}
  texCmdAuthor         texCmd       \AUTHOR
  texAuthorOpt         texOpt       \author[OPT]
  texAuthorArg         NONE         \author[...]{AUTHOR LIST}
  texCmdPart           texCmd       \(SUB*)SECTION
  texPartArgTitle      String       \(sub*)section{TITLE}
  texCmdEnv            texCmd       \BEGIN; \END
  texEnvArgName        PreCondit    \begin{ENVNAME}
  texCmdRef            texCmd       \CITE; \LABEL
  texRefArg            Special      \cite{REFERENCE}; \label{REF}
  texE3Variable        texCmd       \G_MYFILE_NAME_STR
  texE3Constant        texE3Variable
                                    \C_MYFILE_NAME_STR
  texE3Function        texCmdType   \STR_NEW:n
  texE3Type            texParm      \str_new:N
  texCmdParbox         texCmd       \PARBOX[p][h][i]{w}{c}
  texBoxOptPosVal      texSymbol    \parbox[P][h][i]{w}{c}
                                    \begin{minipage}[P][h][i]{w}
  texBoxOptIPosVal     texBoxOptPosVal
                                    \parbox[p][h][I]{w}{c}
                                    \begin{minipage}[p][h][I]{w}
]]

    vim.api.nvim_set_hl(0, 'texComment', { --  COMMENT
        fg = M.niagara,
        italic = true,
    })
    vim.api.nvim_set_hl(0, 'texCommentTodo', { --  TODO
        fg = M.bg,
        bg = M.yellow,
        italic = false,
    })
    vim.api.nvim_set_hl(0, 'texDelim', { --  {, }, [, and ]
        fg = M.quartz,
    })
    vim.api.nvim_set_hl(0, 'texCmd', { -- \CMD
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texOpt', { -- \cmd[OPT]
        fg = opt_color,
    })
    vim.api.nvim_set_hl(0, 'texOptSep', { -- [a, b] (commas)
        fg = M.yellow,
    })
    vim.api.nvim_set_hl(0, 'texOptEqual', { -- [a=b]
        fg = M.yellow,
    })
    vim.api.nvim_set_hl(0, 'texArg', { -- \cmd[...]{ARG}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texSpecialChar', { -- \S, \P, \$, \;, ...
        fg = M.yellow,
    })
    vim.api.nvim_set_hl(0, 'texCmdInput', { -- \INPUT \INCLUDE \INCLUDEONLY \INCLUDEGRAPHICS
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdBib', { -- \BIBLIOGRAPHY \BIBLIOGRAPHYSTYLE
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdClass', { -- \DOCUMENTCLASS
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdPackage', { -- \USEPACKAGE \REQUIREPACKAGE
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texFileOpt', { -- \includegraphics[PACKAGE OPTIONS] \documentclass[CLASS OPTIONS]
        fg = opt_color,
    })
    vim.api.nvim_set_hl(0, 'texFileArg',
        { -- \input{FILE} \include{FILE} \includegraphics[...]{FILE} \bibliographystyle{FILE} \documentclass[...]{CLASS}
            fg = arg_color,
        })
    vim.api.nvim_set_hl(0, 'texFilesOpt', { -- \usepackage[PACKAGE OPTIONS] \RequirePackage[PACKAGE OPTIONS]
        fg = opt_color,
    })
    vim.api.nvim_set_hl(0, 'texFilesArg',
        { -- \includeonly{FILE1, FILE2} \bibliography{FILE1, FILE2} \usepackage[...]{PACKAGE1, PACKAGE2} \RequirePackage[...]{PACKAGE1, PACKAGE2}
            fg = arg_color,
        })
    vim.api.nvim_set_hl(0, 'texCmdTitle', { -- \TITLE
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texTitleArg', { -- \title{MAIN TITLE}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdAuthor', { -- \AUTHOR
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texAuthorOpt', { -- \author[OPT]
        fg = opt_color,
    })
    vim.api.nvim_set_hl(0, 'texAuthorArg', { -- \author[...]{AUTHOR LIST}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdPart', { -- \(SUB*)SECTION
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texPartArgTitle', { -- \(sub*)section{TITLE}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdEnv', { -- \BEGIN; \END
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texEnvArgName', { -- \begin{ENVNAME}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdRef', { -- \CITE; \LABEL
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texRefArg', { -- \cite{REFERENCE}; \label{REF}
        fg = arg_color,
    })
    ----------------------------- What are these? ---------------------------------
    vim.api.nvim_set_hl(0, 'texE3Variable', { -- \G_MYFILE_NAME_STR
        fg = M.white,
    })
    vim.api.nvim_set_hl(0, 'texE3Constant', { -- \C_MYFILE_NAME_STR
        fg = M.white,
    })
    vim.api.nvim_set_hl(0, 'texE3Function', { -- \STR_NEW:n
        fg = M.white,
    })
    vim.api.nvim_set_hl(0, 'texE3Type', { -- \str_new:N
        fg = M.white,
    })
    -------------------------------------------------------------------------------
    vim.api.nvim_set_hl(0, 'texCmdParbox', { -- \PARBOX[p][h][i]{w}{c}
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texBoxOptPosVal', { -- \parbox[P][h][i]{w}{c} \begin{minipage}[P][h][i]{w}
        fg = opt_color,
    })
    vim.api.nvim_set_hl(0, 'texBoxOptIPosVal', { -- \parbox[p][h][I]{w}{c} \begin{minipage}[p][h][I]{w}
        fg = opt_color,
    })

    --[[
Table 3: A list of math mode groups.

  GROUP                    DEFAULT           EXAMPLE
  ----------------------------------------------------------------------------
  texMathZone              Special
  texMathZoneLI            texMathZone       \( HERE \)
  texMathZoneLD            texMathZone       \[ HERE \]
  texMathZoneTI            texMathZone       $ HERE $
  texMathZoneTD            texMathZone       $$ HERE $$
  texMathZoneEnv           texMathZone       \begin{menv}  HERE \end{menv}
  texMathZoneEnvStarred    texMathZone       \begin{menv*} HERE \end{menv*}
  texMathZoneEnsured       texMathZone       \ensuremath{HERE}
  texMathDelimZone         texDelim
  texMathDelimZoneLI       texMathDelimZone  \(; \)
  texMathDelimZoneLD       texMathDelimZone  \[; \]
  texMathDelimZoneTI       texMathDelimZone  $
  texMathDelimZoneTD       texMathDelimZone  $$
  texCmdMathEnv            texCmdEnv         \BEGIN; \END
                                             (Only for math environments.)
  texMathEnvArgName        Delimiter         \begin{EQUATION}
  texCmdMath               texCmd            \ENSUREMATH
  texMathDelim             Type              \LVERT
  texMathDelimMod          texMathDelim      \LEFT\lvert \RIGHT\rvert
  texMathOper              Operator          Basic operators: +-=/
  texMathSuperSub          texMathOper       Sub and super operators (^, _)
  texMathError             texError          Unmatched region endings
]]

    -- unsure about what this is. colors the \phi in P_\phi, but not \phi alone
    vim.api.nvim_set_hl(0, 'texMathZone', { --Special
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneLI', { -- \( HERE \)
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneLD', { -- \[ HERE \]
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneTI', { -- $ HERE $
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneTD', { -- $$ HERE $$
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneEnv', { -- \begin{menv}  HERE \end{menv}
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMahZoneEnvStarred', { -- \begin{menv*} HERE \end{menv*}
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathZoneEnsured', { -- \ensuremath{HERE}
        fg = math_zone_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimZone', { -- texDelim
        fg = math_zone_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimZoneLI', { -- \(; \)
        fg = math_zone_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimZoneLD', { -- \[; \]
        fg = math_zone_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimZoneTI', { -- $
        fg = math_zone_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimZoneTD', { -- $$
        fg = math_zone_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdMathEnv', { -- \BEGIN; \END (Only for math environments.)
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texMathEnvArgName', { -- \begin{EQUATION}
        fg = arg_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdMath', { -- \ENSUREMATH
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelim', { -- \LVERT
        fg = math_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathDelimMod', { -- \LEFT\lvert \RIGHT\rvert
        fg = math_delim_color,
    })
    vim.api.nvim_set_hl(0, 'texMathOper', { -- Basic operators: +-=/
        fg = math_operator_color,
    })
    vim.api.nvim_set_hl(0, 'texMathSuperSub', { -- Sub and super operators (^, _)
        fg = math_operator_color,
    })
    vim.api.nvim_set_hl(0, 'texMathError', { -- Unmatched region endings
        fg = err_color,
    })

    --[[
Table 4: A list of other important groups.

  GROUP                DEFAULT         EXAMPLE
  ----------------------------------------------------------------------------
  texLength            Number          Length units, e.g. "4 cm". Only when
                                       contained e.g. in option groups.
  texLigature          texSymbol       --; ---; ``; ''; ,,
  texCmdAccent         texCmd          \"{a}
  texCmdLigature       texSpecialChar  \ss; \ae
  texCmdSpaceCodeChar  Special         Catcodes. For more info, see:
                                       https://en.wikibooks.org/wiki/TeX/catcode
  texCmdTodo           VimtexTodo      \TODOSOMETHING
  texCmdVerb           texCmd          \VERB
  texVerbZoneInline    texZone         \verb+VERB TEXT+
  texVerbZone          texZone         \begin{verbatim} VERB TEXT \end{verbatim}
  texCmdDef            texCmdNew       \DEF
  texDefArgName        texArgNew       \def\NAME
  texDefParm           texParm         \def\name #1
  texCmdItem           texCmd          \item
]]

    vim.api.nvim_set_hl(0, 'texLength', { -- Length units, e.g. "4 cm". Only when contained e.g. in option groups.
        fg = M.yellow,
    })
    vim.api.nvim_set_hl(0, 'texLigature', { -- --; ---; ``; ''; ,,
        fg = M.green,
    })
    vim.api.nvim_set_hl(0, 'texCmdAccent', { -- \"{a}
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texCmdLigature', { -- \ss; \ae
        fg = cmd_color,
    })
    --vim.api.nvim_set_hl(0, 'texCmdSpaceCodeChar', {	-- Catcodes. For more info, see: https://en.wikibooks.org/wiki/TeX/catcode
    --fg=,
    --})
    vim.api.nvim_set_hl(0, 'texCmdTodo', { -- \TODOSOMETHING
        fg = cmd_color,
    })
    --vim.api.nvim_set_hl(0, 'texCmdVerb', {	-- \VERB
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texVerbZoneInline', {	-- \verb+VERB TEXT+
    --fg=,
    --})
    --vim.api.nvim_set_hl(0, 'texVerbZone', {	-- \begin{verbatim} VERB TEXT \end{verbatim}
    --fg=,
    --})
    vim.api.nvim_set_hl(0, 'texCmdDef', { -- \DEF
        fg = cmd_color,
    })
    vim.api.nvim_set_hl(0, 'texDefArgName', { -- \def\NAME
        fg = M.green,
    })
    --vim.api.nvim_set_hl(0, 'texDefParm', {	-- \def\name #1
    --fg=,
    --})
    vim.api.nvim_set_hl(0, 'texCmdItem', { -- \item
        fg = cmd_color,
    })

    --[[
Table 5: Bold, italic and underline groups.

  These groups are used as targets for various (nested) commands, e.g.
  `\emph{\textbf{...}}`.

  GROUP                   EFFECT
  ----------------------------------------------------------------------------
  texStyleBold            Bold
  texStyleItal            Italic
  texStyleUnder           Underlined
  texStyleBoth            Bold + italic
  texStyleBoldUnder       Bold + underlined
  texStyleItalUnder       Italic + underlined
  texStyleBoldItalUnder   Bold + italic + underlined
  texMathStyleBold        Bold [ONLY in math mode]
  texMathStyleItal        Italic [ONLY in math mode]
]]

    vim.api.nvim_set_hl(0, 'texStyleBold', { -- Bold
        bold = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleItal', { -- Italic
        italic = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleUnder', { -- Underlined
        underline = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleBoth', { -- Bold + italic
        bold = true,
        underline = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleBoldUnder', { -- Bold + underlined
        bold = true,
        underline = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleItalUnder', { -- Italic + underlined
        italic = true,
        underline = true,
    })
    vim.api.nvim_set_hl(0, 'texStyleBoldItalUnder', { -- Bold + italic + underlined
        bold = true,
        italic = true,
    })
    vim.api.nvim_set_hl(0, 'texMathStyleBold', { -- Bold [ONLY in math mode]
        bold = true,
    })
    vim.api.nvim_set_hl(0, 'texMathStyleItal', { -- Italic [ONLY in math mode]
        italic = true,
    })
end

return colorscheme
