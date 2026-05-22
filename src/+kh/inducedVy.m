function value = inducedVy(xi, yi, xj, yj, gammaj, delta,L)
% Compute y-velocity induced by vortex point j on point i.

    dy = (yi - yj)/L;
    dx = (xi - xj)/L;

    numerator = 0.5 * gammaj * sin(2.0 * pi * dx);

    denominator = cosh(2.0 * pi * dy)  - cos(2.0 * pi * dx) + delta^2;

    value = numerator / denominator;
end