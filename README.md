# Typst CTU Thesis

A Typst template for academic theses and reports at the Czech Technical University in Prague (CTU).

The template is intended for semester projects, bachelor's theses, master's theses and similar assignments.

It includes the standard sections and formatting required by the [CTU regulations](https://intranet.fel.cvut.cz/cz/rozvoj/smerniceSZZ.pdf).

---

### Example usage

See the template document in [template/main.typ](./template/main.typ).

---

### API

The template exposes the function `thesis()`.

`thesis()` parameters:
- `language`: document language, either `"en"` or `"cs"`
- `thesis-type`: type of thesis or assignment shown on the title page
- `title`: document title
- `author`: author name
- `faculty`: faculty name shown on the title page
- `department`: optional department name shown on the title page
- `study-program`: optional study program shown under the author
- `supervisors`: list of supervisors shown on the title page
- `logo`: optional image to display on the title page
- `date`: date displayed on the title page
- `abstract-cs`: Czech abstract content
- `keywords-cs`: Czech keywords
- `abstract-en`: English abstract content
- `keywords-en`: English keywords
- `acknowledgements`: optional acknowledgements section content
- `assignment`: optional assignment page content
- `declaration`: optional declaration page content
- `list-of-figures`: whether to include a list of figures
- `list-of-tables`: whether to include a list of tables
- `list-of-abbreviations`: list of abbreviation pairs, e.g. `(("CTU", "Czech Technical University"), ...)`
- `bibliography-file`: BibTeX/Bibliography file for references
- `bibliography-style`: bibliography style used by Typst, such as `"ieee"`
- `appendices`: content for the appendices section
- `body`: main document content

*Some parameters are optional and use default values; they can be omitted if not needed.*