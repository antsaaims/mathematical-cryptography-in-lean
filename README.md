# Mathematical Cryptography in Lean

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/antsaaims/mathematical-cryptography-in-lean)

Learn to write machine-checked proofs *and* a full semester of mathematical cryptography at the same time — no prior experience with either required. Play through guided, bite-sized levels that take you from your very first Lean tactic through classical ciphers, perfect secrecy, number theory, RSA and ElGamal, Shamir secret sharing, and matrix algebra, up to proving the correctness of a real post-quantum signature scheme (UOV) and formalizing the MinRank attack that targets schemes like it.

Built with [lean4game](https://github.com/leanprover-community/lean4game/), the same engine behind the [Natural Number Game](https://adam.math.hhu.de/).

## How to Play

1. Launch a Codespace by clicking the badge above, or go to the repo green Code button, then Codespaces, then Create codespace on main.
2. Wait for setup. The container automatically installs Lean 4, Mathlib, and the lean4game server. This takes about 5 to 10 minutes on first launch. Subsequent launches are faster due to caching.
3. Open the game. Once setup finishes, a browser tab opens automatically at the forwarded port. If it does not, look in the Ports tab in VS Code and click the globe icon next to port 3000.
4. Start proving. The course is organized into five modules, each ending in a short cumulative "Exam" world:
   - **Module 1:** Tutorial → Classical Ciphers → Perfect Secrecy → Foundations Exam
   - **Module 2:** Modular Arithmetic → Groups and Orders → Number Theory Exam
   - **Modules 3–5** (independent — play in any order): Public-Key Cryptography → Public-Key Exam · Secret Sharing → Secret Sharing Exam · Matrix Algebra → {UOV, MinRank}
   - Everything converges at the **Final Exam**, once Public-Key Exam, UOV, and MinRank are all complete.

   See [Game.lean](Game.lean) for the exact world list and dependency graph, and [docs/pedagogy.md](docs/pedagogy.md) for how each world's tools get reused and re-tested by later ones.

## How It Works

| Component | Port | Description |
|-----------|------|-------------|
| Game Client | 3000 | Vite-served frontend, auto-opens in browser |
| Relay Server | 8080 | Backend relay connecting client to Lean server |

## For Developers

### Project Structure

- Game.lean - Game entry point, world list, and dependency graph
- Game/Levels/ - Individual levels, one folder per world (15 worlds — see Game.lean for the full list)
- Game/Doc/ - Centralized `TacticDoc`/`DefinitionDoc`/`TheoremDoc` inventory entries
- docs/pedagogy.md - The active-retrieval / spaced-practice design map: which level teaches a tool, which later level re-tests it, and which exam interleaves it
- .devcontainer/ - Codespace configuration (Dockerfile, setup scripts, server launcher)
- lakefile.lean - Lean package configuration with Mathlib dependency

### Running Locally (without Codespaces)

Prerequisites: Node.js 22+, elan, and lake.

    # Install dependencies and build the game
    lake build

    # Clone and build lean4game. Use `main`, not the tag matching lean-toolchain -
    # older tags predate a fix for npm install failing with "402 Payment Required"
    # from the now-defunct gitpkg.vercel.app service (leanprover-community/lean4game#416).
    cd ..
    git clone --branch main https://github.com/leanprover-community/lean4game.git
    cd lean4game
    npm install
    npm run build

    # Start the server
    cd ../mathematical-cryptography-in-lean
    export VITE_LEAN4GAME_SINGLE=true
    export VITE_LEAN4GAME_SINGLE_NAME=mathematical-cryptography-in-lean
    npm start --prefix ../lean4game

Then open http://localhost:3000 in your browser.

### Adding New Levels

See the [lean4game documentation](https://github.com/leanprover-community/lean4game/blob/main/doc/create_game.md) for how to create new worlds and levels.

## Course Resources

This game's curriculum follows two free cryptography textbooks plus two
sources on multivariate/post-quantum cryptography. See
[RESOURCES.md](RESOURCES.md) for links, license notes, and which world each
one feeds — none of the source PDFs are stored in this repository.

## Documentation

- [Creating a new game](https://github.com/leanprover-community/lean4game/blob/main/doc/create_game.md)
- [Updating an existing game](https://github.com/leanprover-community/lean4game/blob/main/doc/update_game.md)
- [Running a game locally](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md)
