import Game.Levels.PublicKeyCrypto.L01_KeyPair
import Game.Levels.PublicKeyCrypto.L02_ModEqToolkit
import Game.Levels.PublicKeyCrypto.L03_ExponentSplit
import Game.Levels.PublicKeyCrypto.L04_ElGamal
import Game.Levels.PublicKeyCrypto.L05_Capstone

World "PublicKeyCrypto"
Title "Public-Key Cryptography World"

Introduction "
Welcome to **Public-Key Cryptography World**!

## Where Modular Arithmetic Was Always Headed

Every tool from Modular Arithmetic World and Groups and Orders World was
building toward this: proving that real public-key schemes — RSA and
ElGamal — are actually correct, following Bellare–Rogaway Chapters 10–11
and Smart Chapters 11 and 14.

### This World

You will:
1. Check a genuine (if tiny) RSA key pair by hand (Action).
2. Build a small toolkit for carrying congruences through powers and
   products (Process).
3. Isolate the exponent-splitting algebra RSA's correctness proof needs,
   and recognize the Diffie–Hellman identity wearing ElGamal's variable
   names (Object).
4. Prove RSA's decryption really does recover the original message: a
   capstone Schema combining Euler's Theorem with everything else in this
   world (Schema).

### Prerequisites

Complete the Number Theory Exam first.
"
