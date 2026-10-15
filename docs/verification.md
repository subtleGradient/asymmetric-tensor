# Verification contract

The workflow at [`.github/workflows/lean_action_ci.yml`](../.github/workflows/lean_action_ci.yml)
runs on pushes, pull requests, and manual dispatch. It installs the toolchain
from `lean-toolchain`, obtains Mathlib's cache using the committed manifest,
and runs `scripts/verify.sh`. Both GitHub actions are pinned to commit SHAs.
GitHub `.lake` build caching is disabled so first-party source is elaborated
for the candidate. The Mathlib cache is still used.

## Reproduction without upgrading dependencies

Install [elan](https://lean-lang.org/install/) and use Git, Bash, and Python 3.
From a clean checkout:

```sh
lake exe cache get
./scripts/verify.sh
git diff --exit-code -- lean-toolchain lakefile.toml lake-manifest.json
```

Lean is pinned to 4.35.0. Mathlib is pinned in both the package requirement and
manifest to `aa35a481e5f0cdb3b04a899ead15d6ca7305a624`. All transitive packages
use the manifest's recorded revisions. Do not delete the manifest or run
`lake update` during reproduction. `lake update mathlib` belongs on a separate
intentional-upgrade branch after selecting a new `rev`; review and commit the
resulting toolchain and manifest changes together.

`verify.sh` builds the advertised `AsymmetricTensor` target and the separate
`ProofAudit` support library, runs every tests/*.lean regression (including the production
audit), and runs temporary mutation regressions. It verifies that the three lock
and configuration files keep exactly the bytes they had when the script began.
CI additionally requires no changes to those files relative to the checkout.
A missing cache, elaboration error, failed audit, or failed regression is fatal.

## Three distinct proof checks

1. **Build:** Lean elaborates the production definitions and proofs. A successful
   build alone does not exclude admitted proofs or custom axioms.
2. **Completeness and declared-axiom inventory:** `#audit_root AsymmetricTensor`
   examines every declaration owned by the root module and its imported
   `AsymmetricTensor.*` submodules, regardless of declaration namespace. This
   includes private/generated declarations, and covers 360 declarations in this combined candidate.
   Each declaration's transitive axiom set must exclude `sorryAx`. Every axiom
   declared in those modules must be one of exactly the six listed below.
   This is whole-production-module completeness coverage, not a whole-library
   allowlist of imported custom axioms. Modules outside that root are not covered.
3. **Selective transitive axiom audit:** the following eleven theorems have exact
   reviewed custom-axiom sets. All three ordinary Lean logical axioms `propext`,
   `Classical.choice`, and `Quot.sound` are deliberately permitted. Any other
   dependency, including `sorryAx`, `Lean.ofReduceBool`, or an unexpected imported
   custom axiom, fails. Missing theorems and changed custom sets also fail.

All names below are in the `AsymmetricTensor` namespace. `none` means no custom
axioms; ordinary logical axioms still apply.

| Theorem | Exact custom axioms |
|---|---|
| `matrix_decomposition` | none |
| `tensor_decomposition_proven` | `c` |
| `contract_sym_anti_proven` | `c` |
| `unified_action_separation` | `c` |
| `constant_coordinate_conserved` | none |
| `exists_coordinate_conserved` | none |
| `coordinate_field_not_conserved` | none |
| `bernoulli_energy_conservation` | none |
| `navier_stokes_momentum_conservation` | none |
| `geometric_navier_stokes` | `c`, `l_p`, `hbar`, `c_pos`, `l_p_pos`, `hbar_pos` |
| `baryonic_tully_fisher_derivation` | `c`, `l_p`, `hbar`, `c_pos`, `l_p_pos`, `hbar_pos` |

The six physical axioms declare three real constants and their strict positivity.
They are explicit assumptions, not experimentally established facts. The allowed
logical axioms are the standard extensionality, classical choice, and quotient
soundness assumptions. The lists are policy reviewed in source, not learned from
the current output automatically. Review changes to `tests/ProofAudit.lean` along
with changes to theorem statements; an allowlist is not a consistency proof.

`ProofAudit.lean` uses Lean 4.35's `Lean.collectAxioms`, including dependencies
through theorem bodies, definition bodies, types, and imported modules. See
[Lean's proof-validation guide](https://lean-lang.org/doc/reference/latest/ValidatingProofs/).
This is not independent kernel certification or an audit of all Mathlib axioms.

## Conservation dependency

This candidate includes the [#9 conservation repair](conservation.md). The original
`covariant_conservation` axiom is removed and is never allowlisted. The coordinate
witness and nonempty solution-class proofs are checked. The two component
projections require `CoordinateConserved U`; the theorem named
`geometric_navier_stokes` separately assumes its displayed zero-divergence sum.
The action separation is an algebraic identity. These checks establish neither a
covariant connection nor a Bernoulli/Navier–Stokes PDE derivation.

## Target specifications are not completed derivations

No unfinished proof is exempted from completeness checking. Intentional future
research targets are instead conditional statements that take their own target
as a hypothesis. The declarations in the `AsymmetricTensor` namespace and
`FutureWork` section
`alpha_decay_wkb_mapping`, `optimal_transport_minimization`,
`gravitoelectromagnetism_mapping`, `poynting_vector_convection`,
`entanglement_contextuality`, `helicity_orbital_arrest`, `almansi_finite_strain`,
`su3_mass_gap_transition`, `lorentz_force_magnus_mapping`, and
`wake_detachment_stabilization` simply return `h_target`.
These are target specifications, not derivations of the named physical results.
They are not among the eleven headline axiom-audited results. Their proof
completeness does not change that classification. Likewise, opaque field inputs
in Section 5 do not establish equations of motion or regularity.

## Warning policy

Warnings remain visible and nonfatal. In particular, the ten visible
legacy/module-system import warnings and cosmetic/style/unused-variable warnings
are not grounds for rejecting a mathematically complete candidate. CI does not
use a blanket `--wfail` and does not disable or filter warnings. Elaborator errors
are fatal. A `sorry` warning cannot sneak through this policy because the
compiled transitive `sorryAx` check independently fails, even for a private
unreferenced declaration. This separates proof regressions from a module/style
migration; it is not a claim of full Mathlib lint compliance.

## Failure regressions and status

`scripts/test_proof_audit.py` generates temporary fixtures under `.lake`, compiles
imported dependencies, and requires the intended audit error marker and a nonzero
exit. A malformed fixture or missing import does not count as successful rejection.
It checks acceptance of a completed proof and rejection of:

- A direct `sorry` and a direct `admit`.
- An unfinished proof reached through a compiled imported theorem.
- An unreferenced private unfinished proof in a different namespace.
- An unexpected custom axiom reached through a compiled import.
- An unreferenced unexpected first-party axiom.
- A missing theorem and a missing production module.

Temporary mutations and their compiled files are deleted after the run. No
mutation is installed in the production source. During local validation, an
additional private unfinished theorem and an unreferenced custom axiom were
also temporarily inserted into `AsymmetricTensor.lean`: each compiled, then
failed the production audit with its intended diagnostic. Both were removed
and the restored source was rebuilt and rechecked.

Combined-candidate validation on 2026-10-15 passed the production build, every
focused regression, 360-declaration completeness/inventory check, eleven selected
exact theorem axiom checks, and mutation suite. The isolated CI-tooling branch
already passed its [hosted run](https://github.com/subtleGradient/asymmetric-tensor/actions/runs/38782443150).
A real green hosted CI run on this combined candidate is still required; that
earlier branch result is not a combined-candidate CI result. The [Actions page](https://github.com/lilalittle/asymmetric-tensor/actions/workflows/lean_action_ci.yml)
will provide revision-specific results after publication. Neither a green local
run nor a green hosted run validates empirical physics or manuscript coverage.
