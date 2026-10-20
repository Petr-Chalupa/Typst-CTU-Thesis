#import "@preview/ctu-thesis:0.1.0": thesis

#show: thesis.with(
  thesis-type: "Bachelor's thesis",
  title: "Example Thesis",
  author: "John Doe",
  faculty: "Faculty of Electrical Engineering",
  department: "Department of Cybernetics",
  study-program: "Open Informatics",
  supervisors: ("Dr. Alex Smith",),
  abstract-en: [This thesis explores a simple example problem and outlines an approach to its solution.],
  keywords-en: ("example",),
  abstract-cs: [Tato práce se zabývá jednoduchým příkladem problému a nastiňuje přístup k jeho řešení.],
  keywords-cs: ("příklad",),
  appendices: [
    = Supplementary Notes

    Additional details.

    = Example Data

    A small sample.
  ],
)

= Introduction

#lorem(50)

== Goals

#lorem(100)

#lorem(100)
