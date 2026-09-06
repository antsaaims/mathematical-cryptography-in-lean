import Game.Levels.GroupsAndOrders.L01_OrderOfIdentity
import Game.Levels.GroupsAndOrders.L02_OrderDefiningProperty
import Game.Levels.GroupsAndOrders.L03_OrderDividesCard
import Game.Levels.GroupsAndOrders.L04_ChineseRemainder
import Game.Levels.GroupsAndOrders.L05_Capstone

World "GroupsAndOrders"
Title "Groups and Orders World"

Introduction "
Welcome to **Groups and Orders World**!

## The Vocabulary Research Papers Assume

Modular Arithmetic World treated `ZMod n` as a ring you compute in. This
world treats it (and groups in general) as an object of study in its own
right — the vocabulary of orders, generators, and the Chinese Remainder
Theorem that Bellare–Rogaway Chapter 9 and Smart Chapter 1 build on, and
that every research paper in this area assumes you already have.

### This World

You will:
1. Prove the simplest possible fact about element order (Action).
2. Prove order's defining property holds for every element (Process).
3. Reach for a genuinely deep structural theorem — order divides group
   size — and the Chinese Remainder Theorem, both as black-box tools
   (Object).
4. Prove the exact 'generator' setup Diffie–Hellman and ElGamal publish as
   their shared public parameters (Schema).

### Prerequisites

Complete Modular Arithmetic World first.
"
