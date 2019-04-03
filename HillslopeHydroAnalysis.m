%% Hillslope Hydro for water years 2015-2017

%Clear variables, load data from HillslopeHydroData
clearvars -except CalhounData
close all

% load PrecipAndQData.mat %Data pulled from PrecipAndQAnalysis.m
% load AllRunoffPrecip.mat %Data pulled from PrecipAndQAnalysis.m
% load AllWellData.mat %Output of HillslopeHydroAnalysis.m

%% Change in h vs Runoff

% %Create hourly data for well depth, runoff, and precip
% T1hourly = T1;
% T1hourly.runoff = T1hourly.runoff/12; %Convert from mm/hr to just depth of water over 5 min interval
% T1hourly.discharge = T1hourly.discharge*300; %Convert from L/s to just volume of water over 5 min interval
% T1hourly{:,1:8} = T1hourly{:,1:8}./12; %Divide well levels by 12 so that sum over hourly will = average depth 
% T1hourly = retime(T1hourly,'hourly',@sum);

