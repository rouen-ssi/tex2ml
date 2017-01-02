# TeX2ML
A LaTeX to MathML compiler written with Flex and Bison.

## Installation
```
make
```
Executable goes in `bin/`.

## Usage
```
tex2ml "<a LaTeX expression>"
```
The LaTeX expression **must** be quoted. The program gives the corresponding MathML to the standard output.

## Supported expressions
- Numerics (1, 2, 3, ...)
- Identifiers (a, b, c, ...)
- Operators (+, -, *, =, ...)
- Fractions
- Square roots
- Summation symbols
