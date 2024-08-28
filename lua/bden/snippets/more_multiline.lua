local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets('tex', {


s(
    {trig="sd;r",
     snippetType='autosnippet'
    },
    {
        t("\\mathbb{R}^{"),
        i(1),
        t("}")
    }
),

s(
    {trig="sd;q",
     snippetType='autosnippet'
    },
    {
        t("\\mathbb{Q}^{"),
        i(1),
        t("}")
    }
),

s(
    {trig="sd;z",
     snippetType='autosnippet'
    },
    {
        t("\\mathbb{Z}^{"),
        i(1),
        t("}")
    }
),

s(
    {trig="sd;c",
     snippetType='autosnippet'
    },
    {
        t("\\mathbb{C}^{"),
        i(1),
        t("}")
    }
),

s(
    {trig="sd;n",
     snippetType='autosnippet'
    },
    {
        t("\\mathbb{N}^{"),
        i(1),
        t("}")
    }
),

s(
    {trig="hd;asc",
     snippetType='autosnippet'
    },
    {
        t("\\section*{"),
        i(1),
        t("}\\label{sec:"),
        i(2),
        t("}")
    }
),

s(
    {trig="hd;asbsc",
     snippetType='autosnippet'
    },
    {
        t("\\subsection*{"),
        i(1),
        t("}\\label{subsec:"),
        i(2),
        t("}")
    }
),

s(
    {trig="e;aeq",
     snippetType='autosnippet'
    },
    {
        t("\\begin{equation*}\\label{eq:"),
        i(1),
        t({
            "}",
            ""
        }),
        i(2),
        t({
            "",
            "\\end{equation}"
        })
    }
),

s(
    {trig="e;pf",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{proof}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{proof}"
        })
    }
),

s(
    {trig="k;sl",
     snippetType='autosnippet'
    },
    {
        t("\\starlocal{"),
        i(1),
        t("}")
    }
),

s(
    {trig="e;td",
     snippetType='autosnippet'
    },
    {
        t("\\todo{"),
        i(1),
        t("}")
    }
),

s(
    {trig="e;meq",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{align}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{align}"
        })
    }
),

s(
    {trig="e;ameq",
     snippetType='autosnippet'
    },
    {
        t({
            "\\begin{align*}",
            ""
        }),
        i(1),
        t({
            "",
            "\\end{align*}"
        })
    }
),

s(
    {trig="k;cov",
     snippetType='autosnippet'
    },
    {
        t("\\text{Cov}("),
        i(1),
        t(", "),
        i(2),
        t(")")
    }
),

s(
    {trig="k;var",
     snippetType='autosnippet'
    },
    {
        t("\\text{Var}("),
        i(1),
        t(")")
    }
)
})
