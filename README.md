# Mathematical Cryptography in Lean

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/antsaaims/mathematical-cryptography-in-lean)

An interactive Lean 4 game that teaches mathematical cryptography concepts through guided proofs: matrix algebra, the UOV signature scheme, and minimum-rank problems.

Built with [lean4game](https://github.com/leanprover-community/lean4game/).

## How to Play

1. Launch a Codespace by clicking the badge above, or go to the repo green Code button, then Codespaces, then Create codespace on main.
2. Wait for setup. The container automatically installs Lean 4, Mathlib, and the lean4game server. This takes about 5 to 10 minutes on first launch. Subsequent launches are faster due to caching.
3. Open the game. Once setup finishes, a browser tab opens automatically at the forwarded port. If it does not, look in the Ports tab in VS Code and click the globe icon next to port 3000.
4. Start proving. Work through the worlds: Tutorial, Matrix Algebra, UOV, then MinRank. Each world introduces tactics and definitions, then tests them in a capstone level.

## How It Works

| Component | Port | Description |
|-----------|------|-------------|
| Game Client | 3000 | Vite-served frontend, auto-opens in browser |
| Relay Server | 8080 | Backend relay connecting client to Lean server |

## For Developers

### Project Structure

- Game.lean - Game entry point and world definitions
- Game/Levels/ - Individual levels organized by world (Tutorial, MatrixAlgebra, UOV, MinRank)
- .devcontainer/ - Codespace configuration (Dockerfile, setup scripts, server launcher)
- lakefile.lean - Lean package configuration with Mathlib dependency

### Running Locally (without Codespaces)

Prerequisites: Node.js 22+, elan, and lake.

    # Install dependencies and build the game
    lake build

    # Clone and build lean4game
    cd ..
    git clone https://github.com/leanprover-community/lean4game.git
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

## Documentation

- [Creating a new game](https://github.com/leanprover-community/lean4game/blob/main/doc/create_game.md)
- [Updating an existing game](https://github.com/leanprover-community/lean4game/blob/main/doc/update_game.md)
- [Running a game locally](https://github.com/leanprover-community/lean4game/blob/main/doc/running_locally.md)
