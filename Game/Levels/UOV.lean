import Game.Levels.UOV.L01_QuadraticFromMatrix
import Game.Levels.UOV.L02_LinearMap
import Game.Levels.UOV.L03_Quadratic
import Game.Levels.UOV.L04_Composition
import Game.Levels.UOV.L05_Invertible
import Game.Levels.UOV.L06_PublicKey
import Game.Levels.UOV.L07_Verification2
import Game.Levels.UOV.L08_Verification
import Game.Levels.UOV.L09_QRUOV
import Game.Levels.UOV.L10_InvertibleProportion
import Game.Levels.UOV.L11_Capstone

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

You will prove the correctness of UOV step by step, starting from what
'quadratic' actually means (as opposed to linear), through linear maps,
composition, and invertibility, to the full verification identity — then
go further than a first course usually does: a 2026 NIST-competition
variant (QR-UOV), an invertibility fact real threshold protocols depend on,
and a capstone connecting this world back to Secret Sharing World's
mathematics.

### Prerequisites

Complete both Matrix Algebra World and the Secret Sharing Exam first — the
engine that runs this game unlocks a whole world at a time, and this
world's final capstone (Level 11) needs Secret Sharing World's Lagrange
interpolation, so the whole world waits on it, not just that one level.
Secret Sharing itself is an independent track: play it before Matrix
Algebra, after, or interleaved — it doesn't matter, as long as both are
done before you start here.
"
