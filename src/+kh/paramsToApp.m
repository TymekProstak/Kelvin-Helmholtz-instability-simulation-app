function paramsToApp(app, params)
% Put parameters from params structure into GUI fields.
    app.UpperLayerVelocitEditField.Value = params.uUpper;
    app.LowerLayerVelocityEditField.Value = params.uLower;
    app.TimeofsimulationEditField.Value = params.tEnd;

    app.IntegratorTypeDropDown.Value = char(params.integrator);

    app.RegularizationValueEditField.Value = params.delta;
    app.InitilSheetLengthEditField.Value = params.L;
    app.DisturbanceModeDropDown.Value = params.perturbationMode;
    app.DisturbanceAmplitude.Value = params.amplitude;
end