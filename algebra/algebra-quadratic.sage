@interact
def solve_quadratic(
    a_str=input_box('1', label='a', type=str),
    b_str=input_box('1', label='b', type=str),
    c_str=input_box('1', label='c', type=str)
):
    try:
        var('x')
        a = SR(a_str)
        b = SR(b_str)
        c = SR(c_str)
        eq = a*x^2 + b*x + c == 0
        Delta = b^2 - 4*a*c
        Delta_val = Delta.n()
        
        show(LatexExpr(r"\text{Λύνουμε: } %s = 0" % latex(eq)))
        show(LatexExpr(r"\Delta = %s" % latex(Delta)))

        plot1 = plot(a*x^2 + b*x + c, (x, -10, 10), ymin=-10, ymax=10, color='blue')

        if Delta_val >= 0:
            r1 = (-b + sqrt(Delta)) / (2*a)
            r2 = (-b - sqrt(Delta)) / (2*a)
            roots = [r1, r2] if Delta_val > 0 else [r1]
            for r in roots:
                plot1 += point((r.n(), 0), size=30, color='green')
            show(roots)
        else:
            show(LatexExpr(r"\text{Μη πραγματικές ρίζες}"))

        plot1.show()
    except Exception:
        pretty_print(html("<span style='color:red'>Σφάλμα στην είσοδο</span>"))
