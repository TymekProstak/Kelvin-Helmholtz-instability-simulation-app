# Kelvin-Helmholtz Instability MATLAB App

Interactive MATLAB App Designer project for simulation and visualization of the Kelvin-Helmholtz instability.

The project is based on the original C++ implementation available here:

<https://github.com/TymekProstak/Fundusz-Zdolni-computational-physics/tree/main/kelvin_hemholtz_instablity>

The MATLAB version is intended as a simpler, interactive and  version of the original C++ vortex-sheet simulation. The app allows the user to change selected physical parameters, run the simulation in real time, pause it, reset it, and export the obtained results.

---

## Project Description

The application simulates the Kelvin-Helmholtz instability, which appears at the interface between two fluid layers moving with different velocities.

The interface between the fluids is modeled as a discrete vortex sheet. The sheet is represented by a set of vortex points. Each point moves according to the velocity induced by the remaining points.

The app provides:

- real-time animation of the vortex sheet,
- choice of the time integration method: Euler or RK4,
- choice of initial perturbation: sinusoidal or random,
- automatic computation of the time step and initial discretization,
- export of results to a MATLAB `.mat` file,
- export of the animation to a video file.

---

## Physical Model

The two fluid layers move with velocities:

```math
u_1
```

and

```math
u_2
```

The total circulation of the vortex sheet is computed as:

```math
G = (u_1 - u_2)L
```

where:

- `G` is the total circulation,
- `u1` is the upper-layer velocity,
- `u2` is the lower-layer velocity,
- `L` is the initial length of the vortex sheet.

If `u1 = u2`, then there is no velocity jump and the instability is not generated in this simplified model.

---

## Vortex Sheet Representation

Each vortex point is described by:

```text
x        horizontal position
y        vertical position
epsilon  parameter along the sheet
gamma    circulation density
```

In MATLAB, the state is stored as:

```matlab
state.x
state.y
state.epsilon
state.gamma
```

---

## Initial Condition

The initial sheet is almost flat. The horizontal position is:

```math
x_i = \frac{iL}{N-1}
```

The sheet is disturbed by a small perturbation.

For sinusoidal perturbation:

```math
y_i = A \sin(2\pi\epsilon_i)
```

For random perturbation:

```math
y_i = A r_i, \qquad r_i \in [-1,1]
```

where:

```math
\epsilon_i = \frac{i}{N-1}
```

and `A` is the perturbation amplitude.

---

## Induced Velocity

For two vortex points:

```math
(x_i, y_i)
```

and

```math
(x_j, y_j)
```

the regularized denominator is:

```math
D_{ij}
=
\cosh\left(2\pi(y_i-y_j)\right)
-
\cos\left(2\pi(x_i-x_j)\right)
+
\delta^2
```

The induced horizontal velocity is:

```math
u_{x,ij}
=
-\frac{1}{2}\gamma_j
\frac{
\sinh\left(2\pi(y_i-y_j)\right)
}{
D_{ij}
}
```

The induced vertical velocity is:

```math
u_{y,ij}
=
\frac{1}{2}\gamma_j
\frac{
\sin\left(2\pi(x_i-x_j)\right)
}{
D_{ij}
}
```

The parameter `delta` is the regularization parameter. Larger `delta` gives smoother results. Smaller `delta` allows sharper structures, but increases computational cost.

---

## Motion of Vortex Points

The velocity of one point is obtained by summing the influence of all vortex points:

```math
\frac{dx_i}{dt}
\approx
\sum_j u_{x,ij}\Delta\epsilon_j
```

```math
\frac{dy_i}{dt}
\approx
\sum_j u_{y,ij}\Delta\epsilon_j
```

where:

```math
\Delta\epsilon_j = \epsilon_j - \epsilon_{j-1}
```

Because every point interacts with every other point, the computational complexity is approximately:

```math
\mathcal{O}(N^2)
```

---

## Time Integration

The app allows two integration methods.

### Euler Method

```math
X_{n+1} = X_n + \Delta t f(X_n)
```

Euler is simple and fast, but less accurate.

### Fourth-Order Runge-Kutta Method

```math
k_1 = f(X_n)
```

```math
k_2 = f\left(X_n + \frac{1}{2}\Delta t k_1\right)
```

```math
k_3 = f\left(X_n + \frac{1}{2}\Delta t k_2\right)
```

```math
k_4 = f\left(X_n + \Delta t k_3\right)
```

```math
X_{n+1}
=
X_n
+
\frac{\Delta t}{6}
\left(
k_1 + 2k_2 + 2k_3 + k_4
\right)
```

RK4 is the recommended default method.

---

## Automatically Computed Parameters

The target distance between neighboring points is:

```math
\Delta l = 0.05\delta
```

The initial number of vortex points is:

```math
N = \left\lfloor \frac{L}{\Delta l} \right\rfloor
```

with:

```math
N \geq 2
```

The time step is:

```math
\Delta t
=
0.250
\frac{L\Delta l}{|G|}
```

The number of simulation steps is:

```math
N_{steps}
=
\left\lfloor
\frac{T}{\Delta t}
\right\rfloor
```

where `T` is the selected simulation time.

---

## User Parameters

The user can set:

| Parameter | Symbol | Description |
|---|---:|---|
| Domain length | `L` | Initial sheet length |
| Upper velocity | `u1` | Velocity of the upper layer |
| Lower velocity | `u2` | Velocity of the lower layer |
| Simulation time | `T` | Physical duration of simulation |
| Regularization | `delta` | Smoothing parameter |
| Perturbation amplitude | `A` | Initial disturbance size |
| Perturbation type | `mode` | `sin` or `noise` |
| Integrator | — | `Euler` or `RK4` |

The app computes:

| Quantity | Symbol |
|---|---:|
| Total circulation | `G` |
| Target spacing | `Delta l` |
| Initial point count | `N` |
| Time step | `dt` |
| Number of steps | `Nsteps` |

---

## Rediscretization

During the simulation, the vortex sheet stretches. If two neighboring points become too far apart, a new point is inserted between them.

The new point is placed at the midpoint:

```math
x_{new} = \frac{x_i+x_{i-1}}{2}
```

```math
y_{new} = \frac{y_i+y_{i-1}}{2}
```

```math
\epsilon_{new} = \frac{\epsilon_i+\epsilon_{i-1}}{2}
```

```math
\gamma_{new} = \frac{\gamma_i+\gamma_{i-1}}{2}
```

---

##  Repository Structure

```text
.
├── KelvinHelmholtzApp.mlapp
├── README.md
├── src/
│   ├── makeDefaultParams.m
│   ├── computeDerivedParams.m
│   ├── initializeVortexSheet.m
│   ├── computeTotalCirculation.m
│   ├── inducedVx.m
│   ├── inducedVy.m
│   ├── computeVelocity.m
│   ├── eulerStep.m
│   ├── rk4Step.m
│   ├── simulationStep.m
│   ├── rediscretizeSheet.m
│   └── saveResultsMat.m
├── results/
└── figures/
```

---

## Bibliography

[1] Robert Krasny,  
**Desingularization of Periodic Vortex Sheet Roll-up**,  
Journal of Computational Physics, Volume 65, Issue 2, 1986, pp. 292-313.  
DOI: `10.1016/0021-9991(86)90210-X`

[2] Kelvin-Helmholtz instability,  
Wikipedia, accessed: 31.05.2024.  
<https://en.wikipedia.org/wiki/Kelvin%E2%80%93Helmholtz_instability>
