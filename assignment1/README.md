# Assignment 1: Coordinates and Height estimation from GNSS baselines using the Least-Squares Method

## Task 1: 1D-modelling

__heightEstConstants.m__ <br>
setting up P,A and f-matrix for height estimations

__heightEstimations.m__ <br>
- Estimating heights and corrections based on previously set up constants
- Error measures for height estimations

## Task 2: 3D-modelling

__coordEstConst.m__ <br>
sets up constants for
- known coordinates
- measured baselines
- A-matrix (designed)
- f-matrix (designed)
- Weight matrix (derived from variance)

Estimates coordinates
- with unit weight
- using weight matrix


__errorMeasures3d.m__ <br>
Errors for 3D-estimations


## Task 3: Simulation of unknown Heights
__heightSim.m__