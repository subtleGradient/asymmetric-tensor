# Contributing

## Reproduce, then make one focused change

Use the single setup recipe in [README → Building](README.md#building).
Keep the committed Lean toolchain and dependency manifest; do not update them as
part of an unrelated proof change. Read the issue and existing PRs before
starting, so an already-covered repair is not duplicated.

The public library is currently the umbrella file `AsymmetricTensor.lean`.
Declarations live in namespace `AsymmetricTensor`. Section comments follow the
manuscript's topic order, not a claim that each physical theory is formalized.
No module split or generated API site is assumed by these instructions.

## A checked path through the reusable API

1. `V4` is a four-component real vector and `T2` a 4×4 real matrix.
2. `symPart U` and `antiPart U` split an arbitrary `T2` by transposition.
3. `matrix_decomposition U` proves their sum is `U`, by ring algebra.
4. `asBilinear U` turns the matrix into a bilinear form in the fixed basis.
5. `raiseBoth gInv A` and `contract2 gInv U V` explicitly accept the matrix used
   for raising indices. They do not prove it is the correct inverse metric.

Read the `/-- ... -/` declaration docstrings in the Lean editor for exact input,
output, and scope contracts. The small worked example in
[`tests/ApiExamples.lean`](tests/ApiExamples.lean) starts from a nonsymmetric
matrix with one nonzero entry, computes both projections, and applies the
checked decomposition theorem. It also demonstrates a constant field satisfying
the explicitly assumed coordinate-conservation predicate.

Run these real commands from the repository root:

```sh
lake build
lake env lean tests/ApiExamples.lean
lake env lean tests/Conservation.lean
./scripts/verify.sh
git diff --check
```

The example and conservation files print transitive axiom dependencies for the
named results. Inspect those lists for unintended custom assumptions or
`sorryAx`. They are focused reports, not a whole-library enforced allowlist.
The default library build does not run files under `tests/`; run them explicitly.

## Mathematical and scientific scope

Do not replace a missing proof with an axiom or a hypothesis that simply states
the desired conclusion, then call the derivation complete. Conditional algebra
can be useful, but identify the conditions and actual objects it proves.

`tensor_contract` is a Frobenius pairing; `contract2` raises indices with an
explicit supplied matrix. `VolAvg` is currently symmetrization, not an integral.
The field model uses a fixed ℝ⁴ chart and partial divergence, not a general
connection. Lean's totalized division at zero is not a limiting physical theorem.
See [the conservation repair](docs/conservation.md) for a concrete example of
separating an admissible-field premise from an invalid universal axiom.

Manuscript corrections and intended physical-model decisions belong to the
author. A Lean build checks statements under their dependencies; it does not
empirically validate the manuscript. Preserve attribution and distinguish the
software license from manuscript licensing.

## Small independent starter contributions

Check open PRs first, then propose a bounded patch such as:

- Prove the transpose laws for `symPart` and `antiPart` for arbitrary `T2`;
  complete when focused Lean examples compile without new axioms or unfinished
  proofs and the contracts state no physical assumptions.
- Prove `symPart (symPart U) = symPart U` and
  `antiPart (antiPart U) = antiPart U`; include a nonsymmetric concrete regression.
- Add a declaration docstring and a focused checked example for one unannotated
  algebraic lemma. Explain every nonzero/positivity premise, and distinguish its
  actual conclusion from a physically suggestive name.

For a PR, name the issue, explain mathematical/API changes and assumptions, list
commands actually run and their results, and disclose untested or author-dependent
parts. Keep intentional toolchain upgrades separate. Do not claim that an
unchanged PDF or an unexecuted test has been verified.
