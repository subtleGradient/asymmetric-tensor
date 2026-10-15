# Focused Lean feedback invitation (draft, unsent)

**Publication hold:** this is a draft for #36, not permission to send. The final
candidate commit and its hosted CI link must be inserted after verification.
Author-approved manuscript corrections/errata for #41–44 and the intended
recipient audience are still missing. Do not announce this as a ready general
invitation until those blockers are reconciled.

## Draft text

We're developing a Lean 4 research companion to an asymmetric metric-tensor
manuscript. The current prototype checks concrete matrix identities and
fixed-chart differential statements, with physical assumptions made explicit.
One small result worth inspecting: constant real 4×4 matrix fields satisfy the
defined coordinate-divergence constraint, while a linear-coordinate field does
not. Those proofs use only standard Lean logical axioms, without an assumed
universal conservation law.

The code also contains conditional physical models and ten specification targets
that assume their conclusions. A covariant field theory, the physical momentum
PDE, and several manuscript derivations remain unfinished. This is a request for
formalization feedback, not endorsement of the physics.

For the candidate and exact validation evidence, see the pinned source and CI
links in the final integration record. With the committed Lean/Mathlib pins,
run `lake exe cache get` followed by `./scripts/verify.sh`. Start with
`tests/Conservation.lean` and the linked definitions.

We'd especially welcome feedback on the admissible-field API and whether its
coordinate-versus-covariant scope is stated clearly. Contributors can also follow
the small, independent matrix-algebra tasks in `CONTRIBUTING.md`.

## Checklist before sending

- Record the exact candidate Git SHA, source hash and successful hosted CI URL.
- Reconcile the current scope map and all retained claims with actual approved
  manuscript/errata, without treating an “unproved” label as repair of a false claim.
- Rerun the showcase and dependency checks at that exact SHA.
- Replace generic source/CI references in the draft with verified public links.
- Have the user choose/authorize the audience and final message. No external
  announcement is part of this file's creation.
