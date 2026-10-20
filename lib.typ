#let translations = (
  cs: (
    university: "ČESKÉ VYSOKÉ UČENÍ TECHNICKÉ V PRAZE",
    supervisors: "Vedoucí práce",
    abstract: "Abstrakt",
    keywords: "Klíčová slova",
    acknowledgements: "Poděkování",
    toc: "Obsah",
    list-of-figures: "Seznam obrázků",
    list-of-tables: "Seznam tabulek",
    list-of-abbreviations: "Seznam zkratek",
    bibliography: "Literatura",
    appendices: "Přílohy",
  ),
  en: (
    university: "CZECH TECHNICAL UNIVERSITY IN PRAGUE",
    supervisors: "Supervisors",
    abstract: "Abstract",
    keywords: "Keywords",
    acknowledgements: "Acknowledgements",
    toc: "Contents",
    list-of-figures: "List of Figures",
    list-of-tables: "List of Tables",
    list-of-abbreviations: "List of Abbreviations",
    bibliography: "References",
    appendices: "Appendices",
  ),
)

#let thesis(
  language: "en",

  thesis-type: "Semestrální práce",
  title: "Název práce",
  author: "Jméno Příjmení",
  study-program: "",
  supervisors: (),
  logo: none,
  date: datetime.today().display("[month repr:long] [year]"),

  abstract-cs: [],
  keywords-cs: (),
  abstract-en: [],
  keywords-en: (),

  acknowledgements: "",

  assignment: none,
  declaration: none,

  list-of-figures: false,
  list-of-tables: false,
  list-of-abbreviations: (),
  bibliography-file: none,
  bibliography-style: "ieee",
  appendices: none,

  body,
) = {
  let lang = if language == "cs" { "cs" } else { "en" }
  let tr = translations.at(lang)

  // Metadata
  set document(
    title: title,
    author: author,
    description: author + ": " + title,
    keywords: keywords-cs + keywords-en,
  )

  // Typesetting
  set page(
    paper: "a4",
    margin: (
      x: 3.25cm,
      top: 3cm,
      bottom: 3.5cm,
    ),
    binding: auto,
    numbering: "1",
  )

  set text(
    font: "Libertinus Serif",
    size: 11pt,
    lang: lang,
    region: if lang == "cs" { "cz" } else { "us" },
  )

  set par(
    justify: true,
    leading: 0.65em,
    spacing: 0.65em,
    first-line-indent: 1.5em,
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): set text(size: 1.65em, weight: "bold")
  show heading.where(level: 1): set block(above: 1.75em, below: 0.75em)
  show heading.where(level: 2): set text(size: 1.3em, weight: "bold")
  show heading.where(level: 2): set block(above: 1.5em, below: 0.75em)
  show heading.where(level: 3): set text(size: 1.1em, weight: "bold")
  show heading.where(level: 3): set block(above: 1.25em, below: 0.5em)

  // Title page
  page(margin: 2.5cm, numbering: none)[
    #align(center)[
      #if logo != none [
        #logo
      ]
      #text(size: 16pt, weight: "bold")[
        #tr.university
      ]
    ]

    #v(3cm)

    #align(center)[
      #text(size: 22pt, weight: "bold")[
        #thesis-type
      ]
      #v(0.5em)
      #text(size: 16pt)[
        #title
      ]
    ]

    #v(2cm)

    #align(center)[
      #text(size: 14pt)[
        #author
        #v(0.5em)
        #if study-program != "" [
          #study-program
        ]
      ]
    ]

    #v(1fr)

    #grid(
      columns: (1fr, 1fr),
      align: bottom,
      [
        #if supervisors.len() > 0 [
          #text(weight: "bold")[
            #tr.supervisors
          ]
          #for supervisor in supervisors [
            #linebreak()
            #supervisor
          ]
        ]
      ],
      [
        #align(right)[
          #date
        ]
      ],
    )
  ]

  // Insert optional assignment and declaration content
  for content in (assignment, declaration) {
    if content != none {
      pagebreak()
      content
    }
  }

  // Abstracts and keywords
  pagebreak()

  let abstracts = if lang == "cs" {
    (
      (translations.cs, abstract-cs, keywords-cs),
      (translations.en, abstract-en, keywords-en),
    )
  } else {
    (
      (translations.en, abstract-en, keywords-en),
      (translations.cs, abstract-cs, keywords-cs),
    )
  }

  for (translation, abstract, keywords) in abstracts {
    heading(level: 1, numbering: none, outlined: false)[
      #translation.abstract
    ]
    abstract
    v(0.8em)
    if keywords.len() > 0 [
      *#translation.keywords:* #keywords.join(", ")
    ]
  }

  // Acknowledgements
  if acknowledgements != "" {
    pagebreak()
    heading(level: 1, numbering: none, outlined: false)[
      #tr.acknowledgements
    ]
    acknowledgements
  }

  // Table of contents
  pagebreak()
  outline(title: tr.toc, depth: 3)

  // List of figures
  if list-of-figures {
    pagebreak()
    outline(title: tr.list-of-figures, target: figure.where(kind: image))
  }

  // List of tables
  if list-of-tables {
    pagebreak()
    outline(title: tr.list-of-tables, target: figure.where(kind: table))
  }

  // List of abbreviations
  if list-of-abbreviations.len() > 0 {
    pagebreak()
    heading(level: 1, numbering: none, outlined: false)[
      #tr.list-of-abbreviations
    ]
    columns(2, gutter: 5em)[
      #for (abbreviation, definition) in list-of-abbreviations [
        #grid(
          columns: (1fr, 3fr),
          column-gutter: 1em,
          [#strong(abbreviation)], [#definition],
        )
        #v(0.2em)
      ]
    ]
  }

  // Main document
  pagebreak()
  body

  // Bibliography
  if bibliography-file != none {
    pagebreak()
    bibliography(
      bibliography-file,
      title: tr.bibliography,
      style: bibliography-style,
    )
  }

  // Appendicies
  if appendices != none {
    pagebreak()
    set heading(numbering: none)
    heading(level: 1)[#tr.appendices]
    appendices
  }
}
