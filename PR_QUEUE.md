# Pull request queue

Pass state: **ACTIVE**. The publisher stops once this is **COMPLETE** and every ready entry is published or has a recorded blocker.

Updated: 2026-10-15 UTC. Target repository: lilalittle/asymmetric-tensor.
This branch is a coordination record, not a proposed change to upstream.
Do not merge or open a PR for this queue branch.

## Handoff rules

- Open only entries marked **READY**, unless explicitly instructed otherwise.
- Check upstream open, closed, and merged PRs before creating a PR to avoid duplicates.
- Preserve the exact issue-specific source branch and target `main`.
- Copy the full proposed title/body below. Opening a PR does not authorize merging.
- **IN PROGRESS** entries are not yet validated or ready for publication.
- This queue distinguishes actual open PRs from prepared changes. A prepared branch is not an open PR.

## Already open: #40 citation metadata

Status: **ALREADY OPEN**, do not create another PR.
PR: https://github.com/lilalittle/asymmetric-tensor/pull/45
Issue: https://github.com/lilalittle/asymmetric-tensor/issues/40
Source repository: subtleGradient/asymmetric-tensor
Source branch: `dot/clarify-citation-metadata`
Verified head: `a5553ea5f9325ab310588dd673d7d34ab211710c`
Target: `lilalittle/asymmetric-tensor:main`
Target baseline: `9f69988d17c9fb86f35a563eb6466be9dbf4e524`
Dependencies: none.
Proposed title: Clarify software and manuscript citation metadata

PR #45 was created manually and currently has an empty description. Suggested full description:

### Summary
- Identify the root citation as Apache-2.0 Lean software and its repository.
- Preserve manuscript authorship, title, abstract, DOI, date and provenance in a separate preferred citation with the CC-BY-4.0 license.
- Document citing the manuscript and exact software commit independently, without inventing a software DOI or archived release.

Fixes #40.

### Validation
- 28 local semantic/provenance checks passed, including duplicate-key-aware YAML parsing, unchanged manuscript/source/license hashes, and git diff --check.
- Independent review passed.
- Official Citation File Format 1.2.0 JSON Schema validation passed, including format checks.
- Metadata/documentation only; no Lean source changes, so no Lean build was run for this PR.
- GitHub reports zero check runs and zero commit statuses. No CI pass is claimed.

The original manuscript abstract remains manuscript metadata. This change does not claim to repair the separate scientific-scope issues.

## In-progress changes: do not open yet

| Issue | Proposed branch | Status and remaining validation |
| --- | --- | --- |
| [#9](https://github.com/lilalittle/asymmetric-tensor/issues/9) conservation | `dot/repair-conservation` | Local patch and regression proofs prepared; independent static review passed; Lean kernel checks pending. Branch not yet published. |
| [#25](https://github.com/lilalittle/asymmetric-tensor/issues/25) base-10 modulus | `dot/fix-distance-modulus-base10` | Local patch and regression proofs prepared; independent static review passed; Lean kernel checks pending. Remote branch currently only contains baseline, not the fix. |
| [#27](https://github.com/lilalittle/asymmetric-tensor/issues/27) force baseline | `dot/fix-em-force-baseline` | Local patch prepared; independent static review and 12 exact rational checks passed; Lean kernel checks pending. Branch not yet published. |
| [#34](https://github.com/lilalittle/asymmetric-tensor/issues/34) reproducible setup | `dot/reproduce-pinned-build` (planned name) | Local patch prepared; static pin-preservation review passed; fresh-checkout build validation pending. Branch not yet published. |
| [#11](https://github.com/lilalittle/asymmetric-tensor/issues/11) tensor Lie derivative | To be recorded after validation | Local implementation underway; review and kernel checks pending. |
| [#33](https://github.com/lilalittle/asymmetric-tensor/issues/33) formalization scope | To be recorded after validation | Documentation underway; baseline inconsistency must remain disclosed until the conservation repair is integrated. |

The official Lean 4.35.0 toolchain is installed. Pinned Mathlib dependency/cache setup is in progress. No untested Lean change is marked ready.

## Remaining issue coverage

Initial inventory: 40 open issues at upstream revision `9f69988`, no open PRs before this work. Every issue comment thread was checked and was empty.

- #4–8 and #31 are aggregate/review/outreach workstreams; their closure depends on constituent repairs and author publication.
- #10 and #26 have bounded mathematical implementation routes based on existing manuscript conventions; queued after initial repairs.
- #29–30, #35, #37–39 are autonomous documentation, verification, organization, and planning work still to assess/implement. Kernel/CI validation is required where applicable.
- #36 is candidate integration and invitation drafting; it needs a concrete validated candidate and reconciled claims.
- #41 is repository integration of corrected claims; author-approved manuscript/errata are still required.
- #42–44 explicitly require Binyamin's approved manuscript corrections/publication.
- #12–24 (except #18's conditional PDE subwork) and #28 include substantial mathematical subwork but also author-dependent physical-model or manuscript decisions. They must not be declared resolved merely by adding a disclaimer or a conditional lemma. Specific decisions will be recorded as triage completes.

This is an initial queue, not a claim that all remaining issues are blocked or complete. It will be updated as each branch passes validation.
