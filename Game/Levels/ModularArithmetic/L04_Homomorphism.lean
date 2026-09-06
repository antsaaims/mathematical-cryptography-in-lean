import Game.Metadata
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.Group.Defs
import Mathlib.Tactic.Common

World "ModularArithmetic"
Level 4

Title "Exponentiation as a Structural Object"

Introduction
"
## 'Raise to the e-th Power' as a Single Object

In the last level, exponentiation was something you performed on individual
elements. Now step back and treat 'raise everything to the power `e`' as an
**object** in its own right: a function on `ZMod n` with its own structural
property — it turns products into products:

    (m1 * m2) ^ e = m1 ^ e * m2 ^ e

This is exactly the algebraic fact behind RSA's well-known **multiplicative
homomorphic property**: encrypting a product of two messages gives the same
result as multiplying their individual encryptions.

### Your Task

Prove this distributive law for arbitrary `m1 m2 : ZMod n` and `e : ℕ`.

### Strategy

Another one-and-for-all Mathlib fact for commutative monoids: `mul_pow`.
"

Statement {n : ℕ} (m1 m2 : ZMod n) (e : ℕ) :
    (m1 * m2) ^ e = m1 ^ e * m2 ^ e := by
  Hint "This is the Mathlib lemma `mul_pow`. Type: exact mul_pow m1 m2 e"
  exact mul_pow m1 m2 e

Conclusion
"
This structural property — that exponentiation respects multiplication — is
exactly why textbook RSA is *malleable*: an attacker who can manipulate
ciphertexts multiplicatively can manipulate the underlying plaintexts too.
Real systems add padding schemes specifically to break this property.

**APOS stage:** Object — treating 'raise to the e-th power' as a single
structural map, not just a computation to repeat.
"
