function stateNext = eulerStep(state, params)
% Perform one Euler integration step.

    % Compute velocity of every vortex point.
    [vx, vy] = kh.computeVelocity(state, params.delta,params.L);
    
    % Update positions.
    stateNext.x = state.x + params.dt * vx;
    stateNext.y = state.y + params.dt * vy;

    % epsilon and gamma stay unchanged.
    stateNext.epsilon = state.epsilon;
    stateNext.gamma = state.gamma;
end