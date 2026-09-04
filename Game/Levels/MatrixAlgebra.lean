import Game.Levels.MatrixAlgebra.L01_MatrixMul
import Game.Levels.MatrixAlgebra.L02_Det
import Game.Levels.MatrixAlgebra.L03_Rank
import Game.Levels.MatrixAlgebra.L04_Transpose
import Game.Levels.MatrixAlgebra.L05_Submatrix
import Game.Levels.MatrixAlgebra.L06_Capstone

World "MatrixAlgebra"
Title "Matrix Algebra World"

Introduction "
Welcome to **Matrix Algebra World**!

In multivariate and algebraic cryptography, matrices over finite fields are everywhere:

- **UOV**: The public key is derived from a structured system of quadratic polynomials,
  which can be represented using matrices.
- **MinRank**: The problem of finding a low-rank linear combination of given matrices.
- **Support-Minor**: Extends MinRank using minors (determinants of submatrices).

This world teaches you how to work with matrices in Mathlib: multiplication, determinants,
transpose, rank, and submatrices. We follow the APOS pedagogical framework.

Matrices over a field are a genuinely richer algebraic object than the commutative
ring `ZMod n` you worked with in Modular Arithmetic World: matrix multiplication is
*not* commutative in general, which is exactly the extra structure UOV and MinRank
exploit as a cryptographic trapdoor.

### Prerequisites

Complete the Tutorial, Classical Ciphers, and Modular Arithmetic Worlds first.
"
