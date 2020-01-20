;;; ~/.doom.d/fontification.el -*- lexical-binding: t; -*-

;; symbol list taken from https://www.caam.rice.edu/~heinken/latex/symbols.pdf
;; added a few myself: to, ne, ge, le
(setq
 font-latex-match-math-command-keywords
 '("to"
   "le"
   "ge"
   "ne"
   "gets"
   "kappa"
   "lambda"
   "mu"
   "nu"
   "omega"
   "phi"
   "pi"
   "psi"
   "rho"
   "sigma"
   "tau"
   "theta"
   "upsilon"
   "xi"
   "zeta"
   "digamma"
   "varepsilon"
   "varkappa"
   "varphi"
   "varpi"
   "varrho"
   "varsigma"
   "vartheta"
   "Delta"
   "Gamma"
   "Lambda"
   "Omega"
   "Phi"
   "Pi"
   "Psi"
   "Sigma"
   "Theta"
   "Upsilon"
   "Xi"
   "aleph"
   "beth"
   "daleth"
   "gimel"
   "alpha"
   "beta"
   "chi"
   "delta"
   "epsilon"
   "eta"
   "gamma"
   "iota"

   "frac"
   "sqrt"
   "overline"
   "underline"
   "widehat"
   "widetilde"
   "overrightarrow"
   "overleftarrow"
   "overbrace"
   "underbrace"

   "vert"
   "Vert"
   "langle"
   "rangle"
   "lfloor"
   "rfloor"
   "lceil"
   "rceil"
   "backslash"
   "Uparrow"
   "uparrow"
   "Downarrow"
   "downarrow"
   "llcorner"
   "lrcorner"
   "ulcorner"
   "urcorner"
   "right"
   "left"
   "sum"
   "prod"
   "coprod"
   "int"
   "oint"
   "iint"
   "biguplus"
   "bigcap"
   "bigcup"
   "bigoplus"
   "bigotimes"
   "bigodot"
   "bigvee"
   "bigwedge"
   "bigsqcup"
   "arccos"
   "cos"
   "csc"
   "exp"
   "ker"
   "limsup"
   "min"
   "sinh"
   "arcsin"
   "cosh"
   "deg"
   "gcd"
   "lg"
   "ln"
   "Pr"
   "sup"
   "pi"
   "pi"
   "arctan"
   "cot"
   "det"
   "hom"
   "lim"
   "log"
   "sec"
   "tan"
   "arg"
   "coth"
   "dim"
   "inf"
   "liminf"
   "max"
   "sin"
   "tanh6"
   "pm"
   "mp"
   "amalg"
   "odot"
   "ominus"
   "oplus"
   "oslash"
   "otimes"
   "wr"
   "Box"
   "boxplus"
   "boxminus"
   "boxtimes"
   "boxdot"
   "square"
   "cap"
   "cup"
   "uplus"
   "sqcap"
   "sqcup"
   "wedge"
   "vee"
   "dagger"
   "ddagger"
   "barwedge"
   "curlywedge"
   "Cap"
   "bot"
   "intercal"
   "doublebarwedge"
   "lhd"
   "rhd"
   "triangleleft"
   "triangleright"
   "unlhd"
   "unrhd"
   "bigtriangledown"
   "bigtriangleup"
   "setminus"
   "veebar"
   "curlyvee"
   "Cup"
   "top"
   "rightthreetimes"
   "leftthreetimes"
   "ast"
   "star"
   "cdot"
   "circ"
   "bullet"
   "bigcirc"
   "diamond"
   "times"
   "div"
   "centerdot"
   "circledast"
   "circledcirc"
   "circleddash"
   "dotplus"
   "divideontimes"
   "equiv"
   "cong"
   "neq"
   "sim"
   "simeq"
   "approx"
   "asymp"
   "doteq"
   "propto"
   "models"
   "leq"
   "prec"
   "preceq"
   "ll"
   "subset"
   "subseteq"
   "sqsubset"
   "sqsubseteq"
   "dashv"
   "in"
   "geq"
   "succ"
   "succeq"
   "gg"
   "supset"
   "supseteq"
   "sqsupset"
   "sqsupseteq"
   "vdash"
   "ni"
   "perp"
   "mid"
   "parallel"
   "bowtie"
   "Join"
   "ltimes"
   "rtimes"
   "smile"
   "frown"
   "notin"
   "approxeq"
   "thicksim"
   "backsim"
   "backsimeq"
   "triangleq"
   "circeq"
   "bumpeq"
   "Bumpeq"
   "doteqdot"
   "thickapprox"
   "fallingdotseq"
   "risingdotseq"
   "varpropto"
   "therefore"
   "because"
   "eqcirc"
   "neq"
   "leqq"
   "leqslant"
   "lessapprox"
   "lll"
   "lessdot"
   "lesssim"
   "eqslantless"
   "precsim"
   "precapprox"
   "Subset"
   "subseteqq"
   "sqsubset"
   "preccurlyeq"
   "curlyeqprec"
   "blacktriangleleft"
   "trianglelefteq"
   "vartriangleleft"
   "geqq"
   "geqslant"
   "gtrapprox"
   "ggg"
   "gtrdot"
   "gtrsim"
   "eqslantgtr"
   "succsim"
   "succapprox"
   "Supset"
   "supseteqq"
   "sqsupset"
   "succcurlyeq"
   "curlyeqsucc"
   "blacktriangleright"
   "trianglerighteq"
   "vartriangleright"
   "lessgtr"
   "lesseqgtr"
   "lesseqqgtr"
   "gtreqqless"
   "gtreqless"
   "gtrless"
   "backepsilon"
   "between"
   "pitchfork"
   "shortmid"
   "smallfrown"
   "smallsmile"
   "Vdash"
   "vDash"
   "Vvdash"
   "shortparallel"
   "nshortparallel"
   "ncong"
   "nmid"
   "nparallel"
   "nshortmid"
   "nshortparallel"
   "nsim"
   "nVDash"
   "nvDash"
   "nvdash"
   "ntriangleleft"
   "ntrianglelefteq"
   "ntriangleright"
   "ntrianglerighteq"
   "nleq"
   "nleqq"
   "nleqslant"
   "nless"
   "nprec"
   "npreceq"
   "precnapprox"
   "precnsim"
   "lnapprox"
   "lneq"
   "lneqq"
   "lnsim"
   "lvertneqq"
   "ngeq"
   "ngeqq"
   "ngeqslant"
   "ngtr"
   "nsucc"
   "nsucceq"
   "succnapprox"
   "succnsim"
   "gnapprox"
   "gneq"
   "gneqq"
   "gnsim"
   "gvertneqq"
   "nsubseteq"
   "nsupseteq"
   "nsubseteqq"
   "nsupseteqq"
   "subsetneq"
   "supsetneq"
   "subsetneqq"
   "supsetneqq"
   "varsubsetneq"
   "varsupsetneq"
   "varsubsetneqq"
   "varsupsetneqq7"
   "leftarrow"
   "Leftarrow"
   "rightarrow"
   "Rightarrow"
   "leftrightarrow"
   "Leftrightarrow"
   "longleftarrow"
   "Longleftarrow"
   "longrightarrow"
   "Longrightarrow"
   "longleftrightarrow"
   "Longleftrightarrow"
   "uparrow"
   "Uparrow"
   "downarrow"
   "Downarrow"
   "updownarrow"
   "Updownarrow"
   "mapsto"
   "hookleftarrow"
   "leftharpoonup"
   "leftharpoondown"
   "rightleftharpoons"
   "longmapsto"
   "hookrightarrow"
   "rightharpoonup"
   "rightharpoondown"
   "leadsto"
   "nearrow"
   "searrow"
   "swarrow"
   "nwarrow"
   "dashleftarrow"
   "Lleftarrow"
   "looparrowleft"
   "circlearrowleft"
   "upharpoonleft"
   "leftrightsquigarrow"
   "rightrightarrows"
   "rightarrowtail"
   "curvearrowright"
   "downdownarrows"
   "rightsquigarrow"
   "dashrightarrow"
   "leftrightarrows"
   "leftarrowtail"
   "curvearrowleft"
   "upuparrows"
   "multimap"
   "rightleftarrows"
   "twoheadrightarrow"
   "rightleftharpoons"
   "Rsh"
   "downharpoonright"
   "leftleftarrows"
   "twoheadleftarrow"
   "leftrightharpoons"
   "Lsh"
   "downharpoonleft"
   "rightrightarrows"
   "rightleftarrows"
   "looparrowright"
   "circlearrowright"
   "upharpoonright"
   "nleftarrow"
   "nRightarrow"
   "nrightarrow"
   "nleftrightarrow"
   "nLeftarrow"
   "nLeftrightarrow"
   "infty"
   "nabla"
   "partial"
   "eth"
   "clubsuit"
   "diamondsuit"
   "heartsuit"
   "spadesuit"
   "cdots"
   "forall"
   "exists"
   "nexists"
   "emptyset"
   "varnothing"
   "imath"
   "jmath"
   "ell"
   "iiiint"
   "Bbbk"
   "bigstar"
   "diagdown"
   "diagup"
   "Diamond"
   "Finv"
   "Game"
   "hbar"
   "hslash"
   "wp"
   "angle"
   "measuredangle"
   "sphericalangle"
   "complement"
   "triangledown"
   "triangle"
   "vartriangle"
   "blacklozenge"
   "vdots"
   "ldots"
   "dots"
   "iiint"
   "iint"
   "lozenge"
   "mho"
   "blacksquare"
   "blacktriangle"
   "ddots"
   "Im"
   "Re"
   "sharp"
   "flat"
   "natural"
   "prime"
   "square"
   "surd"
   "blacktrinagledown"
   "backprime"
   "circledS"

   "Bar"
   "Check"
   "Hat"
   "bar"
   "check"
   "dot"
   "hat"
   "vec"
   "Acute"
   "Breve"
   "Ddot"
   "Grave"
   "Tilde"
   "Dot"
   "Vec"

   "right"
   "right"
   "right"
   "mbox"
   "mbox"
   "right"
   "mathcal"
   "mathbb"
   "mathfrak"
   "mathsf"
   "mathbf"
   "em"
   "mathbi"
   "normalsize"
   "large"
   "Large"
   "tiny"
   "scriptsize"
   "footnotesize"
   "small"
   "LARGE"
   "huge"
   "Huge"

   "displaystyle"
   "textstyle"
   "scriptstyle"
   "scriptscriptstyle"))
