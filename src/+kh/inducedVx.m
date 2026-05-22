function value = inducedVx(xi, yi, xj, yj, gammaj, delta,L)
% Compute x-velocity induced by vortex point j on point i.

    dy = (yi - yj)/L;
    dx = (xi - xj)/L;
    
    numerator = -0.5 * gammaj * sinh(2.0 * pi * dy);

    denominator = cosh(2.0 * pi * dy) - cos(2.0 * pi * dx) + delta^2;

    value = numerator / denominator;

end