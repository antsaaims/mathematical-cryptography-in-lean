import Game.Levels.UOV.L01_LinearMap
import Game.Levels.UOV.L02_Quadratic
import Game.Levels.UOV.L03_Composition
import Game.Levels.UOV.L04_Invertible
import Game.Levels.UOV.L05_PublicKey
import Game.Levels.UOV.L06_Verification
import Game.Levels.UOV.L07_Capstone

World "UOV"
Title "UOV World"

Introduction "
Welcome to the **UOV World**!

## The UOV Signature Scheme

**UOV** (Unbalanced Oil and Vinegar) is a multivariate quadratic signature scheme
proposed by Patarin (1997). It is a leading candidate for post-quantum signatures.

### How UOV Works

1. **Secret Key**: A quadratic map F : F^o x F^v -> F^o
   (the central map) that is easy to invert: given a target y and
   vinegar values v, solve for oil values o.

2. **Public Key**: P = F composed with S where S is a secret
   invertible linear map. P is a system of o quadratic equations
   in n = o + v variables.

3. **Signing**: To sign m, hash to get y = H(m) in F^o. Choose random
   vinegar v, solve F(o, v) = y for o, then output sigma = S^{-1}(o, v).

4. **Verification**: Check P(sigma) = y, i.e., H(m).

The key property is that P = F composed with S implies
P(sigma) = F(S(sigma)).

### This World

You will prove the correctness of UOV step by step, from linear maps through
quadratic forms to the full verification identity.

### Prerequisites

Complete the Tutorial World and Matrix Algebra World first.
"
