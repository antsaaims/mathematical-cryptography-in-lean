import Game.Levels.SecretSharing.L01_ReproducesNodes
import Game.Levels.SecretSharing.L02_PolynomialRing
import Game.Levels.SecretSharing.L03_Uniqueness
import Game.Levels.SecretSharing.L04_TheSecret
import Game.Levels.SecretSharing.L05_Capstone

World "SecretSharing"
Title "Secret Sharing World"

Introduction "
Welcome to **Secret Sharing World**!

## A Different Algebraic Object Entirely

Every previous world (except Matrix Algebra) worked inside `ZMod n` or a
group. This world's object is a **polynomial** — and the protocol it
builds, Shamir's Secret Sharing (Smart Chapter 23), is the first one where
'the algebra' and 'the cryptography' are almost the same sentence: a
secret is hidden as a polynomial's constant term precisely because *not
enough points* leaves a polynomial's other coefficients — including that
one — completely undetermined.

### This World

You will:
1. Prove Lagrange interpolation reproduces its own input data (Action).
2. Confirm your algebra tools transfer to the ring of polynomials (Process).
3. Prove shares uniquely determine the interpolated polynomial — the
   security argument (Object).
4. Name 'the secret' precisely, as evaluation at `0` (Object).
5. Prove Shamir's reconstruction procedure actually recovers the dealer's
   secret: a capstone Schema (Schema).

### Prerequisites

Complete the Number Theory Exam first. This world does not depend on
Public-Key Cryptography World or Matrix Algebra World — play them in any
order.
"
