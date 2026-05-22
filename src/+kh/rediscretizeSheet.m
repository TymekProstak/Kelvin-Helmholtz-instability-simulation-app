function stateOut = rediscretizeSheet(stateIn, params)
% Add new points if the vortex sheet is too stretched by adding point in the middle.
    x = stateIn.x;
    y = stateIn.y;
    epsilon = stateIn.epsilon;
    gamma = stateIn.gamma;
    % l_target = 0.05 * delta
    % l_critical^2 = 1.25 * l_target^2
    lTarget = params.targetSpacingFactor * params.delta;
    lCriticalSquared = params.criticalSpacingFactor * lTarget^2;

    i = 2;

    while i <= numel(x)

        dx = x(i) - x(i - 1);
        dy = y(i) - y(i - 1);

        distanceSquared = dx^2 + dy^2;

        if distanceSquared > lCriticalSquared

            % New point inserted between point i-1 and point i.
            newX = 0.5 * (x(i) + x(i - 1));
            newY = 0.5 * (y(i) + y(i - 1));
            newEpsilon = 0.5 * (epsilon(i) + epsilon(i - 1));
            newGamma = 0.5 * (gamma(i) + gamma(i - 1));

            x = [x(1:i-1), newX, x(i:end)];
            y = [y(1:i-1), newY, y(i:end)];
            epsilon = [epsilon(1:i-1), newEpsilon, epsilon(i:end)];
            gamma = [gamma(1:i-1), newGamma, gamma(i:end)];

            % I do not increase i here.
            % The new segment should be checked again.

        else

            i = i + 1;
        end
        
    end

    stateOut.x = x;
    stateOut.y = y;
    stateOut.epsilon = epsilon;
    stateOut.gamma = gamma;
end