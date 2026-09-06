# Course Resources

This game's curriculum is built on four freely-available sources. None of the
source PDFs are stored in this repository (see `.gitignore`) — read them at
the links below instead.

## The two core textbooks

The overall progression of topics in this game (classical ciphers → perfect
secrecy → number theory → public-key cryptography → secret sharing → linear
algebra) follows these two books, in whatever parts of each can be given a
machine-checked proof in Lean/Mathlib.

- **Mihir Bellare and Phillip Rogaway, *Introduction to Modern Cryptography*
  (2005).** Free lecture notes, self-hosted by the authors.
  [PDF](https://web.cs.ucdavis.edu/~rogaway/classes/227/spring05/book/main.pdf)
  · Feeds: classical encryption & the one-time pad, computational number
  theory (cyclic groups, generators), RSA, digital signatures, the birthday
  bound.
- **Nigel Smart, *Cryptography: An Introduction* (3rd edition).** Free,
  author-hosted; Smart's own page states "you may make copies and distribute
  the copies of the book as you see fit, as long as it is clearly marked as
  having been authored by N.P. Smart." Distributed in PostScript.
  [Author's page](https://nigelsmart.github.io/Crypto_Book/) ·
  Feeds: modular arithmetic & finite fields, historical ciphers (Caesar,
  substitution, Vigenère), information-theoretic security, RSA/ElGamal,
  discrete logarithms, key exchange & signatures, Shamir secret sharing.

## The two multivariate-cryptography sources

The post-quantum / multivariate-cryptography material (the UOV and MinRank
worlds) is built on these two sources instead — they cover material neither
textbook above includes.

- **Jintai Ding and Albrecht Petzoldt, "Current State of Multivariate
  Cryptography," *IEEE Security & Privacy* 15(4), 2017.**
  [Free copy via ResearchGate](https://www.researchgate.net/publication/319170467_Current_State_of_Multivariate_Cryptography)
  (DOI for citation: [10.1109/MSP.2017.3151328](https://doi.org/10.1109/MSP.2017.3151328))
  · Feeds: the general public-key structure of multivariate schemes, and the
  MinRank/differential attack narrative.
- **Pierre Varjabedian, *Multivariate and Post-Quantum Cryptography*, PhD
  thesis, Université Paris-Saclay, 2026.** Open-access via HAL.
  [PDF](https://theses.hal.science/tel-05639858v1) ·
  Feeds: the quadratic-map-as-matrix bridge, the QR-UOV quotient-ring
  construction, and the Threshold-UOV secret-sharing synthesis capstone.

## What this game does not cover, and why

Both books cover substantially more ground than this game does. Mathlib
(Lean's mathematics library) does not yet formalize DES/AES/Rijndael
internals, concrete hash-function constructions (SHA-1, the Merkle–Damgård
transform), stream-cipher internals (LFSR, RC4, Enigma), elliptic curves,
primality testing and factoring algorithms, discrete-log algorithms,
IND-CPA/CCA security games, zero-knowledge/Sigma-protocols, or secure
multi-party computation — so this game does not include levels on any of
them, formal or otherwise. It also does not state any computational
hardness assumption (e.g. that factoring or discrete log is hard): every
level proves *correctness* of a scheme, never its *security*, which is a
genuinely separate (and, for most of these schemes, unformalized-in-Mathlib)
kind of claim. Where the game states a security-relevant fact without
proving it in Lean — the birthday bound's `2^(n/2)` collision estimate, or
Shamir secret sharing's privacy guarantee for insufficient shares, for
two examples — the level's own text says so explicitly, rather than
presenting narration as if it were formally checked.

If you want the parts of the two books this game leaves out, both are
worth reading end to end — that was always the point of linking them above
rather than only listing the topics this game happens to formalize.
