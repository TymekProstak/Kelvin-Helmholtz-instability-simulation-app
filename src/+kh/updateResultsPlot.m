function updateResultsPlot(app)
%UPDATERESULTSPLOT Draw current vortex sheet state.

    if isempty(app.State)
        return;
    end

    plot(app.VortexSheetAxes, app.State.x, app.State.y, "-o");

    grid(app.VortexSheetAxes, "on");
    axis(app.VortexSheetAxes, "normal");

    xlabel(app.VortexSheetAxes, "x");
    ylabel(app.VortexSheetAxes, "y");

    title(app.VortexSheetAxes, sprintf( ...
        "Kelvin-Helmholtz vortex sheet | step = %d | t = %.4f s | N = %d", ...
        app.CurrentStep, ...
        app.CurrentTime, ...
        numel(app.State.x)));

    xMin = min(app.State.x);
    xMax = max(app.State.x);
    
    xRange = xMax - xMin;
    xMargin = 0.1 * xRange;
    
    if xMargin == 0
        xMargin = 0.1;
    end

    xlim(app.VortexSheetAxes, [xMin - xMargin, xMax + xMargin]);

    yMax = max(abs(app.State.y));
    yLimit =  1.2 * yMax ;

    ylim(app.VortexSheetAxes, [-yLimit, yLimit]);

    drawnow limitrate;
end