import Game.Levels.PerfectSecrecy.L01_XorSelfInverse
import Game.Levels.PerfectSecrecy.L02_OneTimePad
import Game.Levels.PerfectSecrecy.L03_UniqueKey
import Game.Levels.PerfectSecrecy.L04_Collisions
import Game.Levels.PerfectSecrecy.L05_Capstone

World "PerfectSecrecy"
Title "Perfect Secrecy World"

Introduction "
Welcome to **Perfect Secrecy World**!

## Security You Can Actually Prove

Classical Ciphers World showed that Caesar, substitution, and Vigenère are
all invertible — but none of them are *secure*, because invertibility alone
was never the missing ingredient. This world formalizes what real,
information-theoretic security looks like, following Bellare–Rogaway §2.2
and Smart Chapter 5: the **one-time pad**, working over the smallest
nontrivial ring, `ZMod 2` (bits, with addition as XOR).

### This World

You will:
1. Prove the one algebraic fact — a bit cancels with itself — that this
   entire world runs on (Action).
2. Lift that fact from a single bit to a whole message (Process).
3. Prove the key producing any given (message, ciphertext) pair is
   *unique* — the combinatorial heart of Shannon's perfect secrecy theorem
   (Object).
4. Prove a related information-theoretic foundation: why collisions in a
   hash function are unavoidable by counting alone (Object).
5. Prove the flip side of Level 1's fact: exactly how key reuse destroys
   everything Levels 2–3 established (Schema).

### Prerequisites

Complete Tutorial World and Classical Ciphers World first.
"
