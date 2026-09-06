import GameServer.Commands

/-! Central documentation for every tactic unlocked in this game.
Kept in one place (rather than scattered across level files) so the
inventory panel's popup text stays easy to find and maintain. -/

/-- `rw [h]` rewrites the goal using an equation `h : a = b`, replacing every
occurrence of `a` with `b`. Use `rw [← h]` to rewrite right-to-left instead. -/
TacticDoc rw

/-- `exact e` closes the goal by supplying a term `e` whose type matches the
goal exactly. Use it when you already have (or can write down) a complete
proof term. -/
TacticDoc exact

/-- `apply f` works backwards: given `f : A → B` and a goal `B`, it reduces
the goal to `A`. Useful when you know the last step of a proof but not yet
the steps before it. -/
TacticDoc apply

/-- `simp` automatically simplifies the goal using a large library of proven
identities (marked `@[simp]`), and closes the goal outright when the result
is `True` or a syntactic reflexivity. `simp [h]` also uses `h` as a
rewrite rule. -/
TacticDoc simp

/-- `ring` proves equalities that hold in any commutative (semi)ring purely
by algebraic rearrangement — no need to name every intermediate step. -/
TacticDoc ring

/-- `decide` closes a goal by direct computation, when the statement is
decidable and every value involved is concrete and finite (e.g. arithmetic
in `ZMod n` or `Fin n`). -/
TacticDoc decide

/-- `unfold f` replaces `f` with its definition wherever it appears in the
goal, turning a named abbreviation back into the underlying expression. -/
TacticDoc unfold

/-- `funext i` turns a goal `f = g` between two functions into a goal
`f i = g i` about an arbitrary input `i` — two functions are equal exactly
when they agree everywhere. -/
TacticDoc funext

/-- `have h : P := proof` introduces a new fact `h : P` into the context,
proved separately, that later tactics can then use — a named intermediate
step inside a larger proof. -/
TacticDoc «have»
