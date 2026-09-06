import Game.Metadata
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic.Common

World "UOV"
Level 11

Title "Capstone: Why a Signing Key Can Be Split"

Introduction
"
## Two Worlds, One Fact

**Threshold UOV** (Varjabedian's thesis, Ch. 5) lets several parties jointly
hold a UOV signing key — no single party ever sees the whole secret map
`S` — and still jointly produce a valid signature. The full protocol
handles matrix inversion (Level 10's invertibility, computed *without*
reassembling the key) across several parties; the mathematical fact making
any of it possible at all is one you've already proved, in a different
world entirely.

Secret Sharing World's `Lagrange.interpolate s v` is a **linear map**
(`(ι → F) →ₗ[F] F[X]`) — you saw this in its type signature without it
being the point of any level. Every linear map satisfies `map_add`:
applying it to a sum is the same as summing the applications. For Shamir
shares, that means:

    reconstruct(shares₁ + shares₂) = reconstruct(shares₁) + reconstruct(shares₂)

Parties can add their local pieces together *before* anyone reconstructs
anything, and still get the right combined answer. That is one real
ingredient of threshold signing — the *linear* steps can be done share-by-
share, combined at the end. It is not the whole protocol: the genuinely
hard parts (jointly inverting a shared matrix without ever assembling it,
and staying secure against a dishonest party) are what Varjabedian's
thesis Chapter 5 spends most of its effort on, and this course doesn't
formalize them.

### Your Task

Prove that reconstructing the sum of two share-vectors equals the sum of
the two reconstructed polynomials.

### Strategy

This is `map_add`, applied to `Lagrange.interpolate s v` as a linear map —
nothing about polynomials or secret sharing specifically is needed.
"

Statement {F : Type} [Field F] {ι : Type} [DecidableEq ι]
    (s : Finset ι) (v r1 r2 : ι → F) :
    Lagrange.interpolate s v (r1 + r2)
      = Lagrange.interpolate s v r1 + Lagrange.interpolate s v r2 := by
  Hint "`Lagrange.interpolate s v` is a linear map — every linear map satisfies this. Type: exact map_add (Lagrange.interpolate s v) r1 r2"
  exact map_add (Lagrange.interpolate s v) r1 r2

Conclusion
"
Congratulations — you've completed the UOV World!

Nothing about Shamir's polynomials or UOV's quadratic maps was specific to
this proof: `map_add` is a single-line fact about *any* linear map,
including `Lagrange.interpolate`. Threshold UOV takes exactly this
observation — that reconstructing a sum equals summing reconstructions —
and uses it for the *linear* steps of splitting a signing key across
several parties: each party adds their own share of a computation, and
only the sum ever needs reconstructing. It is one real ingredient, not the
whole protocol — the genuinely hard parts (jointly inverting a shared
matrix without ever assembling it, and staying secure against a
dishonest party) are what Varjabedian's thesis Chapter 5 actually spends
most of its effort on, and this course doesn't formalize them.

This is also the payoff of everything since Level 1: 'quadratic map from a
matrix' (Level 1), 'invertible iff nonzero determinant' (Level 10), and
'linear maps distribute over addition' (this level) are three real
ingredients of a 2026 research protocol — built from tools no more advanced than what a first course in
linear algebra already gives you.

**MinRank World** is this game's other track out of Matrix Algebra World —
independent of everything in UOV World, so you may already have played it.
Once both UOV World and MinRank World are done (alongside the Public-Key
Exam), the same matrices you just used to defend a signature scheme
reappear as an *attacker's* tool in the **Final Exam**.

**APOS stage:** Schema — a fact from Secret Sharing World, applied to
UOV's signing key, synthesizing both worlds into one protocol-level
guarantee.
"
