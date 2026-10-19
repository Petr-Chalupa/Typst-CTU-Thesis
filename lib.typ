#let thesis(
  title: "Název práce",
  author: "Jméno Příjmení",
  body,
) = {
  set document(
    title: title,
    author: author,
  )

  // set page(
  //   paper: "a4",
  //   margin: 2.5cm,
  //   numbering: "1",
  // )

  // set text(
  //   lang: "cs",
  //   region: "cz",
  //   size: 12pt,
  // )

  // set heading(numbering: "1.")

  body
}
