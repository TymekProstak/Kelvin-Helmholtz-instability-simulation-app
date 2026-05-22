function stateNext = rk4Step(state, params)
% Perform one Runge-Kutta 4 integration step.

    dt = params.dt;

    % k1: velocity at the current state

    [k1x, k1y] =  kh.computeVelocity(state, params.delta,params.L);

    % k2:

    stateK2 = state;
    stateK2.x = state.x + 0.5 * dt * k1x;
    stateK2.y = state.y + 0.5 * dt * k1y;

    [k2x, k2y] =  kh.computeVelocity(state, params.delta,params.L);

    % k3: 
    stateK3 = state;
    stateK3.x = state.x + 0.5 * dt * k2x;
    stateK3.y = state.y + 0.5 * dt * k2y;

    [k3x, k3y] = kh.computeVelocity(state, params.delta,params.L);

    % k4: 

    stateK4 = state;
    stateK4.x = state.x + dt * k3x;
    stateK4.y = state.y + dt * k3y;

    [k4x, k4y] =  kh.computeVelocity(state, params.delta,params.L);

    % Final RK4 update

    stateNext = state;

    stateNext.x = state.x + dt * (k1x + 2*k2x + 2*k3x + k4x) / 6.0;
    stateNext.y = state.y + dt * (k1y + 2*k2y + 2*k3y + k4y) / 6.0;

    % epsilon and gamma stay unchanged.
    stateNext.epsilon = state.epsilon;
    stateNext.gamma = state.gamma;
end