% Callback functions
function Call_Back_plot(Mw, VS30, RJB, FM, FD, ax, Param_Max, Param_Min, Net_Save, fig)
    format long g
        % predict net
    Input_case_study=[FD;FM;Mw;RJB;VS30];
    % Inputs are normalized using the following equation: 0.60*(xi-xmin)/(xmax-xmin)+0.20
    Inputs_case_study_NML= 0.60*( (Input_case_study-Param_Min)./ (Param_Max-Param_Min) ) + 0.2;
    
    Num_Fold=10;
    Outputs_Mean_case_study = zeros(25,1);
    for i_Fold=1:Num_Fold
        Net_temp = Net_Save{i_Fold};
        Outputs_case_study = Net_temp(Inputs_case_study_NML);
        Outputs_Mean_case_study = Outputs_Mean_case_study+ Outputs_case_study/Num_Fold;
    end
    PGA       = round(exp(Outputs_Mean_case_study(1))*986,2);
    PGV       = round(exp(Outputs_Mean_case_study(2)),2);
    Ia        = round(exp(Outputs_Mean_case_study(3)),3);
    D_5_75    = round(exp(Outputs_Mean_case_study(4)),2);
    D_5_95    = round(exp(Outputs_Mean_case_study(5)),2);
    T_m       = round(exp(Outputs_Mean_case_study(6)),2);
    CAV       = round(exp(Outputs_Mean_case_study(7)),2);
    PSa_02sec = round(exp(Outputs_Mean_case_study(13))*986,2);
    PSa_05sec = round(exp(Outputs_Mean_case_study(17))*986,2);
    PSa_10sec = round(exp(Outputs_Mean_case_study(19))*986,2);
    PSa_20sec = round(exp(Outputs_Mean_case_study(21))*986,2);
    PSa_40sec = round(exp(Outputs_Mean_case_study(25))*986,2);
    
    % plot
    plotData(ax,exp(Outputs_Mean_case_study)*986)
    
    uieditfield(fig, 'numeric', 'Position', [325 490 50 20],'Value',PSa_02sec);
    uieditfield(fig, 'numeric', 'Position', [325 465 50 20], 'Value', PSa_05sec);
    uieditfield(fig, 'numeric', 'Position', [325 440 50 20], 'Value', PSa_10sec);
    uieditfield(fig, 'numeric', 'Position', [325 415 50 20], 'Value', PSa_20sec);
    uieditfield(fig, 'numeric', 'Position', [500 490 50 20], 'Value', PSa_40sec);
    uieditfield(fig, 'numeric', 'Position', [500 465 50 20], 'Value', PGA);
    uieditfield(fig, 'numeric', 'Position', [500 440 50 20], 'Value', PGV);
    uieditfield(fig, 'numeric', 'Position', [500 415 50 20], 'Value', CAV);
    uieditfield(fig, 'numeric', 'Position', [675 490 50 20], 'Value', Ia);
    uieditfield(fig, 'numeric', 'Position', [675 465 50 20], 'Value', T_m);
    uieditfield(fig, 'numeric', 'Position', [675 440 50 20], 'Value', D_5_75);
    uieditfield(fig, 'numeric', 'Position', [675 415 50 20], 'Value', D_5_95);

end
