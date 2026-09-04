import Game.Levels.ClassicalCiphers.L01_CaesarEncrypt
import Game.Levels.ClassicalCiphers.L02_CaesarDecrypt
import Game.Levels.ClassicalCiphers.L03_RoundTrip
import Game.Levels.ClassicalCiphers.L04_ShiftComposition
import Game.Levels.ClassicalCiphers.L05_Capstone

World "ClassicalCiphers"
Title "Classical Ciphers World"

Introduction "
Welcome to the **Classical Ciphers World**!

## From Letters to Numbers

Before we can reason about modern cryptography, we need a language for
'letters' that Lean already understands: arithmetic modulo 26, written
`ZMod 26`. Classical ciphers like the **Caesar cipher** and **Vigenère
cipher** are, underneath the historical dressing, nothing more than addition
and subtraction in this modular world.

### This World

You will:
1. Encrypt and decrypt concrete letters by hand (Action).
2. Prove the general encrypt-decrypt law holds for every message and key (Process).
3. Treat a 'shift' as an algebraic object you can combine and commute (Object).
4. Prove the Caesar cipher is a genuine bijection: a capstone Schema tying
   actions, processes, and objects together (Schema).

This mirrors Dubinsky's **APOS** framework: by the end of this world you will
have moved from mechanically shifting individual letters to understanding
'a cipher' as a single coherent mathematical object.

### Prerequisites

Complete the Tutorial World first — you'll need `ring` and basic proof
structure.
"
