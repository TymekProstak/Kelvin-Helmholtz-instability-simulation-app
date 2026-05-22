function params = appToParams(app)
%  Read GUI fields and create simulation parameters.

    params = kh.makeDefaultParams();

    % Read values from GUI.
    params.uUpper = app.UpperLayerVelocitEditField.Value;
    params.uLower = app.LowerLayerVelocityEditField.Value;
    params.tEnd = app.TimeofsimulationEditField.Value;
    params.integrator = string(app.IntegratorTypeDropDown.Value);
    params.delta = app.RegularizationValueEditField.Value;
    params.L = app.InitilSheetLengthEditField.Value;

    params.perturbationMode = app.DisturbanceModeDropDown.Value;
    params.amplitude = app.DisturbanceAmplitude.Value;

    % Recompute derived values after reading GUI.
    [params.G, params.dl, params.N0, params.dt, params.nSteps] = ...
        kh.computeDerivedParams( ...
            params.L, ...
            params.uUpper, ...
            params.uLower, ...
            params.delta, ...
            params.tEnd ...
        );
end