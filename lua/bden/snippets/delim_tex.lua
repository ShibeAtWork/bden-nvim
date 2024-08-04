local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets('tex', {


s(
    {trig="/;",
     snippetType='autosnippet'
    },
    {
        t("{"),
        i(1),
        t("}")
    }
),

s(
    {trig="d;s",
     snippetType='autosnippet'
    },
    {
        t("\\{"),
        i(1),
        t("\\}")
    }
),

s(
    {trig="d;fs",
     snippetType='autosnippet'
    },
    {
        t("\\left \\{"),
        i(1),
        t("\\right \\}")
    }
),

s(
    {trig="d;fr",
     snippetType='autosnippet'
    },
    {
        t("\\left ("),
        i(1),
        t("\\right )")
    }
),

s(
    {trig="d;r",
     snippetType='autosnippet'
    },
    {
        t("("),
        i(1),
        t(")")
    }
),

s(
    {trig="d;b",
     snippetType='autosnippet'
    },
    {
        t("["),
        i(1),
        t("]")
    }
),

s(
    {trig="d;fb",
     snippetType='autosnippet'
    },
    {
        t("\\left ["),
        i(1),
        t("\\right ]")
    }
)
})
