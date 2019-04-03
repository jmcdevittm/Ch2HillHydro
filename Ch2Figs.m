%% Figures for Ch2, based on HillslopeHydroAnalysis.m
%Clear figs/variables and load data
clearvars -except CalhounData
close all

load HillslopeHydroData.mat %Data from HillslopeHydroDataPrep.m

%General figure properties
myFontsize = 18;

%Create index for WY2016 extended into the previous summer
iWY2016EX = timerange('01-Jul-2015 00:00:00','01-Oct-2016 00:00:00');

%% WT depth and Q for T1; Full depth range; Linear and semilog axes

for i = 1:8 %8 wells in T1
    %Synchronize runoff with well
    tempTable = synchronize(T1(:,i),allRunoffPrecip(:,2),'intersection','fillwithmissing');
    
    %Plot well depth v runoff
    %Linear axes
    figure
    a = scatter(tempTable.runoff(iWY2016EX),tempTable.(T1.Properties.VariableNames{i})(iWY2016EX),...
        25,datenum(tempTable.Time(iWY2016EX)));
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
    cbha = colorbar('Direction','reverse');
    cbha.TickLabels = cellstr(datestr(cbha.Ticks,'mmddyy'));
    saveas(a,sprintf('T1%s',T1.Properties.VariableNames{i}),'epsc')
    
    %Semilog axes
    figure
    b = scatter(tempTable.runoff(iWY2016EX),tempTable.(T1.Properties.VariableNames{i})(iWY2016EX),...
        25,datenum(tempTable.Time(iWY2016EX)));
    set(gca,'FontSize',myFontsize,'XScale','log')
    xlim([0.1 100])
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
    cbhb = colorbar('Direction','reverse');
    cbhb.TickLabels = cellstr(datestr(cbhb.Ticks,'mmddyy'));
    saveas(b,sprintf('T1%s_LOG',T1.Properties.VariableNames{i}),'epsc')
    close all
end

%% WT depth and Q for T1; Common depth axis for each well nest except 1; only semilog axes

depthRange = [NaN -500 -900 -600]; %Depth range to plot for well nests 2-4
for i = 1:8 %8 wells in T1
    %Synchronize runoff with well
    tempTable = synchronize(T1(:,i),allRunoffPrecip(:,2),'intersection','fillwithmissing');
    
    %Plot well depth v runoff
    
    %Semilog axes
    figure
    b = scatter(tempTable.runoff(iWY2016EX),tempTable.(T1.Properties.VariableNames{i})(iWY2016EX),...
        25,datenum(tempTable.Time(iWY2016EX)));
    set(gca,'FontSize',myFontsize,'XScale','log')
    xlim([0.1 100])
    if i > 2 %only rescale depth range for nests 2-4
        iNest = ceil(i/2); %Find which well nest well is in
        ylim([depthRange(iNest) 0])
    end
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
    cbhb = colorbar('Direction','reverse');
    cbhb.TickLabels = cellstr(datestr(cbhb.Ticks,'mmddyy'));
    saveas(b,sprintf('%s_LOGcommonY',T1.Properties.VariableNames{i}),'epsc')
    close all
end
%% Well time series, T1

for i = 1:2:7
    
    a = figure;
    plot(T1.Time(iWY2016EX),T1.(T1.Properties.VariableNames{i})(iWY2016EX),'b.',... %Shallow well
        T1.Time(iWY2016EX),T1.(T1.Properties.VariableNames{i+1})(iWY2016EX),'r.')    %Deep well
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    title(sprintf('T1 Well Nest %i',(i+1)/2),'FontSize',myFontsize)
    
    saveas(a,sprintf('TST1WellNest%i',(i+1)/2),'epsc')
%     close all
end

%% Well time series, T2

for i = 1:2:5
    
    a = figure;
    plot(T2.Time(iWY2016EX),T2.(T2.Properties.VariableNames{i})(iWY2016EX),'b.',... %Shallow well
        T2.Time(iWY2016EX),T2.(T2.Properties.VariableNames{i+1})(iWY2016EX),'r.')    %Deep well
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    title(sprintf('T2 Well Nest %i',(i+1)/2),'FontSize',myFontsize)
    
    saveas(a,sprintf('TST2WellNest%i',(i+1)/2),'epsc')
%     close all
end
        
%% WT depth and Q for T2

for i = 1:6 %6 wells in T2
    %Synchronize runoff with well
    tempTable = synchronize(T2(:,i),allRunoffPrecip(:,2),'intersection','fillwithmissing');
    
    %Plot well depth v runoff
    %Linear axes
    figure
    a = scatter(tempTable.runoff(iWY2016EX),tempTable.(T2.Properties.VariableNames{i})(iWY2016EX),...
        25,datenum(tempTable.Time(iWY2016EX)));
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T2.Properties.VariableNames{i},'FontSize',myFontsize)
    cbha = colorbar('Direction','reverse');
    cbha.TickLabels = cellstr(datestr(cbha.Ticks,'mmddyy'));
    saveas(a,sprintf('T2%s',T2.Properties.VariableNames{i}),'epsc')
    
    %Semilog axes
    figure
    b = scatter(tempTable.runoff(iWY2016EX),tempTable.(T2.Properties.VariableNames{i})(iWY2016EX),...
        25,datenum(tempTable.Time(iWY2016EX)));
    set(gca,'FontSize',myFontsize,'XScale','log')
    xlim([0.1 100])
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T2.Properties.VariableNames{i},'FontSize',myFontsize)
    cbhb = colorbar('Direction','reverse');
    cbhb.TickLabels = cellstr(datestr(cbhb.Ticks,'mmddyy'));
    saveas(b,sprintf('T2%s_LOG',T2.Properties.VariableNames{i}),'epsc')
%     close all
end

%% Deep well TS

a = figure;
plot(DW5.Time(iWY2016EX),DW5.level(iWY2016EX),'b.')
set(gca,'FontSize',myFontsize)
ylim([-6000 0]);
ylabel('Depth to WT (mm)','FontSize',myFontsize)
title('Deep Well','FontSize',myFontsize)

saveas(a,'DeepWell','tiff')
%     close all