function stateNext = simulationStep(state, params)
% Perform one full simulation step.

    if params.integrator == "Euler"

        stateNext = kh.eulerStep(state, params);

    elseif params.integrator == "RK4"

        stateNext = kh.rk4Step(state, params);
    end

    % Add new points if the vortex sheet stretches too much.
      stateNext = kh.rediscretizeSheet(stateNext, params);
    
end