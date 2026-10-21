# Typst CTU Thesis

A Typst template for academic theses and reports at the Czech Technical University in Prague (CTU).

It is meant for semester projects, bachelor's theses, master's theses and similar assignments. The template was written with the [FEE CTU regulations](https://intranet.fel.cvut.cz/cz/rozvoj/smerniceSZZ.pdf) in mind and follows the thesis structure described.

> This is an unofficial template. Check requirements of your faculty and/or supervisor(s) for your own thesis.

---

### Example usage

See the template document in [template/main.typ](./template/main.typ).

---

### Parameters
 
`thesis()`:

| Parameter                    | Type                                 | Notes                                                                                                                    |
| ---------------------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| `language`                   | `"en"` or `"cs"`                     |                                                                                                                          |
| `thesis-type`                | `str`, `content`                     |                                                                                                                          |
| `title`                      | `str`, `content`                     |                                                                                                                          |
| `author`                     | `str`, `content`                     |                                                                                                                          |
| `faculty`                    | `str`, `content`                     |                                                                                                                          |
| `department`                 | `str`, `content`                     |                                                                                                                          |
| `study-program`              | `str`, `content`                     |                                                                                                                          |
| `supervisors`                | `array` of `str`                     |                                                                                                                          |
| `logo`                       | `content`                            | Image on the title page                                                                                                  |
| `date`                       | `auto`, `datetime`, `str`, `content` | `auto` is today. A `datetime` is shown as "Month Year" in the document language. A `str`/`content` is shown as provided. |
| `abstract-cs`, `abstract-en` | `str`, `content`                     |                                                                                                                          |
| `keywords-cs`, `keywords-en` | `array` of `str`                     |                                                                                                                          |
| `acknowledgements`           | `str`, `content`                     |                                                                                                                          |
| `assignment`                 | `content`                            |                                                                                                                          |
| `declaration`                | `content`                            |                                                                                                                          |
| `list-of-figures`            | `bool`                               |                                                                                                                          |
| `list-of-tables`             | `bool`                               |                                                                                                                          |
| `list-of-abbreviations`      | `array` of pairs                     | E.g. `(("CTU", "Czech Technical University"),)`                                                                          |
| `bibliography`               | `content`                            | A bibliography element, e.g. `bibliography("refs.bib")`. Pass `style:` to it if you do not want the default style        |
| `appendices`                 | `content`                            | Heading numbering format is `A.1`                                                                                        |
| `body`                       | `content`                            | Main document content                                                                                                    |

\
*Optional parameters can be omitted or set to none, where applicable.*