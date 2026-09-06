import GameServer.Commands
import Mathlib.Data.ZMod.Defs
import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.Algebra.Module.LinearMap.Defs
import Mathlib.Algebra.Module.Equiv.Defs
import Mathlib.Logic.Equiv.Defs
import Mathlib.LinearAlgebra.BilinearMap
import Mathlib.RingTheory.AdjoinRoot
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.Algebra.Polynomial.Basic
import Mathlib.LinearAlgebra.Lagrange
import Mathlib.Data.Nat.ChineseRemainder

/-! Central documentation for every definition unlocked in this game. -/

/-- `Nat`, written `ℕ`, is the type of natural numbers `0, 1, 2, …`. -/
DefinitionDoc Nat as "ℕ"

/-- `ZMod n` is the ring of integers modulo `n` — the exact structure that
makes modular arithmetic (and hence Caesar shifts, RSA, and Diffie–Hellman)
into ordinary ring algebra. -/
DefinitionDoc ZMod as "ZMod n"

/-- `Matrix m n α` is the type of `m × n` matrices with entries in `α`,
represented as functions `m → n → α`. -/
DefinitionDoc Matrix as "Matrix"

/-- `A.det` is the determinant of a square matrix `A`: a single scalar that
is zero exactly when `A` is singular (non-invertible). -/
DefinitionDoc Matrix.det as "A.det"

/-- `Aᵀ` (or `Matrix.transpose A`) flips a matrix across its diagonal:
`Aᵀ i j = A j i`. -/
DefinitionDoc Matrix.transpose as "Aᵀ"

/-- `A.submatrix r c` extracts a smaller matrix from `A` by selecting rows
via `r` and columns via `c`. The determinant of a square submatrix is
called a *minor*. -/
DefinitionDoc Matrix.submatrix as "A.submatrix"

/-- `Matrix.rank A` is the dimension of the column space of `A` — informally,
the number of genuinely independent rows (or columns) `A` has. -/
DefinitionDoc Matrix.rank as "rank A"

/-- `M →ₗ[R] N` is the type of `R`-linear maps from `M` to `N`: functions
that respect both addition and scalar multiplication. -/
DefinitionDoc LinearMap as "M →ₗ[R] N"

/-- `M ≃ₗ[R] N` is a linear map with a two-sided linear inverse — an
invertible linear map, bundled together with its inverse. -/
DefinitionDoc LinearEquiv as "M ≃ₗ[R] N"

/-- `Equiv.Perm α` is the type of bijections from `α` to itself, bundled
together with their inverse — a permutation. -/
DefinitionDoc Equiv.Perm as "Equiv.Perm α"

/-- `LinearMap.BilinMap R M N`, i.e. `M →ₗ[R] M →ₗ[R] N`, is a map taking
two `M`-inputs, linear in each separately — a bilinear map, or in
coordinates, a matrix. -/
DefinitionDoc LinearMap.BilinMap as "BilinMap R M N"

/-- `AdjoinRoot f` formally adjoins a root of the polynomial `f` to its base
ring, producing a new (commutative) ring in which `f` has a root. -/
DefinitionDoc AdjoinRoot as "AdjoinRoot f"

/-- `orderOf g` is the smallest positive `n` with `g ^ n = 1` — how many
times you must repeat `g` before returning to the identity. -/
DefinitionDoc orderOf as "orderOf g"

/-- `Polynomial R` (written `R[X]`) is the ring of polynomials with
coefficients in `R`, with a distinguished indeterminate `X`. -/
DefinitionDoc Polynomial as "R[X]"

/-- `Lagrange.interpolate s v` is the linear map sending a value-function
`r : ι → F` to the unique lowest-degree polynomial passing through every
point `(v i, r i)` for `i ∈ s`. -/
DefinitionDoc Lagrange.interpolate as "Lagrange.interpolate s v"

/-- `Nat.chineseRemainder` bundles a solution to a simultaneous-congruence
problem together with the proofs that it actually satisfies both
congruences — the Chinese Remainder Theorem, computably. -/
DefinitionDoc Nat.chineseRemainder as "Nat.chineseRemainder"
