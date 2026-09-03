import Game.Levels.Tutorial.L01_Rewrite
import Game.Levels.Tutorial.L02_Exact
import Game.Levels.Tutorial.L03_Apply
import Game.Levels.Tutorial.L04_Simp
import Game.Levels.Tutorial.L05_Ring
import Game.Levels.Tutorial.L06_Capstone

World "Tutorial"
Title "Tutorial World"

Introduction "
Welcome to the **Tutorial World**! This world assumes you have never used Lean 4 before.

We will cover the most fundamental tactics you need for every proof:
- `rw` (rewrite): substitute a hypothesis or known identity into your goal.
- `exact`: provide a term that precisely matches the goal.
- `apply`: reduce a goal to a simpler sub-goal.
- `simp`: automatic simplification.
- `ring`: automatic polynomial identity proving.

These five tactics form the backbone of every Lean proof you will write in the
cryptography worlds ahead.
"
