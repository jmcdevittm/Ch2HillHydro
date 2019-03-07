%% Figures for Ch2, based on HillslopeHydroAnalysis.m
%Clear figs and open data
close all

load AllRunoffPrecip.mat %Data pulled from PrecipAndQAnalysis.m
load AllWellData.mat %Output of HillslopeHydroAnalysis.m

%% Prelim figs of WT depth and Q for T1

for i = 1 %8 wells in T1
    %Synchronize runoff with well
    tempTable = synchronize(T1(:,i),allRunoffPrecip(:,2),'intersection','fillwithmissing');
    
    %Plot well depth v runoff
    figure
    plot(tempTable.(T1.Properties.VariableNames{i}),tempTable.runoff,'.')
    
    figure
    semilogy(tempTable.(T1.Properties.VariableNames{i}),tempTable.runoff,'.')
end
