import AsymmetricTensor

open AsymmetricTensor

-- Start with an arbitrary component matrix, not a physical-model assumption.
example (U : T2) : U = symPart U + antiPart U := matrix_decomposition U

-- A nonsymmetric off-diagonal example: U_01 = 2 and other components zero.
def sampleMatrix : T2 := fun i j => if i = 0 ∧ j = 1 then 2 else 0

example : symPart sampleMatrix 0 1 = 1 := by norm_num [symPart, sampleMatrix]
example : antiPart sampleMatrix 0 1 = 1 := by norm_num [antiPart, sampleMatrix]
example : antiPart sampleMatrix 1 0 = -1 := by norm_num [antiPart, sampleMatrix]
example : sampleMatrix = symPart sampleMatrix + antiPart sampleMatrix :=
  matrix_decomposition sampleMatrix

-- Independently, the repaired field constraint admits every constant matrix.
example : CoordinateConserved (fun _ => sampleMatrix) :=
  constant_coordinate_conserved sampleMatrix

#print axioms matrix_decomposition
#print axioms constant_coordinate_conserved
