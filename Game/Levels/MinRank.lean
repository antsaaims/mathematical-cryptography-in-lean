import Game.Levels.MinRank.L01_LinearCombination
import Game.Levels.MinRank.L02_DetZero
import Game.Levels.MinRank.L03_RankBound
import Game.Levels.MinRank.L04_Minor
import Game.Levels.MinRank.L05_SupportMinors
import Game.Levels.MinRank.L06_LinearDependence
import Game.Levels.MinRank.L07_Capstone

World "MinRank"
Title "MinRank World"

Introduction "
Welcome to the **MinRank World**!

## The MinRank Problem

The **MinRank problem** is a fundamental computational problem in algebraic
cryptography:

Given matrices M_1, ..., M_k in F^(m x n) and a target rank r,
find scalars lambda_1, ..., lambda_k in F (not all zero) such that:
    rank(Sum lambda_i M_i) <= r

### Cryptographic Significance

MinRank is the basis of attacks on:
- **HFE** (Hidden Field Equations) — Kipnis-Patarin (1999)
- **UOV** — via the rank of the quadratic form's matrix
- **Post-quantum NIST candidates** — e.g., GeMSS

### This World

You will formalize:
1. Linear combinations of matrices.
2. Conditions for zero determinant (singularity).
3. Rank bounds via minors.
4. The Support-Minors model (a generalization).
5. A capstone proving the key algebraic identity.

### Prerequisites

Complete Matrix Algebra World first (which itself needs the Number Theory
Exam, and transitively everything before it).
"
