function state = initializeVortexSheet(params)
% Create initial vortex sheet.
%   state.x       - x positions of vortex points
%   state.y       - y positions of vortex points
%   state.epsilon - sheet parameter from 0 to 1
%   state.gamma   - circulation density

    N = params.N0;
    L = params.L;

    % Parameter along the vortex sheet.
    epsilon = linspace(0.0, 1.0, N);

    % Initial x positions.
    x = linspace(0.0, L, N);

    % Initial y positions.
    y = zeros(1, N);

    if params.perturbationMode == "sin"

        y = params.amplitude * sin(2.0 * pi * epsilon);

    elseif params.perturbationMode == "noise"

        y = params.amplitude * (2.0 * rand(1, N) - 1.0);

    end

    % Keep both ends on y = 0 
    y(1) = 0.0;
    y(end) = 0.0;

    % Uniform circulation distribution
    gamma = params.G * ones(1, N);

    % Vortex state structure.
    state.x = x;
    state.y = y;
    state.epsilon = epsilon;
    state.gamma = gamma;
end