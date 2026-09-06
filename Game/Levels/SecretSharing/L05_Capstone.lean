import Game.Metadata
import Game.Levels.SecretSharing.L04_TheSecret
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Tactic.Common

World "SecretSharing"
Level 5

Title "Capstone: Shamir's Secret Sharing Is Correct"

Introduction
"
## Reconstruction Recovers the Secret

Here is the full scheme. A dealer picks a secret polynomial `P` of degree
less than `t = #s` and hands participant `i ∈ s` the share `P.eval (v i)`.
Anyone holding all `t` shares reconstructs a polynomial via
`Lagrange.interpolate`; because `P` itself has degree less than `t`, that
reconstruction must land back on `P` exactly — a low-degree polynomial is
completely pinned down by `t` of its own values, a stronger fact than
Level 3's (which only compared two reconstructions against *each other*,
not against the original `P`). Reading off the secret is then just
evaluating that reconstructed polynomial at `0`.

A genuinely low-degree polynomial being unrecoverable from *fewer* than `t`
points (Shamir's actual privacy guarantee: with only `t - 1` shares, every
possible secret remains equally consistent with what you've seen) is a real
and standard fact about polynomials of bounded degree — but it isn't one
this course formalizes. What you've proved so far, and what this capstone
finishes, is the *correctness* half of the scheme: `t` shares always
reconstruct the right answer.

### Your Task

Prove that reconstruction really works: interpolating the shares and
evaluating at `0` gives back exactly `shamirSecret P`.

### Strategy

Mathlib has a lemma for 'a low-degree polynomial equals its own
interpolation from its values' — apply it (backwards) to replace the
reconstructed polynomial with `P` itself, then unfold `shamirSecret`.
"

def shamirShares {F : Type} [Field F] {ι : Type} (P : Polynomial F) (v : ι → F) :
    ι → F := fun i => P.eval (v i)

Statement {F : Type} [Field F] {ι : Type} [DecidableEq ι]
    (s : Finset ι) (v : ι → F) (P : Polynomial F)
    (hvs : Set.InjOn v s) (hdeg : P.degree < s.card) :
    Polynomial.eval 0 (Lagrange.interpolate s v (shamirShares P v)) = shamirSecret P := by
  Hint "Level 1 already says each share is `P.eval (v i)` by definition — every value `eval_f` needs is `rfl`. Type: rw [← Lagrange.eq_interpolate_of_eval_eq (shamirShares P v) hvs hdeg (fun i _ => rfl)]"
  rw [← Lagrange.eq_interpolate_of_eval_eq (shamirShares P v) hvs hdeg (fun i _ => rfl)]
  Hint "The goal is now exactly the definition of `shamirSecret`. Type: rfl"
  rfl

Conclusion
"
Congratulations — you've completed the Secret Sharing World!

You proved Shamir's scheme's correctness: `t` participants, holding
genuine shares of the same secret polynomial, always reconstruct the
dealer's exact secret — because a polynomial of degree less than `t` is
completely determined by any `t` of its values, there's no room for
reconstruction to land anywhere else. The complementary privacy guarantee —
that `t - 1` shares reveal nothing at all — is real, standard, and worth
knowing, but is not something this course formalizes.

Recall from `Lagrange.interpolate`'s own signature that it's declared as a
**linear map** on the share values. That single fact — interpolation is
linear — is what a much more advanced protocol (splitting a signing key
itself across several parties) will reuse later, once Matrix Algebra and
UOV Worlds have given you something worth splitting.

Next: a short **Secret Sharing Exam** checkpoint, after which you're free
to continue to **Public-Key Cryptography World** or **Matrix Algebra
World** — both independent tracks you may already have started.

**APOS stage:** Schema — Levels 1 and 4, synthesized (via the degree bound
that makes reconstruction unique) into the full correctness statement of a
real cryptographic protocol.
"
