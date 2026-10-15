# asymmetric-tensor

Lean 4 research companion to **The Asymmetric Metric-Tensor and the
Thermodynamic Equation of State**, by Binyamin Tsadik Bair-Mosheh.

The repository contains a concrete real 4×4 matrix model, symmetric/antisymmetric
splitting lemmas, scalar algebra, and conditional statements motivated by the
manuscript. Its section headings follow topics 1–16 of the paper; they do **not**
mean those sections have been fully formalized. Several geometric objects and
physical derivations are absent, and ten specification targets simply return
their assumed conclusions.

**Included conservation repair:** this candidate includes the [#9 repair](docs/conservation.md)
from [fork commit `78ee76bf`](https://github.com/subtleGradient/asymmetric-tensor/commit/78ee76bf2dbf2412b5f35a51e38e3695c014a6f9) as an explicit
dependency. It replaces the baseline's contradictory universal conservation
axiom with an explicit `CoordinateConserved` premise, proves constant-field
witnesses, and excludes the original linear-coordinate counterexample. Inclusion
here does not mean it has merged upstream. A general covariant connection and
physical momentum-PDE derivation remain open.

## What is implemented?

Start with the [current integration status](docs/integration-status.md), then the
[versioned historical scope map](docs/formalization-status.md):

- [Section-by-section coverage, objects, and assumptions](docs/formalization-status.md#section-by-section-status)
- [Custom assumptions and unspecified model symbols](docs/formalization-status.md#assumptions-and-unspecified-symbols)
- [All ten assumed targets](docs/formalization-status.md#the-ten-exact-h_target-cases)
- [Disposition and evidence for the 22 reviewed findings](docs/formalization-status.md#review-findings-and-dispositions)

Useful first examples in [AsymmetricTensor.lean](AsymmetricTensor.lean) are
`matrix_decomposition` (matrix algebra), `U_hat` (the component model), and
`baryonic_tully_fisher_derivation` (an implication with an essential plateau
hypothesis). The [entry-point guide](docs/formalization-status.md#where-to-start)
explains what to look for and what each example leaves open.

## Building

Requires Git and [elan](https://lean-lang.org/install/), with `lake` on your
`PATH`. Run the following from a new project directory:

```sh
git clone https://github.com/lilalittle/asymmetric-tensor.git
cd asymmetric-tensor
lake exe cache get       # fetch the prebuilt Mathlib dependencies
lake build AsymmetricTensor
git diff --exit-code -- lean-toolchain lakefile.toml lake-manifest.json
```

Elan selects Lean 4.35.0 from `lean-toolchain`, installing it if needed.
`lake-manifest.json` records the exact dependency commits; `lakefile.toml`
also pins Mathlib to `aa35a481e5f0cdb3b04a899ead15d6ca7305a624`.
Lake fetches missing dependencies at those recorded revisions. The cache
command avoids compiling Mathlib from source; let it finish successfully
before building the `AsymmetricTensor` library. The final command should
produce no diff and exit successfully: normal setup must not change the
committed toolchain or dependency selection.

Do not run `lake update` for normal reproduction. It is an upgrade operation
that can rewrite the manifest and toolchain. Keep the committed manifest
rather than deleting or regenerating it to troubleshoot a cache download.

### Intentional dependency upgrades

In a separate branch, choose the desired Mathlib commit and change its `rev`
in `lakefile.toml`. Then run:

```sh
lake update mathlib
lake exe cache get
lake build AsymmetricTensor
git diff -- lean-toolchain lakefile.toml lake-manifest.json
```

`lake update mathlib` resolves the selected revision and its dependencies,
and may update `lean-toolchain` to match. Review every dependency/toolchain
change and resolve any build failures before committing the new selection.
For the update behavior, see the
[Lake manual](https://lean-lang.org/doc/reference/latest/Build-Tools-and-Distribution/Lake/).

## Verification and scope

Run `./scripts/verify.sh` after cache retrieval. It builds the library and audit,
checks every focused regression file, rejects transitive proof holes in owned
declarations, checks the explicit axiom inventory and selected exact dependency
sets, and exercises negative mutation tests. The actual
[workflow](.github/workflows/lean_action_ci.yml) runs these checks without changing
pins. See [verification details](docs/verification.md).

The combined candidate passed local build, all tests, and audit/mutation checks.
Hosted CI for this combined revision is still pending publication; the separate
CI-tooling branch passed [its own run](https://github.com/subtleGradient/asymmetric-tensor/actions/runs/38782443150).
The [integration record](docs/integration-status.md) identifies the source hash
and precisely distinguishes each result. No combined-CI success is claimed yet.

Lean checks formal statements relative to hypotheses and axioms. Six physical
constant/positivity axioms and nine opaque field symbols remain. Ten exact-target
specifications assume their conclusions. The repaired formalization is not an
empirical validation of the paper, a full covariant PDE theory, or a proof of the
remaining scientific claims.

## License

The Lean software is licensed under **Apache-2.0** — see [`LICENSE`](LICENSE).
The published manuscripts in `papers/` are licensed under **CC-BY-4.0** — see
[`papers/LICENSE`](papers/LICENSE). Copyright 2026 Binyamin Tsadik Bair-Mosheh.
These are separate licenses for separate artifacts; the manuscript's license
does not replace the software license.

## Citation

`CITATION.cff` describes the **Lean software** at the top level, with its repository
URL and Apache-2.0 license. Its `preferred-citation` describes the **manuscript**:
the DOI, v9 version, September 25, 2026 date, and CC-BY-4.0 license in that section
belong to the paper. The manuscript metadata and abstract retain the provenance
of the original Zenodo citation export, available in this repository's git history.

To cite the manuscript currently included in this checkout:

> Binyamin Tsadik Bair-Mosheh (2026). *Formalization of the Asymmetric Metric-Tensor
> and the Thermodynamic Equation of State* (v9). Zenodo.
> https://doi.org/10.5281/zenodo.22953897

If you use or discuss the Lean implementation, also cite the software revision:

> Binyamin Tsadik Bair-Mosheh. *asymmetric-tensor: Lean 4 companion to the Asymmetric
> Metric-Tensor manuscript* [Software]. https://github.com/lilalittle/asymmetric-tensor,
> commit FULL_COMMIT_SHA.

Replace `FULL_COMMIT_SHA` with the full output of `git rev-parse HEAD` in the
checkout you used, and link to
`https://github.com/lilalittle/asymmetric-tensor/tree/FULL_COMMIT_SHA` with that same
SHA. Describe any uncommitted changes separately. If you use a different paper
version, cite its version-specific DOI from the table below. A paper version and a
software revision need not match.

No software DOI or archived software release is claimed here. The manuscript DOI
identifies the paper; it is not evidence that a particular software revision was
archived.

## Published versions

The author's published manuscripts (Zenodo, CC-BY-4.0). The included v9 is the unchanged historical manuscript reviewed here, with known correction requests; no author-approved replacement or errata has been supplied. The latest version is always at `papers/asymmetric-metric-tensor.pdf`; each published version replaced the previous one, so older versions are recoverable from this repo's git history:

| Version | Published | Zenodo record |
|---|---|---|
| v0 | 2026-07-12 | [zenodo.21321265](https://doi.org/10.5281/zenodo.21321265) |
| v1 | 2026-07-13 | [zenodo.21339079](https://doi.org/10.5281/zenodo.21339079) |
| v2 | 2026-07-20 | [zenodo.21455277](https://doi.org/10.5281/zenodo.21455277) |
| v3 | 2026-07-23 | [zenodo.21505034](https://doi.org/10.5281/zenodo.21505034) |
| v4 | 2026-08-03 | [zenodo.21780517](https://doi.org/10.5281/zenodo.21780517) |
| v5 | 2026-08-31 | [zenodo.22212278](https://doi.org/10.5281/zenodo.22212278) |
| v6 | 2026-09-09 | [zenodo.22675546](https://doi.org/10.5281/zenodo.22675546) |
| v7 | 2026-09-17 | [zenodo.22813082](https://doi.org/10.5281/zenodo.22813082) |
| v8 | 2026-09-19 | [zenodo.22847830](https://doi.org/10.5281/zenodo.22847830) |
| v9 | 2026-09-25 | [zenodo.22953897](https://doi.org/10.5281/zenodo.22953897) |

All versions live at the concept DOI: https://doi.org/10.5281/zenodo.21321264

Copyright Binyamin Tsadik Bair-Mosheh — [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).
