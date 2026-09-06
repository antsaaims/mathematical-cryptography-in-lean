import GameServer.Commands
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Algebra.Group.Basic
import Mathlib.Data.Fintype.Pigeonhole
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Data.Nat.Totient
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Data.Nat.ModEq
import Mathlib.LinearAlgebra.QuadraticForm.Basic

/-! Central documentation for every named theorem unlocked in this game.
New entries get added here as later worlds unlock them — this file grows
with the course rather than each theorem's doc living next to its level. -/

/-- Over a field, a square matrix is invertible exactly when its determinant
is a unit (i.e. nonzero). This is the bridge between "the matrix is
invertible," "the matrix has full rank," and "the determinant is nonzero" —
three descriptions of the same fact. -/
TheoremDoc Matrix.isUnit_iff_isUnit_det as "isUnit_iff_isUnit_det" in "Linear Algebra"

/-- If `a + b = a + c`, then `b = c` — cancelling a shared left summand. -/
TheoremDoc add_left_cancel as "add_left_cancel" in "Algebra"

/-- If `f : α → β` and `α` has strictly more elements than `β`, then two
distinct inputs must map to the same output — the pigeonhole principle. -/
TheoremDoc Fintype.exists_ne_map_eq_of_card_lt as "exists_ne_map_eq_of_card_lt" in "Combinatorics"

/-- Fermat's Little Theorem: for a prime `p` and nonzero `a : ZMod p`,
`a ^ (p - 1) = 1`. -/
TheoremDoc ZMod.pow_card_sub_one_eq_one as "pow_card_sub_one_eq_one" in "Number Theory"

/-- Euler's Theorem (the Fermat–Euler totient theorem): if `x` and `n` are
coprime, then `x ^ n.totient ≡ 1 [MOD n]`. Fermat's Little Theorem is the
special case where `n` is prime. -/
TheoremDoc Nat.ModEq.pow_totient as "pow_totient" in "Number Theory"

/-- For a prime `p`, `p.totient = p - 1` — every one of `1, …, p-1` shares no
factor with `p`. -/
TheoremDoc Nat.totient_prime as "totient_prime" in "Number Theory"

/-- In a finite group `G`, `x ^ Fintype.card G = 1` for *every* element `x`
— Lagrange's Theorem, without needing `x` to be a generator. -/
TheoremDoc pow_card_eq_one as "pow_card_eq_one" in "Groups"

/-- The identity element of any group has order `1`. -/
TheoremDoc orderOf_one as "orderOf_one" in "Groups"

/-- The defining property of order: `x ^ orderOf x = 1`. -/
TheoremDoc pow_orderOf_eq_one as "pow_orderOf_eq_one" in "Groups"

/-- In a finite group, the order of any element divides the group's size —
a consequence of Lagrange's Theorem. -/
TheoremDoc orderOf_dvd_card as "orderOf_dvd_card" in "Groups"

/-- If `a ≡ b [MOD n]`, then `a ^ m ≡ b ^ m [MOD n]` for any exponent `m`. -/
TheoremDoc Nat.ModEq.pow as "ModEq.pow" in "Number Theory"

/-- If `a ≡ b [MOD n]`, then `c * a ≡ c * b [MOD n]` for any `c`. -/
TheoremDoc Nat.ModEq.mul_left as "ModEq.mul_left" in "Number Theory"

/-- If `a ≡ b [MOD n]` and `c ≡ d [MOD n]`, then `a * c ≡ b * d [MOD n]`. -/
TheoremDoc Nat.ModEq.mul as "ModEq.mul" in "Number Theory"

/-- A quadratic map built from a bilinear map, evaluated at `x`, equals the
bilinear map applied to `x` twice: `B.toQuadraticMap x = B x x`. -/
TheoremDoc LinearMap.BilinMap.toQuadraticMap_apply as "toQuadraticMap_apply" in "Linear Algebra"

/-- Composing a quadratic map `Q` with a linear map `f` on the input side:
`(Q.comp f) x = Q (f x)` — the quadratic analogue of `LinearMap.comp_apply`. -/
TheoremDoc QuadraticMap.comp_apply as "QuadraticMap.comp_apply" in "Linear Algebra"

/-- `f`, viewed inside its own quotient ring `AdjoinRoot f`, becomes exactly
`0` — the defining sense in which `AdjoinRoot f` has a root of `f`. -/
TheoremDoc AdjoinRoot.mk_self as "AdjoinRoot.mk_self" in "Linear Algebra"
