local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets('tex', {


s(
    {trig="e;thm",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{theorem}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{theorem}",
            ""
        })
    }
),

s(
    {trig="e;def",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{definition}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{definition}",
            ""
        })
    }
),

s(
    {trig="e;prop",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{propositon}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{proposition}",
            ""
        })
    }
),

s(
    {trig="e;item",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{itemize}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{itemize}",
            ""
        })
    }
),

s(
    {trig="e;eqn",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{equation}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{equation}",
            ""
        })
    }
),

s(
    {trig="e;enum",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{enumerate}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{enumerate}",
            ""
        })
    }
),

s(
    {trig="mt;cal",
     snippetType='autosnippet'
    },
    {
        t("\\(\\mathbb{"),
        i(1),
        t("}\\)")
    }
),

s(
    {trig="t;bf",
     snippetType='autosnippet'
    },
    {
        t("\\textbf{"),
        i(1),
        t("}")
    }
),

s(
    {trig="t;e",
     snippetType='autosnippet'
    },
    {
        t("\\emph{"),
        i(1),
        t("}")
    }
),

s(
    {trig="t;it",
     snippetType='autosnippet'
    },
    {
        t("\\textit{"),
        i(1),
        t("}")
    }
),

s(
    {trig="t;tt",
     snippetType='autosnippet'
    },
    {
        t("\\text{ "),
        i(1),
        t(" }")
    }
),

s(
    {trig=";ff",
     snippetType='autosnippet'
    },
    {
        t("\\frac{"),
        i(1),
        t("}{"),
        i(2),
        t("}")
    }
),

s(
    {trig=";m",
     snippetType='autosnippet'
    },
    {
        t("\\("),
        i(1),
        t("\\)")
    }
),

s(
    {trig=";eq",
     snippetType='autosnippet'
    },
    {
        t("\\["),
        i(2),
        t("\\]")
    }
)
})
