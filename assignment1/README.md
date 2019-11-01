# Assignment 1: Coordinates and Height estimation from GNSS baselines using the Least-Squares Method

## Task 1: 1D-modelling

_heightEstConstants.m_
setting up P,A and f-matrix for height estimations

_heightEstimations.m_
- Estimating heights and corrections based on previously set up constants
- Error measures for height estimations

## Task 2: 3D-modelling

_coordEstConst.m_
sets up constants for
- known coordinates
- measured baselines
- A-matrix (designed)
- f-matrix (designed)
- Weight matrix (derived from variance)

Estimates coordinates
- with unit weight
- using weight matrix


_errorMeasures3d.m_
Errors for 3D-estimations


## Task 3: Simulation of unknown Heights
_heightSim.m_