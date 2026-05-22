function [G, dl, N0, dt, nSteps] = computeDerivedParams(L, uUpper, uLower, delta, tEnd)
% Compute numerical parameters for simulation.
% Inputs:
%   L       - domain length
%   uUpper  - upper-layer velocity
%   uLower  - lower-layer velocity
%   delta   - regularization parameter
%   tEnd    - final simulation time
%
% Outputs:
%   G       - total circulation
%   dl      - target spacing between vortex points
%   N0      - initial number of vortex points
%   dt      - time step
%   nSteps  - number of simulation steps

    G = (uUpper - uLower) * L;

    dl = 0.05 * delta;

    N0 = floor(L / dl);

    if N0 < 2
        N0 = 2;
    end

    dt = 0.250 * L * dl / abs(G);

    nSteps = floor(tEnd / dt);
end