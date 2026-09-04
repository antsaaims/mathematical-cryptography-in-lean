import Game.Levels.ModularArithmetic.L01_ModularInverse
import Game.Levels.ModularArithmetic.L02_ModularPower
import Game.Levels.ModularArithmetic.L03_ExponentRule
import Game.Levels.ModularArithmetic.L04_Homomorphism
import Game.Levels.ModularArithmetic.L05_Capstone

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
2. Prove the general exponent law `g^(a*b) = (g^a)^b` (Process).
3. Treat exponentiation as a structural object that respects multiplication (Object).
4. Prove the correctness of Diffie–Hellman key exchange itself: a capstone
   Schema combining every previous stage (Schema).

### Prerequisites

Complete the Tutorial World and Classical Ciphers World first — you'll need
`ring`, `decide`, and familiarity with `ZMod`.
"
