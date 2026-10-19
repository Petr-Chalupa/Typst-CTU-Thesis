# Typst CTU Thesis

A Typst template for academic reports and theses at the Czech Technical University in Prague (CTU).

The template is intended for:
- Semester projects
- Bachelor's theses
- Master's theses

Simple and reusable starting point for writing academic documents in Typst.

Example usage:

```typst
#import "@preview/ctu-thesis:0.1.0": thesis

#show: thesis.with(
  thesis-type: "Bachelor's thesis",
  title: "My thesis",
  author: "John Doe",
)

= Introduction

Write your thesis here.
```