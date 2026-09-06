import Game.Levels.ModularArithmetic.L01_ModularInverse
import Game.Levels.ModularArithmetic.L02_ModularPower
import Game.Levels.ModularArithmetic.L03_ExponentRule
import Game.Levels.ModularArithmetic.L04_Homomorphism
import Game.Levels.ModularArithmetic.L05_Fermat
import Game.Levels.ModularArithmetic.L06_Euler
import Game.Levels.ModularArithmetic.L07_Capstone

World "ModularArithmetic"
Title "Modular Arithmetic World"

Introduction "
Welcome to the **Modular Arithmetic World**!

## The Ring `ZMod n`

Classical ciphers only ever added shifts. Modern public-key cryptography —
**Diffie–Hellman key exchange** and **RSA** — is built on multiplication and
exponentiation inside `ZMod n`, the ring of integers modulo `n`.

### This World

You will:
1. Compute concrete modular inverses and powers by hand (Action).
2. Prove the general exponent law `g^(a*b) = (g^a)^b` and the
   exponentiation-respects-multiplication law behind RSA's malleability
   (Process).
3. Reach for two genuinely deep number-theoretic theorems — Fermat's Little
   Theorem and its generalization, Euler's Theorem — as black-box tools
   rather than things you'd reprove yourself (Object).
4. Prove the correctness of Diffie–Hellman key exchange itself, from the
   exponent law in step 2 (Schema) — Fermat and Euler's theorems are this
   world's payoff for a *later* world, Public-Key Cryptography, rather than
   for this capstone specifically.

### Prerequisites

Complete Perfect Secrecy World and the Foundations Exam first — you'll need
`ring`, `decide`, and familiarity with `ZMod`.
"
