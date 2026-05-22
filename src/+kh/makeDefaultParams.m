function params = makeDefaultParams()
%  Create default simulation parameters based on C++ tested set.

    % Physical parameters

    params.L = 1.0;              % initial vortex sheet length
    params.uUpper = 2.0;         % upper-layer flow velocity
    params.uLower = 1.0;         % lower-layer flow velocity
    params.tEnd = 5.0;           % final simulation time

    % Numerical model parameters

    params.delta = 0.25;         % regularization parameter
    params.amplitude = 0.001;    % initial perturbation amplitude

    % Simulation options

    params.perturbationMode = "sin";   % "sin" or "noise"
    params.integrator = "RK4";         % "Euler" or "RK4"

    params.enableRediscretization = true;  % add new points when the sheet stretches
    params.plotEvery = 5;                  % update plot every N simulation steps

    % Constants for discretization

    params.targetSpacingFactor = 0.05;     % dl = 0.05 * delta
    params.timeStepFactor = 0.250;         % dt = 0.250 * L * dl / abs(G)
    params.criticalSpacingFactor = 1.25;   % rediscretization threshold factor

    % Automatically computed fields

    [params.G, params.dl, params.N0, params.dt, params.nSteps] = ...
        kh.computeDerivedParams( ...
            params.L, ...
            params.uUpper, ...
            params.uLower, ...
            params.delta, ...
            params.tEnd ...
        );

end