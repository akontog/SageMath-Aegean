@interact
def solve_quadratic(
    a_str=input_box('1', label='a', type=str),
    b_str=input_box('1', label='b', type=str),
    c_str=input_box('1', label='c', type=str)
):
    try:
        a = SR(a_str)
        b = SR(b_str)
        c = SR(c_str)

        if not all(-10 <= val.n() <= 10 for val in [a, b, c]):
            pretty_print(html("<span style='color:red'>Οι τιμές πρέπει να είναι μεταξύ -10 και 10.</span>"))
            return

        def format_coef_parentheses(coef):
            if coef.is_integer() and coef > 0:
                return str(int(coef))
            else:
                return f"({latex(coef)})"

        a_fmt, b_fmt, c_fmt = format_coef_parentheses(a), format_coef_parentheses(b), format_coef_parentheses(c)

        eq = a*x^2 + b*x + c == 0
        Delta = b^2 - 4*a*c
        Delta_val = Delta.n()

        show(LatexExpr(r"\text{Λύνουμε την εξίσωση:} \quad %s x^2 + %s x + %s = 0" % (
            a_fmt, b_fmt, c_fmt)))
        show(LatexExpr(r"\Delta = b^2 - 4ac = %s" % latex(Delta)))

        plot1 = plot(a*x^2 + b*x + c, (x, -10, 10), ymin=-10, ymax=10, color='blue', thickness=2, legend_label="y = ax² + bx + c")

        if Delta_val >= 0:
            r1 = (-b + sqrt(Delta)) / (2*a)
            r2 = (-b - sqrt(Delta)) / (2*a)
            roots = [r1, r2] if Delta_val > 0 else [r1]

            if Delta_val > 0:
                show(LatexExpr(
                    r"\textcolor{green}{\text{Πραγματικές ρίζες: }} "
                    r"x_1 = \frac{%s + \sqrt{%s}}{%s} \approx %s, \; "
                    r"x_2 = \frac{%s - \sqrt{%s}}{%s} \approx %s" %
                    (format_coef_parentheses(-b), latex(Delta), format_coef_parentheses(2*a), latex(r1.n(digits=3)),
                     format_coef_parentheses(-b), latex(Delta), format_coef_parentheses(2*a), latex(r2.n(digits=3)))
                ))
            else:
                r = r1
                show(LatexExpr(
                    r"\textcolor{green}{\text{Διπλή ρίζα: }} x = \frac{%s}{%s} \approx %s" %
                    (format_coef_parentheses(-b), format_coef_parentheses(2*a), latex(r.n(digits=3)))
                ))

            for r in roots:
                plot1 += point((r.n(), 0), size=30, color='green')

        else:
            r1 = (-b + sqrt(Delta)) / (2*a)
            r2 = (-b - sqrt(Delta)) / (2*a)
            show(LatexExpr(
                r"\textcolor{red}{\text{Μη πραγματικές ρίζες: }} x_1 = %s, \; x_2 = %s" %
                (latex(r1), latex(r2))
            ))

        plot1.show(legend_loc='upper right')

    except Exception:
        pretty_print(html("<span style='color:red'>Σφάλμα στην είσοδο: παρακαλώ συμπληρώστε σωστά τον μαθηματικό τύπο.</span>"))