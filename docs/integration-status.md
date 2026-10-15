# Combined candidate review

This is bounded integration work for #36 and #41. It is not a merge, announcement,
or author approval. Source SHA-256: `4e70c998e085b8274568265e87dbb4eabe67294f9bdee1be8e11cf626d4665c1`. Record the eventual
Git commit separately; documentation does not hash itself.

## Included repairs and current scope

- #9: explicit coordinate conservation and counterexample, not universal conservation.
- #10: two-index Minkowski action contraction, signs, orthogonality and Eqs. (121)/(123) under explicit rest-frame/nonzero-admittance conditions. Legacy Frobenius names remain compatible. Page15 manuscript prose still requires author correction.
- #11: full fixed-chart covariant tensor Lie derivative, including both index terms; translation/dilation/linear-generator formulas and actual-invariance boost implication. General flow, Noether and nonlinear manifold claims remain absent.
- #25: base-10 modulus and exact tenfold regressions.
- #26: actual finite optical and inverse-speed integrals of the existing exponential ansatz; positive-distance/time/modulus results on explicit domains. This does not resolve #23 horizon or empirical interpretation.
- #27: unscaled Eq. (224) baseline with alpha squared, alpha-fourth hierarchy ratio, separately named scaled algebra.
- #33/#38: prototype scope, physical assumption inventory, API explanations and compiled examples. The historical scope map is retained with its own source identity; this current delta supersedes its rows for sections5/6/7/14/15 and findings10/11/25/26/27/30.
- #34: committed Mathlib revision/inputRev and package naming, locked build instructions.
- #30/#35: actual workflow, whole-owned-declaration transitive proof-hole audit, exact selected dependencies and explicit custom-axiom inventory, negative mutation regressions.
- #40: separate software/manuscript citation metadata and licenses.

The sections and all 22 finding dispositions in the historical map remain the
shared baseline ledger. Except for the explicit repaired findings above, the
unresolved scientific/structural dispositions are unchanged. #29 equation ledger,
#37 module organization and #39 roadmap are separate in-progress candidates and
are not yet included in this snapshot.

## Local validation on 2026-10-15

- `lake build AsymmetricTensor ProofAudit`: passed,3491 jobs; existing module/import warnings only.
- Every `tests/*.lean` file: passed, including API, conservation, base10, force, Lie derivative, Lorentzian action, optical path and audit regressions.
- Whole owned-library audit:360 declarations, six expected explicit axioms, no transitive sorryAx.
- `python3 scripts/test_proof_audit.py`: clean proof accepted; eight negative cases rejected correctly (sorry/admit/imported/private holes, unexpected dependency/inventory, missing target/module).
- Each component also passed independent review and its own focused checks before publication. This combined source still requires independent integration review and hosted CI.

## Inspectable example

`constant_coordinate_conserved` follows from the actual coordinate divergence
of a constant matrix field. It takes an arbitrary real4×4 matrix, no physical
constant or assumed conservation premise. `coordinate_field_not_conserved`
rejects the original linear-coordinate field, so conservation is nonvacuously
restricted rather than asserted for every field. Read the definitions and proof
in the source, then run `lake env lean tests/Conservation.lean`. The checked
axiom set is exactly propext, Classical.choice and Quot.sound.

## Author-owned and publication blockers

#41 cannot be completed until Binyamin supplies an approved revised manuscript
or versioned errata for #42–44 and the remaining false/overbroad claims. The v9
PDF is unchanged and identified as historical. A disclaimer does not fix its
counterexamples. #36's draft can be prepared, but #31's general invitation must
not present this incomplete author reconciliation as ready or be sent without
an approved audience/message. No invitation is sent by this work.
