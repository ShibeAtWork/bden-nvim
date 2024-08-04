local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- Example snippet:
-- ls.add_snippets("lua", {                         <- Filetype
--     ls.snippet("hello", {                        <- Name 
--         ls.text_node('print("hello world")')     <- Function
--     })
-- })

ls.add_snippets(
    'lua', {
    ls.snippet(
    {trig='latex-snip'},
    {
            t({
"",
"ls.add_snippets(",
"    'tex', {",
"    s(",
"        {trig=TODO},",
"        {",
"            t()",
"        }",
"    )",
"})"
           })
        }
    )
})

ls.add_snippets(
    'lua', {
    ls.snippet(
    {trig='auto-latex-snip'},
    {
            t({
"",
"ls.add_snippets(",
"    'tex', {",
"    s(",
"        {trig=TODO,",
"         snippetType='autosnippet'",
"        },",
"        {",
"            t()",
"        }",
"    )",
"})"
           })
        }
    )
})

ls.add_snippets("tex", {
    ls.snippet(
        {trig="v;ga",
         snippetType='autosnippet'
        },
        {
            ls.text_node('\\alpha')
        })
})

ls.add_snippets('tex', {
    ls.snippet(
        {trig="v;gb",
         snippetType="autosnippet"
        },
        {
            ls.text_node('\\beta')
        })
})

ls.add_snippets(
	'tex',{
s({trig=";ff", 
   dscr="Expands ';ff' into '\\frac{}{}'",
   snippetType='autosnippet'
},
  {
    t("\\frac{"),
    i(1),  -- insert node 1
    t("}{"),
    i(2),  -- insert node 2
    t("}")
  }
),
})

ls.add_snippets(
	'tex',{
s({trig=";m", 
   dscr="Expands ';m' into '\\( \\)'",
   snippetType='autosnippet'
},
  {
    t("\\("),
    i(1),  -- insert node 1
    t("\\)")
  }
),
})

ls.add_snippets(
	'tex',{
s({trig=";eq",
   dscr="Expands ';eq' into '\\[ \\]'",
   snippetType='autosnippet'
},
  {
    t("\\["),
    i(1),  -- insert node 1
    t("\\]")
  }
),
})


ls.add_snippets(
    'tex', {
    s(
        {trig="v;sig",
         snippetType='autosnippet'
        },
        {
            t('\\sigma')
        }
    )
})


ls.add_snippets(
    'tex', {
    s(
        {trig="mv;K",
         snippetType='autosnippet'
        },
        {
                t("\\( K \\)")
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig='v;tau',
         snippetType='autosnippet'
        },
        {
            t('\\tau')
        }
    )
})
ls.add_snippets(
    'tex', {
    s(
        {trig='c;i',
         snippetType='autosnippet'
        },
        {
                t('\\item')
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="t;e",
         snippetType='autosnippet'
        },
        {
             t("\\emph{"),
             i(1),
             t("}")
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="t;b",
         snippetType='autosnippet'
        },
        {
             t("\\textbf{"),
             i(1),
             t("}")
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="t;u",
         snippetType='autosnippet'
        },
        {
             t("\\underline{"),
             i(1),
             t("}")
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="t;t",
         snippetType='autosnippet'
        },
        {
             t("\\text{"),
             i(1),
             t("}")
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="env;def",
         snippetType='autosnippet'
        },
        {
                t({"\\begin{definition}",""}),
                i(1),
                t({"", "\\end{defintion}"})
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="env;thm",
         snippetType='autosnippet'
        },
        {
                t({"\\begin{theorem}",""}),
                i(1),
                t({"", "\\end{theorem}"})
        }
    )
})
ls.add_snippets(
    'tex', {
    s(
        {trig="env;enum",
         snippetType='autosnippet'
        },
        {
                t({"\\begin{enumerate}",""}),
                i(1),
                t({"", "\\end{enumerate}"})
        }
    )
})
ls.add_snippets(
    'tex', {
    s(
        {trig="v;m",
         snippetType='autosnippet'
        },
        {
                t('\\(m \\)')
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="r;le",
         snippetType='autosnippet'
        },
        {
            t('\\leq')
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="r;ge",
         snippetType='autosnippet'
        },
        {
            t('\\geq')
        }
    )
})

ls.add_snippets(
    'tex', {
    s(
        {trig="v;gc",
         snippetType='autosnippet'
        },
        {
            t('\\gamma')
        }
    )
})


ls.add_snippets('tex', {
    ls.snippet('reals', {
        ls.text_node('\\mathbb{R}')
    })
})

ls.add_snippets('tex', {
    ls.snippet('in', {
        ls.text_node('\\in')
    })
})

ls.add_snippets('tex', {
    ls.snippet('sset', {
        ls.text_node('\\subseteq')
    })
})

ls.add_snippets('tex', {
    ls.snippet('nin', {
        ls.text_node('\\not\\in')
    })
})

ls.add_snippets('tex', {
    ls.snippet('natural', {
        ls.text_node('\\mathbb{N}')
    })
})

ls.add_snippets('tex', {
    ls.snippet('rationals', {
        ls.text_node('\\mathbb{Q}')
    })
})

ls.add_snippets('tex', {
    ls.snippet('fnto', {
        ls.text_node('\\rightarrow')
    })
})

ls.add_snippets('tex', {
    ls.snippet('v-feild', {
        ls.text_node('\\mathbb{F}')
    })
})

ls.add_snippets('tex', {
    ls.snippet('f-prob', {
        ls.text_node('\\mathbb{P}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('f-expect', {
        ls.text_node('\\mathbb{E}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('b-def', {
        ls.text_node('\\begin{definition}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('e-def', {
        ls.text_node('\\end{definition}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('b-prop', {
        ls.text_node('\\begin{proposition}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('e-prop', {
        ls.text_node('\\end{proposition}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('b-thm', {
        ls.text_node('\\begin{theorem}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('e-thm', {
        ls.text_node('\\end{theorem}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('bm', {
        ls.text_node('\\(')
    })
})


ls.add_snippets('tex', {
    ls.snippet('em', {
        ls.text_node('\\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('b-eq', {
        ls.text_node('\\begin{equation}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('e-eq', {
        ls.text_node('\\end{equation}')
    })
})


ls.add_snippets('tex', {
    ls.snippet('m.v', {
        ls.text_node('\\( m \\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('n.v', {
        ls.text_node('\\( n \\)')
    })
})



ls.add_snippets('tex', {
    ls.snippet('j.v', {
        ls.text_node('\\( j \\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('i.v', {
        ls.text_node('\\( i \\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('k.v', {
        ls.text_node('\\( k \\)')
    })
})

ls.add_snippets('tex', {
    ls.snippet('K.v', {
        ls.text_node('\\( K \\)')
    })
})

ls.add_snippets('tex', {
    ls.snippet('n.v', {
        ls.text_node('\\( n \\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('f.v', {
        ls.text_node('\\( f \\)')
    })
})


ls.add_snippets('tex', {
    ls.snippet('g.v', {
        ls.text_node('\\( g \\)')
    })
})

ls.add_snippets('tex', {
    ls.snippet('sigma.v', {
        ls.text_node('\\( \\sigma \\)')
    })
})

ls.add_snippets('tex', {
    ls.snippet('tau.v', {
        ls.text_node('\\( \\tau \\)')
    })
})
