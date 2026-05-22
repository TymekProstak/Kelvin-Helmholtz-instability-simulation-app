# Kelvin–Helmholtz Instability Simulator

This project is an interactive MATLAB App Designer application for simulating the Kelvin–Helmholtz instability.

The application models the interface between two fluid layers moving with different horizontal velocities. The interface is represented as a discrete vortex sheet. Each point of the sheet behaves like a vortex marker whose motion is computed from the velocity induced by all other vortices.

The user can change simulation parameters from the graphical interface, such as:

- upper-layer flow velocity,
- lower-layer flow velocity,
- regularization parameter delta,
- simulation time step,
- perturbation type,
- initial perturbation amplitude,
- number of initial vortex points.

The app allows real-time animation, starting and stopping the simulation, and exporting results to a video file or MATLAB `.mat` file containing the interface position history.

The numerical model is based on a regularized periodic vortex-sheet formulation and uses the fourth-order Runge–Kutta/Euler method for time integration.
