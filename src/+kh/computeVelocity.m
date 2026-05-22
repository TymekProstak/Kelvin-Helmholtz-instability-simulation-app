function [vxTotal, vyTotal] = computeVelocity(state, delta,L)
% Compute total velocity of every vortex point in a sheet

    x = state.x;
    y = state.y;
    epsilon = state.epsilon;
    gamma = state.gamma;

    N = numel(x);

    vxTotal = zeros(1, N);
    vyTotal = zeros(1, N);

    for i = 1:N

        vxSum = 0.0;
        vySum = 0.0;

        for j = 2:N

            dEpsilon = epsilon(j) - epsilon(j - 1);

            vxij = kh.inducedVx( x(i), y(i), x(j), y(j), gamma(j), delta,L);

            vyij = kh.inducedVy( x(i), y(i), x(j), y(j), gamma(j), delta,L );

            vxSum = vxSum + vxij * dEpsilon;
            vySum = vySum + vyij * dEpsilon ;
        end

        vxTotal(i) = vxSum;
        vyTotal(i) = vySum;
    end
end