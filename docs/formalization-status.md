# Historical formalization status and scope

**Frozen scope-review snapshot:** this document describes the precise source hash
below, before the combined repairs. References to “current” or “this candidate”
mean that historical snapshot. For the combined checkout use
[integration status](integration-status.md); its explicit delta supersedes the
changed rows here. This preservation prevents source-linked review evidence from
being silently reassigned to a different program.

This is the reader-facing scope map for [#33][i33]. It distinguishes implemented
mathematics from physical assumptions, missing constructions, and specification
targets. It is not the exhaustive equation-to-declaration ledger requested by
[#29][i29], and it does not change the manuscript or resolve its scientific
interpretation.

## Reviewed snapshot and validation

- **Reviewed baseline:** [`9f69988d17c9fb86f35a563eb6466be9dbf4e524`][snapshot].
  The section/finding source-line links preserve this immutable review evidence.
- **Included dependency:** the [#9 coordinate-conservation repair](conservation.md),
  published as [fork commit `78ee76bf2dbf2412b5f35a51e38e3695c014a6f9`](https://github.com/subtleGradient/asymmetric-tensor/commit/78ee76bf2dbf2412b5f35a51e38e3695c014a6f9).
  Its implementation, documentation and regression test are included in this
  candidate. This does **not** claim an upstream merge. The current §5 and #9
  dispositions below explicitly reflect this change; other repair branches are
  not included merely because they exist.
- **Candidate identification:** the inspected baseline plus that conservation
  implementation, scope documentation, and declaration-docstring/API-example additions. The tested
  `AsymmetricTensor.lean` SHA-256 is
  `1afa98fa126af48e643dc3d6054df980dd0abed9433a99127de334791a8a4633`.
  Use `git rev-parse HEAD` to identify the checked-out candidate commit;
  the source hash above identifies the source reviewed here.
- **Manuscript inspected:** [v9, dated September 25, 2026][pdf], published as
  [Zenodo 22953897](https://doi.org/10.5281/zenodo.22953897).
- **PDF SHA-256:**
  `0d97cbca284e68aeed75c98b830ce16ab0453fa54f7333ce50eb90e1f4f4e7a7`.
- **Historical elaboration evidence:** the [baseline README][f30] and
  [#30][i30] record Lean 4.35.0 and Mathlib
  `aa35a481e5f0cdb3b04a899ead15d6ca7305a624`, zero errors and zero `sorry`
  occurrences, with import/module warnings. That build did not detect the
  inconsistent custom axiom described below.
- **Combined candidate validation, 2026-10-15:** `lake build AsymmetricTensor`
  and `lake env lean tests/Conservation.lean` both completed successfully using
  the existing shared dependency cache and the committed toolchain/manifest.
  Import/module warnings remain. The toolchain, Lake configuration and manifest
  did not change. No fresh-checkout setup or remote CI result is claimed.
- **Static documentation checks:** declaration and exact-target inventories,
  local links/anchors, immutable source ranges, all 22 finding dispositions,
  and the PDF hash were checked. Outside the included #9 source region, only the
  introductory module comment, declaration docstrings, and documentation changed.

**Historical consistency blocker:** the baseline `covariant_conservation`
quantified over *every* `MetricField`, although `metric_divergence` is an explicit
coordinate derivative. The field `U x μ ν = x 0` has divergence component `1`,
while the axiom forced it to be `0`. [#9][i9] retains the kernel-checked `False`
reproducer. Thus the baseline's custom theory was inconsistent.

**Current included repair:** `CoordinateConserved U` is an explicit proposition
`∀ x, metric_divergence U x = 0`. The component-projection theorems require it as
`hU`; constant-field witnesses show a nonempty class, and
`coordinate_field_not_conserved` rejects the original linear field. See the
[repair documentation](conservation.md) and [regression file](../tests/Conservation.lean).
This removes the demonstrated universal-axiom contradiction. It does not derive
conservation for `U_hat_dynamic`, introduce a connection, or prove the physical
momentum PDE; [#13][i13] and [#18][i18] remain open.

The regression run printed transitive dependencies for these **seven selected
statements**, not the entire library:

| Checked declarations | Printed dependencies |
|---|---|
| `constant_coordinate_conserved`, `exists_coordinate_conserved`, `coordinate_field_not_conserved`, `bernoulli_energy_conservation`, `navier_stokes_momentum_conservation` | `propext`, `Classical.choice`, `Quot.sound` |
| `geometric_navier_stokes` | The same standard logical axioms plus `c`, `c_pos`, `hbar`, `hbar_pos`, `l_p`, `l_p_pos` |
| `unified_action_separation` | The same standard logical axioms plus `c` |

None of those seven lists contains `sorryAx` or a custom conservation axiom.
That focused check is not a complete dependency audit or a proof of consistency
of every remaining model assumption. Further integration/review requirements
are [listed below](#reconciliation-before-candidate-review).

## How to read the status labels

- **Algebra:** a concrete identity, inequality, or rewriting argument about the
  implemented real numbers, matrices, or modules. The label describes the
  statement, not a claim of zero dependencies or physical completeness.
- **Conditional model:** an implication whose physical relationships are supplied
  as hypotheses. The conclusion can be useful while the assumed mechanism remains
  unproved.
- **Specification target:** the proposed conclusion is supplied as a premise and
  returned unchanged. This is valid implication logic, not a derivation of that
  premise.
- **Open construction:** the named geometry, dynamics, or object is absent or
  represented only by scalar/component stand-ins.
- **Known mismatch/counterexample:** a stronger intended claim is contradicted by
  an example or does not match the chosen formula. A scope note does not repair
  that claim.

A single section can have several labels. Physical names below are retained as
navigation aids; the object and hypothesis columns determine what was encoded.
“Open” means unresolved in this candidate, not a claim about a later GitHub
issue state. The included #9 repair is identified separately from the historical
baseline and the remaining open findings.

## Where to start

1. **Matrix splitting:** `T2`, `symPart`, `antiPart`, and
   `matrix_decomposition` in [§1][s1] and [§3][s3]. `T2` is a real 4×4 matrix;
   decomposition is an entrywise algebraic identity.
2. **The component ansatz:** `U_hat`, `U_sym`, `U_anti`,
   `symmetric_diagonals`, and `antisymmetric_shear` in [§3][s3]. Inspect the
   fixed-chart entries and the use of `1 / alpha_s^2`; the definition does not
   bundle admissibility, a timelike velocity, or a spatial projector.
3. **Two contractions:** `raiseBoth` and `contract2` in [§3][s3], versus
   `tensor_contract` and `unified_action_separation` in [§6][s6]. The former take
   an explicit index-raising matrix; the baseline action theorem uses the
   Frobenius component sum. [#10][i10] explains why the distinction matters.
4. **Conditional fluid rewriting:** read `partial_deriv`, `metric_divergence`,
   and then `geometric_navier_stokes` in [baseline §5][s5]. For the current
   conservation interface, also read `CoordinateConserved` and its witnesses in
   the [included repair](conservation.md). The fluid rewriting theorem still
   starts from a component conservation equation and rewrites quantities defined
   from those components; it does not construct the material-acceleration PDE.
5. **A physical premise in plain sight:**
   `baryonic_tully_fisher_derivation` in [§11][s11] squares its `h_plateau`
   hypothesis. Inspect that premise before interpreting the theorem name.
6. **An assumed target:** `alpha_decay_wkb_mapping` in [§16][s16] takes exactly
   its result as `h_target`. Compare it with the real algebra in
   `volumetric_admittance_scaling` in the same section.

## Section-by-section status

The numbering follows the source's advertised paper topics. Subsection/equation
numbers in old source comments are not a verified v9 equation mapping. The
separate [#29 ledger][i29] must establish that mapping.

| Section/topic | Entry-point declarations and implemented objects | Essential assumptions and completion status |
|---|---|---|
| [0. Constants][s0] | `c`, `l_p`, `hbar`; definitions `t_p`, `M_P`, `G`, `rho_tau`, `P_c`; positivity and bridge lemmas such as `M_P_sq_eq_hbar_c_div_G`. | **Algebra with custom assumptions.** Three real constants and their positivity are postulated. Definitions fix the relationships; they are not empirical determinations of constants. |
| [1. Kinematic parametrization][s1] | `V4`, `T2`; `v_macro` adds three elements of a real module; `Omega` applies `ext_deriv` to `curl_phase`. | **Definitions; open exterior calculus.** `V_3D` and `Forms_2D` are arbitrary real modules, not dimension-constrained spaces of forms. `ext_deriv` is an arbitrary function with no derivative, wedge, or closure laws. See [#19][i19]. |
| [2. Thermodynamic budget][s2] | `P_dyn_scalar`, `P_g`, `P_dyn_components`; `emergent_critical_pressure`, `compliance_equivalence`. | **Algebra.** Pressure expressions and the velocity-square budget are definitions using the postulated constants. There is no general admissible-state subtype or universal subcritical pressure bound. A pressure/energy interpretation remains additional modeling content. See [#12][i12], [#22][i22]. |
| [3. Tensor assembly][s3] | `symPart`, `antiPart`, `matrix_decomposition`, `asBilinear`, `raiseBoth`, `contract2`; the fixed-chart matrix `U_hat` and its parts. | **Concrete matrix algebra; open covariant assembly.** Scalar parameters are arbitrary reals. `gInv` in `raiseBoth` is an input matrix, not a proved inverse. No normalized four-velocity, spatial projector, general transformation law, or admissibility proof is supplied. See [#10][i10], [#12][i12], [#13][i13]. |
| [4. Field equation / macroscopic reduction][s4] | Budget rearrangements (`energy_density_proof`, `spatial_stress_proof`), scalar `cosmological_constant_derivation`; `VolAvg` is `symPart`; `macroscopic_torsion_nullification` is a linear-map identity. | **Algebra and conditional model.** Pressure and cosmological relations are premises. `Inc` is an arbitrary linear map commuting with `VolAvg` by hypothesis. There is no volume integral, torsion, or Einstein tensor. Coherent antisymmetric averages contradict the averaging interpretation. See [#14][i14], [#15][i15]. |
| [5. Differential geometry / equation of motion][s5] | Functions on `SpaceTime = Fin 4 → ℝ`, coordinate `partial_deriv` via `fderiv`, and summed `metric_divergence`; `U_hat_dynamic` uses opaque fields. The [included #9 repair](conservation.md) adds `CoordinateConserved`, constant-field existence and linear-field nonconservation; both projection results require `hU`. | **Conditional conservation and algebra.** The historical universal axiom is removed and the new witness/projection regressions pass. `geometric_navier_stokes` still assumes the vanishing component sum; its pressure/acceleration/stress quantities remain component definitions. No continuity, differentiability, connection, material acceleration, viscosity, or defect momentum equation follows merely from the types. `lie_derivative` still contains transport only; §5.8 has variables but no defect equation. [#11][i11], [#13][i13], [#17][i17], [#18][i18] remain open. |
| [6. Action / singularity resolution][s6] | `tensor_contract` is the Frobenius sum; `unified_action_separation` splits its quadratic expression. `cavitation_schwarzschild_radius` solves an assumed scalar pressure equality. `modified_poisson_equation` rescales a supplied equation. | **Algebra and conditional models; open variation and regularization.** `Laplacian` and `Biharmonic` are functions `ℝ → ℝ` with specific rescaling premises; `h_variation` supplies the purported varied equation. `unified_wave_propagation` distributes an additive `T2 → T2` operator and assumes its vacuum equation. §6.2 is prose only. No action functional, boundary variation, Green function, or singularity bound is constructed. See [#10][i10], [#15][i15], [#16][i16], [#19][i19]. |
| [7. Conformal symmetry / dressing][s7] | `lorentz_symmetry_broken` isolates a scalar from `h_residual`; `conformal_pressure_coupling` substitutes a pressure-gradient premise; `dressing_field_invariance` cancels module elements. | **Conditional algebra; open symmetry derivations.** The residual is not derived from the tensor operator; ten Poincaré generators, Noether currents, and conformal action are not supplied. §§7.3–7.4 are placeholders. Abelian additive cancellation is not a constructed gauge connection. See [#11][i11], [#19][i19], [#29][i29]. |
| [8. Mass mechanism / yield][s8] | `tensor_vev_origin`, `orthogonal_mass_extraction`, `topological_yield_limit`, `yield_partition`, `mass_yield_equivalence` manipulate real scalar relations. | **Conditional models.** Inputs include the pressure/velocity equation, Lagrangian split, Compton/Schwarzschild radius intersection, positive mass, and the equal-load partition. §8.2 has no phase-lock construction. No stress/energy calculation derives the mass identification or 50/50 partition. See [#22][i22]. |
| [9. Gauge / spectra / cavitation][s9] | Matrix-entry ratios (`longitudinal_axis_invariance`, `cross_coupling_impedance`), `transverse_U1_decomposition`; scalar square-zero, determinant-formula and Deborah-number algebra. | **Algebra with known interpretive failures.** `schwinger_limit_eigenvalues` proves a diagonal entry and repeats `h_Omega`; it has no spectrum. `isochoric_volume_preservation` assumes `h_det`, and `generalized_cavitation` assumes a scalar determinant formula. No full characteristic polynomial or unitary group action is constructed. `legal_cavitation_collapse` uses totalized `1/0 = 0`, not a one-sided limit. See [#12][i12], [#20][i20], [#21][i21]. |
| [10. Covariance / frames / CPT][s10] | `active_kinematic_contraction` and `rotational_covariance_leakage` substitute scalar premises; `equivalence_principle_gradients` rewrites module equalities; `T_symmetry_*` and `P_symmetry_*` are scalar sign identities. | **Conditional algebra; open tensor transformation model.** The coordinate-transformation expression is assumed, not derived from an action on tensor fields. §§10.1 and 10.4 are empty headings. There are no field-level CPT or antimatter objects. See [#13][i13], [#29][i29]. |
| [11. Galactic kinematics / cosmological boundary][s11] | `P_cosmo` is an exponential ansatz, `P_shear_2D` a logarithmic ansatz; `kinematic_plateau_extraction` solves `h_accel`; `baryonic_tully_fisher_derivation` squares `h_plateau`. | **Conditional model; open dynamics and known boundary mismatch.** Nonzero radii and sign bounds appear in the algebra, but the shear amplitude/baryon coupling is assumed. The exponential does not saturate at finite `r = R_h`. There is no formal no-go theorem against other gravity/halo theories. See [#23][i23], [#24][i24], [#28][i28]. |
| [12. Einstein–Cartan / affine connection][s12] | `longitudinal_transport_acceleration` rewrites a module-valued gradient premise; `einstein_cartan_lagrangian` distributes a scalar multiplier. | **Conditional algebra; open geometry.** `R_tilde`, `K_trace_1`, and `K_trace_2` are real inputs. No connection, contortion, curvature, torsion, or isomorphism is constructed. §§12.1, 12.3, 12.4, and 12.5 are empty. See [#13][i13], [#15][i15]. |
| [13. Wave mechanics / induction][s13] | `transverse_wave_propagation` rescales `h_wave` in a module; `transverse_energy_transmission` is a cosine-square identity; `eigenstate_convergence` cancels a nonzero scalar factor; `debye_attenuation_length` substitutes the definition of `P_c`. | **Conditional algebra; open evolution.** The wave equation, projected energies, steady-state relation, and attenuation formula are premises. `wedge_product` is a real number, not an exterior product. No convergence theorem, quantum measurement model, or Maxwell closure is supplied; §13.2 is empty. See [#12][i12], [#19][i19]. |
| [14. Pressure dynamics / force hierarchy][s14] | Velocity and pressure scaling; `geometric_action_boundary`, `action_constant_identity`; the defined scalar `F_fund`; force/radius substitutions, `kinematic_acceleration_floor`, and `universal_gravitation_limit`. | **Conditional models and algebra.** Radius, energy/action, mass and aggregation laws are hypotheses; no force field is derived from a pressure integral. Baseline `interaction_hierarchy_em` includes an extra `alpha_em` factor relative to v9's baseline force. Quantum inputs and horizon interpretation remain assumptions. See [#22][i22], [#23][i23], [#27][i27]. |
| [15. Lensing / redshift / optical distance][s15] | `cosmological_redshift_ratio` cancels an assumed wavelength scale; `tensor_refractive_index` simplifies assumed speed/admittance relations; `refractive_index_substitution` rewrites the ansatz; magnitude lemmas cancel logarithms. | **Conditional algebra with a formula mismatch.** Baseline uses natural `Real.log`, whereas the distance modulus needs base 10. Distances and moduli are inputs, not path integrals. §15.4 is empty: no integrability, strict optical-path inequality, positive anomaly, or travel-time delay is established. See [#23][i23], [#25][i25], [#26][i26]. |
| [16. Predictive corollaries / future work][s16] | A mixture of square-root, trigonometric and module identities, hypothesis substitutions, and the ten exact targets below, all within `FutureWork`. | **Algebra, conditional models, and specification targets.** `dirac_spinor_double_cover` is two real cosine identities; `rydberg_energy_quantization` accepts `n_integer : ℝ` and assumes energy equals pressure; `fourier_curvature_decomposition` proves positivity of two nonzero real squares. No spinor representation, integer-mode quantization, Fourier curvature decomposition, or SU(3) mass-gap theory is present. The paper itself presents this section as a roadmap. See [#19][i19], [#21][i21], [#26][i26], [#29][i29]. |

## Assumptions and unspecified symbols

### Explicit source axioms

The current candidate has six declarations beginning with `axiom`, unchanged
from §0 of the baseline:

| Declarations | What is assumed | Evidence |
|---|---|---|
| `c`, `l_p`, `hbar` | Three specified-but-not-numerically-fixed real constants. | [§0][s0] |
| `c_pos`, `l_p_pos`, `hbar_pos` | Strict positivity of those constants. | [§0][s0] |

The baseline had a seventh explicit axiom, `covariant_conservation`, asserting
zero divergence for every field. It was inconsistent and has been **removed**
by the [included #9 repair](conservation.md). `CoordinateConserved` is a defined
predicate supplied as a theorem premise, not a replacement universal axiom.

This inventory is **not** the transitive custom-axiom dependency list for any
particular theorem. Imported declarations, opaque declarations, proof-generating
tactics, and all dependencies of the checked expression need kernel-level
inspection, for example with `#print axioms` after the relevant build. Standard
logical axioms such as `propext`, `Classical.choice`, and `Quot.sound` should be
reported separately from model assumptions and `sorryAx`. The current candidate's seven selected
prints above, and the review's prints in [#9][i9] and [#18][i18], do not
constitute a whole-library audit.

### Opaque fields and parameterized stand-ins

The nine body-less `opaque` field declarations are:

- `alpha_s_f`, `alpha_f`, `v_x_f`, `v_y_f`, `v_z_f`, `Omega_x_f`, `Omega_y_f`,
  `Omega_z_f : ScalarField` ([source][opaque-fields]);
- `epsilon_vec_f : VectorField` ([source][opaque-vector]).

Their types do not assert continuity, differentiability, pressure bounds,
nonvanishing admittance, equations of motion, or relationships among the fields.
They must be included when inspecting the dependencies and intended meaning of
`U_hat_dynamic` and results built from it. The word “continuous” in a comment
cannot supply a missing regularity hypothesis. In particular, a total
`fderiv`-based expression is not itself proof that its input is differentiable.

Other unspecified symbols are **parameters**, not extra global physical axioms:

- `V_3D`, `Forms_2D`, and `Force3D` have additive-group/real-module structure;
  their names do not enforce dimension, spacetime dependence, or form degree.
- `ext_deriv : V_3D → Forms_2D` is an arbitrary function; `Inc : T2 →ₗ[ℝ] T2`
  is an arbitrary linear map, with commutation separately assumed.
- `Laplacian`, `Biharmonic : ℝ → ℝ` and `dAlembertian : T2 → T2` have the
  specific properties supplied by the theorems' premises. Their names do not
  make them differential operators on fields.
- Scalar names such as `R_tilde`, `K_trace_1`, `K_trace_2`, `A_anti_trace`,
  `wedge_product`, `WKB_integral`, and `Minimized_Action` do not create curvature,
  contortion, a tensor contraction, an exterior product, an integral, or a
  minimization problem. `Lambda_ab` and `Lambda_ab_prime` are arbitrary `Type`s.
- Hypotheses including `h_variation`, `h_residual`, `h_intersection`, `h_det`,
  `h_plateau`, and `h_wave` carry substantive proposed relationships. Inspect the
  full theorem type, including parameters introduced earlier by `variable`.

Real division and square root are total in Lean. For example, `1 / (0 : ℝ) = 0`
is a valid library convention, not a physical singular limit. Algebraic
statements valid with that convention still need an explicit admissible domain
before an interpretation involving inverse compliance, positive energy, or
propagating fields. See [#12][i12].

## The ten `exact h_target` cases

These are all ten occurrences in the reviewed source. Each theorem assumes
exactly the proposition it concludes. None supplies the proposed underlying
model. They are recorded as specification targets, not invalid proofs.

| Declaration | Assumed and returned proposition | Missing construction; source |
|---|---|---|
| `alpha_decay_wkb_mapping` | `T_transmission = Real.exp (-WKB_integral)` for real inputs. | No tunneling model or WKB integral. [Lines 2021–2024][t1] |
| `optimal_transport_minimization` | `W_2_distance = Minimized_Action` for real inputs. | No measures, Wasserstein distance, admissible transport, or minimizer. [Lines 2026–2029][t2] |
| `gravitoelectromagnetism_mapping` | `GravitoElectric = v_perp_val ∧ GravitoMagnetic = Omega_val` in an arbitrary real module. | No defined gravitoelectric/magnetic fields or dynamics. [Lines 2075–2078][t3] |
| `poynting_vector_convection` | `Poynting_Vector = Lamb_Vector` in an arbitrary real module. | No cross products, flux, or field-level identification. [Lines 2080–2083][t4] |
| `entanglement_contextuality` | `Lambda_ab ≠ Lambda_ab_prime` for two `Type`s. | No measurement settings, probability model, or contextuality theorem. [Lines 2085–2089][t5] |
| `helicity_orbital_arrest` | `alpha_s_val > 0` for a real input. | No helicity or orbital evolution. [Lines 2091–2094][t6] |
| `almansi_finite_strain` | `e_ij = (1 / 2) * (delta_ij - S_ij_inv)` for real inputs. | No deformation map, inverse matrix, or strain derivation. [Lines 2174–2177][t7] |
| `su3_mass_gap_transition` | `De = 1` for a real parameter. | No SU(3) structure, spectral gap, or transition proof. [Lines 2179–2183][t8] |
| `lorentz_force_magnus_mapping` | `F_mu = A_mu_nu_v_nu` for real inputs. | No tensor contraction, Lorentz-force dynamics, or Magnus-force derivation. [Lines 2185–2188][t9] |
| `wake_detachment_stabilization` | `Normalized_Shear = A_ij / alpha_s` for real inputs. | No wake evolution, stability criterion, or derived normalization. [Lines 2190–2193][t10] |

Other theorems can also be conditional or lack the objects suggested by their
names without using the literal text `exact h_target`. For example,
`michelson_morley_invariance` assumes equal formulas for both times;
`casimir_pressure_scaling` assumes the pressure law; and
`mott_scattering_cross_section` transforms an assumed cosine-square amplitude
using a half-angle identity. The ten-count is not a complete measure of coverage.

## Review findings and dispositions

All 22 findings from #9 through #30 are accounted for below. “Counterexample”
refers to the specific claim or interpretation identified in the issue; it does
not mean the corresponding conditional Lean proof term is invalid. “Missing”
identifies an absent inference or construction and is not evidence that the
physical proposal is impossible. The issue links preserve the detailed review,
PDF page references, defense checks, and acceptance criteria.

**This table does not change GitHub issue states or claim upstream merge.**
The #9 encoding repair is included and locally validated; the other findings
remain open except for the documentation progress stated in their rows.
Known false/mismatched claims still need their own corrected definitions or
statements, or an explicit withdrawal with remaining work tracked. Paper
changes remain the author's responsibility.

| Finding | Evidence and kind of gap | Disposition at the reviewed snapshot |
|---|---|---|
| [#9 Universal conservation][i9] | **Historical contradiction:** `U x μ ν = x 0` gives a divergence component `1`; the old universal axiom set it to `0`. [Baseline source][f9] | **Included dependency, locally validated; upstream merge not claimed.** [Repair](conservation.md) removes the axiom, adds `CoordinateConserved`, constant-field witnesses and the linear-field nonconservation theorem, and requires `hU` in projection results. Combined build and [regressions](../tests/Conservation.lean) pass, with standard logical axioms only for all five conservation statements. Historical contradiction evidence remains in #9, outside production. |
| [#10 Physical action contraction][i10] | **Sign mismatch:** a pure-electric antisymmetric pair has Frobenius self-contraction `+2` but Minkowski-raised contraction `-2`. [Source][f10] | **Open Lean/convention repair.** Retain the Frobenius identity as algebra; choose and use an explicit raising metric for the physical-action target and prove its electric/magnetic signs. |
| [#11 Tensor Lie derivative][i11] | **Operator counterexample:** constant `η` under dilation has baseline transport derivative `0`, whereas the covariant rank-two Lie derivative is `2η`. [Source][f11] | **Open Lean repair.** Add both index terms, state regularity, and derive translation/dilation/boost behavior. Residual algebra alone remains conditional. |
| [#12 Saturation and limits][i12] | **Boundary/limit mismatch:** `inv_zero` yields zero at `alpha_s = 0`; positive `alpha_s = 1/n` yields growing spatial diagonal `n²`. [Source][f12] | **Open Lean and paper repair.** Separate the subcritical domain, one-sided limits, and any post-yield phase; repair the determinant boundary argument. |
| [#13 Covariant field model][i13] | **Missing objects:** fixed-chart functions/matrix, no normalized velocity/projector or connection; `metric_divergence` is a partial divergence. [Source][f13] | **Open Lean and paper modeling decision.** Construct the required covariant objects or explicitly restrict the retained model. This map documents the current coordinate scope but does not supply that construction. |
| [#14 Coarse-graining][i14] | **Counterexample to averaging interpretation:** `VolAvg = symPart` annihilates a constant nonzero antisymmetric field, while normalized spatial averaging preserves it. [Source][f14] | **Open Lean and paper repair.** Add a field/domain/measure model and appropriate zero-mean, boundary and regularity assumptions; keep projection algebra distinct. |
| [#15 Einstein-curvature inference][i15] | **Missing inference:** arbitrary linear `Inc` and scalar distributivity do not construct an Einstein tensor or Einstein–Cartan equivalence. [Source][f15] | **Open derivation/postulate decision.** Supply domains, derivative order, metrics, normalization and the geometric bridge, or explicitly state the intended correspondence as a postulate. |
| [#16 Variation and regularization][i16] | **Missing derivation:** `h_variation` already assumes the varied equation; differential operators, boundary terms and regularity bounds are not constructed. [Source][f16] | **Open Lean and paper repair.** Retain rescaling algebra; separately define/vary an action and prove any singularity-resolution claim. |
| [#17 Weak-field ordering][i17] | **Approximation mismatch:** the manuscript says fourth-order spatial terms are dropped while retaining convective flux at that order. The conditional component identity does not resolve the ordering. [Source][f17] | **Open paper specification and Lean target.** State a consistent small-parameter scaling and propagate it through all retained components before deriving the PDE. |
| [#18 Actual momentum PDE][i18] | **Missing bridge:** `kinematic_accel_f` is defined from a tensor time derivative; `geometric_navier_stokes` has no material-velocity term and assumes component conservation. [Source][f18] | **Open Lean derivation.** Preserve the conditional rewriting lemma; define velocity, density and stress and prove their links to the intended conservation/PDE model. |
| [#19 Exterior calculus / Maxwell closure][i19] | **Missing structure/dynamics:** arbitrary `ext_deriv`, additive operator, and a supplied `h_wave`; no exterior-derivative laws or temporal closure. [Source][f19] | **Open Lean and paper assumptions.** Construct forms and closure/evolution equations or retain only explicitly conditional algebraic support lemmas. |
| [#20 Full-matrix spectra][i20] | **Counterexample:** with the issue's nonzero temporal slip, `det(U - (1+i)I) = -1/4`; the named theorem merely gives `U11 = 1` and repeats `h_Omega`. [Source][f20] | **Open Lean and paper repair.** Compute the full characteristic polynomial, distinguish a spatial block from an invariant full-tensor subspace, and propagate valid restrictions. |
| [#21 Finite volume preservation][i21] | **Counterexample:** an additive trace-free antisymmetric load can give `det(U) = -2`, not `-1`. Scalar `h_det` is assumed; spatial determinant and square-root density also differ. [Source][f21] | **Open Lean and paper repair.** Separate trace, determinant, and volume density; justify a finite deformation or explicitly impose an isochoric constraint. |
| [#22 Mass / pressure budget][i22] | **Missing energy/partition inference:** a Lorentzian antisymmetric action can be signed, and equal vector component norms do not establish equal physical loads. The Lean mass/radius and partition relationships are premises. [Source][f22] | **Open Lean and paper modeling work.** Define stress/energy and the signed/nonnegative ledger consistently; identify quantum postulates and derive or label the partition conjecture. |
| [#23 Finite horizon][i23] | **Boundary counterexample:** at `r = R_h`, the ansatz gives `v/c = 1 - exp(-1)` and `P/P_c = (1 - exp(-1))²`, below saturation. [Source][f23] | **Open Lean and paper interpretation.** Resolve the horizon/domain and fitted-versus-derived status before propagating acceleration-floor and optical conclusions. |
| [#24 Galactic coupling / BTFR][i24] | **Missing coupling, plus specific counterexamples/mismatch:** `h_plateau` already encodes BTFR before squaring; axial invariance does not force plane stress; equations (169)/(173) do not yield the printed (178) ratio. [Source][f24] | **Open dynamics and paper correction.** Retain conditional plateau algebra; provide the constitutive/boundary coupling or label it an ansatz, and separately correct the pressure-ratio formula. |
| [#25 Distance-modulus logarithm][i25] | **Numerical mismatch:** a tenfold distance ratio gives `5 ln(10)` rather than `5` with the baseline `Real.log`. [Source][f25] | **Open Lean correction.** Use base 10 consistently, document the positive dimensionless-distance convention, and add a tenfold-ratio regression. |
| [#26 Optical path integral][i26] | **Missing bridge:** arbitrary distances/moduli and a local speed identity; no `∫ n`, integrability, strict distance inequality, or travel-time theorem. [Source][f26] | **Open Lean derivation**, dependent on a chosen domain and corrected logarithm. Define the path/time model and prove its inequalities; do not infer a positive anomaly from cancellation alone. |
| [#27 Electromagnetic force factor][i27] | **Formula mismatch:** Lean proves `alpha_em * F_fund(a0)` with cubic coupling; v9 (224) specifies the unscaled baseline with quadratic coupling. [Source][f27] | **Open Lean/paper reconciliation.** Add the exact baseline statement and hierarchy ratio; any separately coupled force needs a distinct, explicit interpretation. |
| [#28 Universal no-go claims][i28] | **Unsupported generalization:** a source-free 3D Laplace observation does not quantify over other gravity/halo models; no such exclusion theorem exists in this Lean section. [Source][f28] | **Open paper correction.** Scope the exclusion to its actual operator, dimension, source and domain, or supply a precise broader target and argument. No empirical verdict is supplied here. |
| [#29 Equation-level ledger][i29] | **Coverage/documentation gap:** named targets, empty headings and scalar stand-ins do not amount to exhaustive paper coverage. [Source][f29] | **Partly addressed at section/topic level by this map.** The exhaustive v9 equation mapping and transitive custom-axiom audit remain separate open work. The PDF identity and all exact-target cases are recorded here without claiming those larger tasks are finished. |
| [#30 Reproducible workflow][i30] | **Repository mismatch:** baseline README refers to absent `.github` CI and starts reproduction with `lake update`. [Baseline README][f30] | **Documentation claims corrected here; verification remains open.** Preserve the committed dependency selection and stop claiming absent CI. Clean-checkout validation and an actual workflow/audit remain tracked in [#34][i34] and this finding. |

## Reconciliation before candidate review

The current map includes the #9 implementation and its successful local build
and regressions. Before a final combined candidate is presented or published:

1. Record its exact candidate commit and verify it contains the included
   conservation dependency and the reviewed documentation. Preserve the tested
   source hash and historical baseline evidence; inclusion on a fork is not an
   upstream merge.
2. Keep §5, the six-axiom inventory, README, module note and #9 disposition
   synchronized with the actual `CoordinateConserved` API. The witnesses and
   changed projection calling convention are tested here. Preserve [#13][i13]
   and [#18][i18] as open: a nonempty conservation constraint does not establish
   a covariant connection or a physical momentum-PDE derivation.
3. Re-run the build and regressions after any subsequent source integration.
   Extend the dependency inspection as required, including opaque symbols and
   `sorryAx`; do not promote the seven selected prints here into the complete
   [#29][i29] audit. Fresh-checkout/CI reproducibility remains distinct from
   the successful existing-cache build reported above.
4. Reconcile any further integrated fixes, especially [#10][i10], [#11][i11],
   [#25][i25], [#27][i27], and [#30][i30]/[#34][i34], with the appropriate rows
   and README workflow. Their existence on other branches does not mean this
   candidate includes them or meets their full acceptance criteria. In
   particular, the broader #34 setup patch is not included here.
5. Preserve the distinction between local elaboration, reproducible setup/CI,
   paper-to-Lean correspondence, consistency of model assumptions, and empirical
   testing. This documentation does not alter the manuscript or certify its
   scientific claims.

[snapshot]: https://github.com/lilalittle/asymmetric-tensor/tree/9f69988d17c9fb86f35a563eb6466be9dbf4e524
[pdf]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/papers/asymmetric-metric-tensor.pdf
[s0]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L40-L140
[s1]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L143-L155
[s2]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L158-L200
[s3]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L203-L280
[s4]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L283-L425
[s5]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L428-L628
[s6]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L631-L776
[s7]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L779-L866
[s8]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L868-L1012
[s9]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1017-L1219
[s10]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1222-L1311
[s11]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1314-L1383
[s12]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1386-L1435
[s13]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1438-L1520
[s14]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1523-L1830
[s15]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1832-L1920
[s16]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1923-L2195
[i9]: https://github.com/lilalittle/asymmetric-tensor/issues/9
[i10]: https://github.com/lilalittle/asymmetric-tensor/issues/10
[i11]: https://github.com/lilalittle/asymmetric-tensor/issues/11
[i12]: https://github.com/lilalittle/asymmetric-tensor/issues/12
[i13]: https://github.com/lilalittle/asymmetric-tensor/issues/13
[i14]: https://github.com/lilalittle/asymmetric-tensor/issues/14
[i15]: https://github.com/lilalittle/asymmetric-tensor/issues/15
[i16]: https://github.com/lilalittle/asymmetric-tensor/issues/16
[i17]: https://github.com/lilalittle/asymmetric-tensor/issues/17
[i18]: https://github.com/lilalittle/asymmetric-tensor/issues/18
[i19]: https://github.com/lilalittle/asymmetric-tensor/issues/19
[i20]: https://github.com/lilalittle/asymmetric-tensor/issues/20
[i21]: https://github.com/lilalittle/asymmetric-tensor/issues/21
[i22]: https://github.com/lilalittle/asymmetric-tensor/issues/22
[i23]: https://github.com/lilalittle/asymmetric-tensor/issues/23
[i24]: https://github.com/lilalittle/asymmetric-tensor/issues/24
[i25]: https://github.com/lilalittle/asymmetric-tensor/issues/25
[i26]: https://github.com/lilalittle/asymmetric-tensor/issues/26
[i27]: https://github.com/lilalittle/asymmetric-tensor/issues/27
[i28]: https://github.com/lilalittle/asymmetric-tensor/issues/28
[i29]: https://github.com/lilalittle/asymmetric-tensor/issues/29
[i30]: https://github.com/lilalittle/asymmetric-tensor/issues/30
[i33]: https://github.com/lilalittle/asymmetric-tensor/issues/33
[i34]: https://github.com/lilalittle/asymmetric-tensor/issues/34
[t1]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2021-L2024
[t2]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2026-L2029
[t3]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2075-L2078
[t4]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2080-L2083
[t5]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2085-L2089
[t6]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2091-L2094
[t7]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2174-L2177
[t8]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2179-L2183
[t9]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2185-L2188
[t10]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2190-L2193
[f9]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L438-L466
[f10]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L636-L676
[f11]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L612-L621
[f12]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1116-L1141
[f13]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L430-L476
[f14]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L370-L425
[f15]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1426-L1435
[f16]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L715-L776
[f17]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L587-L607
[f18]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L493-L607
[f19]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1442-L1520
[f20]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1048-L1114
[f21]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1055-L1065
[f22]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L907-L1011
[f23]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1319-L1324
[f24]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1314-L1383
[f25]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1897-L1920
[f26]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1835-L1920
[f27]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1723-L1740
[f28]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L1314-L1383
[f29]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L2018-L2193
[f30]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/README.md#L17-L41
[opaque-fields]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L469-L476
[opaque-vector]: https://github.com/lilalittle/asymmetric-tensor/blob/9f69988d17c9fb86f35a563eb6466be9dbf4e524/AsymmetricTensor.lean#L614
