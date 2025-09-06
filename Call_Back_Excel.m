% Callback functions
function Output=Call_Back_Excel(Mw, VS30, RJB, FM, FD, Param_Max, Param_Min, Net_Save)
format long g

    % predict net
    Input_case_study=[FD;FM;Mw;RJB;VS30];
    % Inputs are normalized using the following equation: 0.60*(xi-xmin)/(xmax-xmin)+0.20
        Inputs_case_study_NML= 0.60*( (Input_case_study-Param_Min)./ (Param_Max-Param_Min) ) + 0.2;
    
    Num_Fold=10;
    % Outputs_Mean_case_study = zeros(size(Target_case_study));
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
    PSa_003sec = round(exp(Outputs_Mean_case_study(8))*986,2);
    PSa_005sec = round(exp(Outputs_Mean_case_study(9))*986,2);
    PSa_0075sec = round(exp(Outputs_Mean_case_study(10))*986,2);
    PSa_01sec = round(exp(Outputs_Mean_case_study(11))*986,2);
    PSa_015sec = round(exp(Outputs_Mean_case_study(12))*986,2);
    PSa_02sec = round(exp(Outputs_Mean_case_study(13))*986,2);
    PSa_025sec = round(exp(Outputs_Mean_case_study(14))*986,2);
    PSa_03sec = round(exp(Outputs_Mean_case_study(15))*986,2);
    PSa_04sec = round(exp(Outputs_Mean_case_study(16))*986,2);
    PSa_05sec = round(exp(Outputs_Mean_case_study(17))*986,2);
    PSa_075sec = round(exp(Outputs_Mean_case_study(18))*986,2);
    PSa_10sec = round(exp(Outputs_Mean_case_study(19))*986,2);
    PSa_15sec = round(exp(Outputs_Mean_case_study(20))*986,2);
    PSa_20sec = round(exp(Outputs_Mean_case_study(21))*986,2);
    PSa_25sec = round(exp(Outputs_Mean_case_study(22))*986,2);
    PSa_30sec = round(exp(Outputs_Mean_case_study(23))*986,2);
    PSa_35sec = round(exp(Outputs_Mean_case_study(24))*986,2);
    PSa_40sec = round(exp(Outputs_Mean_case_study(25))*986,2);
Output=[PGA;PGV;Ia;D_5_75;D_5_95;T_m;CAV;PSa_003sec;PSa_005sec;PSa_0075sec;PSa_01sec;...
        PSa_015sec;PSa_02sec;PSa_025sec;PSa_03sec;PSa_04sec;PSa_05sec;PSa_075sec;PSa_10sec;
        PSa_15sec;PSa_20sec;PSa_25sec;PSa_30sec;PSa_35sec;PSa_40sec];
end
