import Game.Metadata
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Tactic.Common

World "UOV"
Level 9

Title "QR-UOV: Structuring the Public Key With a Quotient Ring"

Introduction
"
## Shrinking the Public Key

UOV's public key is, at heart, a large block of field elements — one whole
matrix per output coordinate. **QR-UOV** (a 2024–2026 NIST-competition
variant, studied in Varjabedian's thesis, Ch. 4) shrinks this by building
large blocks out of a small number of elements of a **quotient ring**
`F[X] / (f(X))`, for a fixed polynomial `f`, instead of listing every entry
independently.

Mathlib builds exactly this ring as `AdjoinRoot f`: formally adjoin a root
of `f` to `F`, giving a new ring in which `f` has a root by construction.

### Your Task

Confirm what 'adjoining a root' actually means: prove that `f`, viewed as
an element of its own quotient ring `AdjoinRoot f` (via the canonical map
`AdjoinRoot.mk f`), becomes exactly `0`.

### Strategy

Mathlib already has this exact fact — it's essentially the definition.
"

Statement (F : Type) [Field F] (f : Polynomial F) :
    AdjoinRoot.mk f f = 0 := by
  Hint "This is Mathlib's own defining fact about `AdjoinRoot`. Type: exact AdjoinRoot.mk_self"
  exact AdjoinRoot.mk_self

Conclusion
"
`AdjoinRoot f` is a genuine, concrete commutative ring — the same kind of
object `ZMod n` and `Polynomial F` were — built to order so that `f` has a
root. QR-UOV's actual parameter selection and security analysis (how large
`f` needs to be, which attacks a *structured* public key becomes newly
vulnerable to) is 2026-frontier research, well beyond what this course
formalizes — but the ring it all runs on is exactly this one, and exactly
this concrete.

**APOS stage:** Object — confirming what a new algebraic structure actually
does, not just that it exists.
"

NewDefinition AdjoinRoot
NewTheorem AdjoinRoot.mk_self
