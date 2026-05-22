function logSimulationStart(app)
% Print initial simulation information to GUI console.

    kh.appendLog(app, "Simulation started.", "INFO");

    kh.appendLog(app, sprintf( "L = %.4g, uUpper = %.4g, uLower = %.4g", app.Params.L, app.Params.uUpper, app.Params.uLower),"INFO");

    kh.appendLog(app, sprintf( "delta = %.4g, G = %.4g, dl = %.4g",app.Params.delta, app.Params.G, app.Params.dl),"INFO");

    kh.appendLog(app, sprintf("N0 = %d, dt = %.6g, nSteps = %d", app.Params.N0, app.Params.dt, app.Params.nSteps),"INFO");

    kh.appendLog(app, sprintf( "integrator = %s, perturbation = %s, amplitude = %.4g", string(app.Params.integrator), string(app.Params.perturbationMode), app.Params.amplitude),"INFO");
end