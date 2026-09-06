import Game.Metadata
import Game.Levels.SecretSharing.L03_Uniqueness
import Mathlib.Tactic.Common

World "SecretSharingExam"
Level 2

Title "Exam: The Other Direction"

Introduction
"
## Checkpoint: The Shares Determine the Secret

Secret Sharing World's Level 3 proved: same interpolated polynomial ⟹ same
values at every node. Prove the converse this time: same values at every
node ⟹ same interpolated polynomial.

### Strategy

This direction doesn't even need the injectivity hypothesis `hvs` that
Level 3 needed — look for the specific lemma that says so.
"

Statement {F : Type} [Field F] {ι : Type} [DecidableEq ι]
    (s : Finset ι) (v r r' : ι → F) (hrr' : ∀ i ∈ s, r i = r' i) :
    Lagrange.interpolate s v r = Lagrange.interpolate s v r' := by
  Hint (hidden := true) "Search Mathlib's Lagrange namespace for a lemma going in exactly this direction, from values to interpolated polynomials."
  exact Lagrange.interpolate_eq_of_values_eq_on r r' hrr'

Conclusion
"
Interpolation is uniquely determined by the values, in both directions —
equal polynomials force equal values (Level 3), and equal values force
equal polynomials (this level). Together, they say the map from values to
polynomial really is a bijection on this data.

**Secret Sharing checkpoint complete.**

**APOS stage:** N/A — a retrieval checkpoint proving the converse of a
prior level's fact, not new teaching content.
"
