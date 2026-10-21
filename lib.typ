// ---------------------------------------------------------------------------
// Localization
// ---------------------------------------------------------------------------

#let translations = (
  cs: (
    university: "ČESKÉ VYSOKÉ UČENÍ TECHNICKÉ V PRAZE",
    supervisor: "Vedoucí práce",
    supervisors: "Vedoucí práce",
    abstract: "Abstrakt",
    keywords: "Klíčová slova",
    acknowledgements: "Poděkování",
    toc: "Obsah",
    list-of-figures: "Seznam obrázků",
    list-of-tables: "Seznam tabulek",
    list-of-abbreviations: "Seznam zkratek",
    bibliography: "Literatura",
    months: (
      "leden",
      "únor",
      "březen",
      "duben",
      "květen",
      "červen",
      "červenec",
      "srpen",
      "září",
      "říjen",
      "listopad",
      "prosinec",
    ),
  ),
  en: (
    university: "CZECH TECHNICAL UNIVERSITY IN PRAGUE",
    supervisor: "Supervisor",
    supervisors: "Supervisors",
    abstract: "Abstract",
    keywords: "Keywords",
    acknowledgements: "Acknowledgements",
    toc: "Contents",
    list-of-figures: "List of Figures",
    list-of-tables: "List of Tables",
    list-of-abbreviations: "List of Abbreviations",
    bibliography: "References",
    months: (
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ),
  ),
)

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

#let _present(x) = x != none and x != "" and x != []

#let _chapters(style, body) = {
  set heading(numbering: style)
  set figure(numbering: n => numbering(style, counter(heading).get().first(), n))
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    for kind in (image, table, raw) { counter(figure.where(kind: kind)).update(0) }
    it
  }
  body
}

#let _format-date(date, tr) = {
  if date == auto { date = datetime.today() }
  if type(date) == datetime {
    tr.months.at(date.month() - 1) + " " + str(date.year())
  } else {
    date
  }
}

// ---------------------------------------------------------------------------
// Template
// ---------------------------------------------------------------------------

#let thesis(
  language: "en",

  thesis-type: "Thesis type",
  title: "Title",
  author: "Name of the author",
  faculty: none,
  department: none,
  study-program: none,
  supervisors: (),
  logo: none,
  date: auto,

  abstract-cs: [],
  keywords-cs: (),
  abstract-en: [],
  keywords-en: (),

  acknowledgements: none,

  assignment: none,
  declaration: none,

  list-of-figures: false,
  list-of-tables: false,
  list-of-abbreviations: (),
  bibliography: none,
  appendices: none,

  body,
) = {
  assert(language in ("cs", "en"), message: "`language` must be \"cs\" or \"en\"")
  let tr = translations.at(language)

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
  )

  set text(
    font: "Libertinus Serif",
    size: 11pt,
    lang: language,
    region: if language == "cs" { "CZ" } else { "US" },
  )

  set par(
    justify: true,
    leading: 0.65em,
    spacing: 0.65em,
    first-line-indent: 1.5em,
  )

  show heading.where(level: 1): set text(size: 1.65em, weight: "bold")
  show heading.where(level: 1): set block(above: 1.75em, below: 0.75em)
  show heading.where(level: 2): set text(size: 1.3em, weight: "bold")
  show heading.where(level: 2): set block(above: 1.5em, below: 0.75em)
  show heading.where(level: 3): set text(size: 1.1em, weight: "bold")
  show heading.where(level: 3): set block(above: 1.25em, below: 0.5em)

  // Title page
  [
    #set page(margin: 2.5cm, numbering: none)

    #align(center)[
      #if logo != none [
        #logo
        #v(0.4em)
      ]
      #text(size: 16pt, weight: "bold")[#tr.university]
      #if _present(faculty) [
        #v(0.4em)
        #text(size: 14pt, weight: "bold")[#faculty]
      ]
      #if _present(department) [
        #v(0.4em)
        #text(size: 12pt)[#department]
      ]
    ]

    #v(3cm)

    #align(center)[
      #text(size: 16pt, weight: "bold")[#thesis-type]
      #v(0.5em)
      #text(size: 20pt, weight: "bold")[#title]
    ]

    #v(2cm)

    #align(center)[
      #text(size: 16pt)[#author]
      #if _present(study-program) [
        #v(0.5em)
        #text(size: 12pt)[#study-program]
      ]
    ]

    #v(1fr)

    #grid(
      columns: (1fr, 1fr),
      align: bottom,
      [
        #if supervisors.len() > 0 [
          #text(weight: "bold")[
            #if supervisors.len() == 1 [#tr.supervisor] else [#tr.supervisors]
          ]
          #for supervisor in supervisors [
            #linebreak()
            #supervisor
          ]
        ]
      ],
      [
        #align(right)[
          #_format-date(date, tr)
        ]
      ],
    )
  ]

  [
    #set page(numbering: "i")

    // Insert assignment and declaration content
    #for page-content in (assignment, declaration) {
      if page-content != none {
        pagebreak()
        page-content
      }
    }

    // Abstracts and keywords
    #pagebreak()
    #let abstracts = (
      (translations.cs, abstract-cs, keywords-cs),
      (translations.en, abstract-en, keywords-en),
    )
    #if language == "en" { abstracts = abstracts.rev() }

    #for (translation, abstract, keywords) in abstracts {
      heading(level: 1, outlined: false)[
        #translation.abstract
      ]
      abstract
      v(0.8em)
      [*#translation.keywords:* #keywords.join(", ")]
    }

    // Acknowledgements
    #if _present(acknowledgements) {
      pagebreak()
      heading(level: 1, outlined: false)[
        #tr.acknowledgements
      ]
      acknowledgements
    }

    // Table of contents
    #pagebreak()
    #outline(title: tr.toc, depth: 3)

    // List of figures
    #if list-of-figures {
      pagebreak()
      outline(title: tr.list-of-figures, target: figure.where(kind: image))
    }

    // List of tables
    #if list-of-tables {
      pagebreak()
      outline(title: tr.list-of-tables, target: figure.where(kind: table))
    }

    // List of abbreviations
    #if list-of-abbreviations.len() > 0 {
      pagebreak()
      heading(level: 1, outlined: false)[
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
  ]

  [
    #set page(numbering: "1")
    #counter(page).update(1)

    // Main document
    #[
      #show: _chapters.with("1.1")
      #pagebreak()
      #body
    ]

    // Bibliography
    #if bibliography != none {
      set std.bibliography(title: tr.bibliography)
      pagebreak()
      bibliography
    }

    // Appendices
    #if appendices != none {
      counter(heading).update(0)
      show: _chapters.with("A.1")
      appendices
    }
  ]
}
