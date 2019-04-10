%% Figures for Ch2, based on HillslopeHydroAnalysis.m
%Clear figs/variables and load data
clearvars -except CalhounData
close all

load HillslopeHydroData.mat %Data from HillslopeHydroDataPrep.m

%General figure properties
myFontsize = 18;

pColor = [31 120 180]./255;
petColor = [51,160,44]./255;
rColor = [227,26,28]./255;
r2Color = [128,177,211]./255;
sColor = [255,127,0]./255;
sDelColor = [253,191,111]./255;
DWColor = [152,78,163]./255;

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
        25,relS5min.relS(iWY2016EX));
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
    cbha = colorbar;
    ylabel(cbha,'relS(mm)')
    saveas(a,sprintf('HHFigs/T1%sRun.tif',T1.Properties.VariableNames{i}))
    
%     %Semilog axes
%     figure
%     b = scatter(tempTable.runoff(iWY2016EX),tempTable.(T1.Properties.VariableNames{i})(iWY2016EX),...
%         25,datenum(tempTable.Time(iWY2016EX)));
%     set(gca,'FontSize',myFontsize,'XScale','log')
%     xlim([0.1 100])
%     ylabel('Depth to WT (mm)','FontSize',myFontsize)
%     xlabel('Runoff (mm/hr)','FontSize',myFontsize)
%     title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
%     cbhb = colorbar('Direction','reverse');
%     cbhb.TickLabels = cellstr(datestr(cbhb.Ticks,'mmddyy'));
%     saveas(b,sprintf('T1%s_LOG',T1.Properties.VariableNames{i}),'epsc')
%     close all
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
    a = scatter(tempTable.runoff(iWY2016EX),tempTable.(T1.Properties.VariableNames{i})(iWY2016EX),...
        25,relS5min.relS(iWY2016EX));
    set(gca,'FontSize',myFontsize)
    ylabel('Depth to WT (mm)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(T1.Properties.VariableNames{i},'FontSize',myFontsize)
    cbha = colorbar;
    ylabel(cbha,'relS(mm)')
    saveas(a,sprintf('HHFigs/T2%sRun.tif',T1.Properties.VariableNames{i}))
    
    %Semilog axes
%     figure
%     b = scatter(tempTable.runoff(iWY2016EX),tempTable.(T2.Properties.VariableNames{i})(iWY2016EX),...
%         25,datenum(tempTable.Time(iWY2016EX)));
%     set(gca,'FontSize',myFontsize,'XScale','log')
%     xlim([0.1 100])
%     ylabel('Depth to WT (mm)','FontSize',myFontsize)
%     xlabel('Runoff (mm/hr)','FontSize',myFontsize)
%     title(T2.Properties.VariableNames{i},'FontSize',myFontsize)
%     cbhb = colorbar('Direction','reverse');
%     cbhb.TickLabels = cellstr(datestr(cbhb.Ticks,'mmddyy'));
%     saveas(b,sprintf('T2%s_LOG',T2.Properties.VariableNames{i}),'epsc')
%     close all
end

%% Deep well time series

a = figure;
plot(DW5.Time(iWY2016EX),DW5.level(iWY2016EX),'b.')
set(gca,'FontSize',myFontsize)
ylim([-6000 0]);
ylabel('Depth to WT (mm)','FontSize',myFontsize)
title('Deep Well','FontSize',myFontsize)

saveas(a,'HHFigs/DWTS.tif')
%     close all

%% Deep well TS vs Q weighted by storage

%Plot well depth v runoff, weighted by relS
figure
a = scatter(DW5.runoff(iWY2016EX),DW5.level(iWY2016EX),25,relS5min.relS(iWY2016EX));
set(gca,'FontSize',myFontsize)
ylabel('Depth to WT (mm)','FontSize',myFontsize)
xlabel('Runoff (mm/hr)','FontSize',myFontsize)
title('Deep Well','FontSize',myFontsize)
cb = colorbar;
ylabel(cb,'relS (mm)','FontSize',myFontsize) %Colorbar label
ylim([-6000 0]);

saveas(a,'HHFigs/DWRun.tif')

%% TS of storage with same storage coloring for reference

figure
a = scatter(relS5min.datetime(iWY2016EX),relS5min.relS(iWY2016EX),25,relS5min.relS(iWY2016EX));
set(gca,'FontSize',myFontsize)
ylabel('relS (mm)','FontSize',myFontsize)
cb = colorbar;
ylabel(cb,'relS (mm)','FontSize',myFontsize) %Colorbar label


%% TSs of Soil moisture 
%CSP1
figure 
plot(soilWaterP1.Time(iWY2016EX),soilWaterP1.shal(iWY2016EX)...
    ,soilWaterP1.Time(iWY2016EX),soilWaterP1.mid(iWY2016EX)...
    ,soilWaterP1.Time(iWY2016EX),soilWaterP1.deep(iWY2016EX));
ylim([0 0.5]);
ylabel('Volumetric WC (m3/m3)','FontSize',myFontsize)
title('Soil Pit 1: Ridge','FontSize',myFontsize)
legend('shal','mid','deep');

saveas(gcf,'HHFigs/SP1TS.tif')

%CSP2
figure 
plot(soilWaterP2.Time(iWY2016EX),soilWaterP2.shal(iWY2016EX)...
    ,soilWaterP2.Time(iWY2016EX),soilWaterP2.mid(iWY2016EX)...
    ,soilWaterP2.Time(iWY2016EX),soilWaterP2.deep(iWY2016EX));
ylim([0 0.5]);
ylabel('Volumetric WC (m3/m3)','FontSize',myFontsize)
title('Soil Pit 2: Midslope','FontSize',myFontsize)
legend('shal','mid','deep');

saveas(gcf,'HHFigs/SP2TS.tif')

%CSP3
figure 
plot(soilWaterP3.Time(iWY2016EX),soilWaterP3.shal(iWY2016EX)...
    ,soilWaterP3.Time(iWY2016EX),soilWaterP3.mid(iWY2016EX)...
    ,soilWaterP3.Time(iWY2016EX),soilWaterP3.deep(iWY2016EX));
ylim([0 0.5]);
ylabel('Volumetric WC (m3/m3)','FontSize',myFontsize)
title('Soil Pit 3: Riparian','FontSize',myFontsize)
legend('shal','mid','deep');

saveas(gcf,'HHFigs/SP3TS.tif')

%% VWC vs Runoff
%Well depth names
depthNames = {'Shal','Mid','Deep'};

%CSP1
for i = 1:3
    figure
    a = scatter(DW5.runoff(iWY2016EX),soilWaterP1{iWY2016EX,i},25,relS5min.relS(iWY2016EX));
    set(gca,'FontSize',myFontsize)
    ylabel('VWC (m3/m3)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(sprintf('SP1: Ridge,%s',depthNames{i}),'FontSize',myFontsize)
    cb = colorbar;
    ylabel(cb,'relS (mm)','FontSize',myFontsize) %Colorbar label
    ylim([0 0.5]);
    
    saveas(gcf,sprintf('HHFigs/SP1%sRun.tif',depthNames{i}))
end

%CSP2
for i = 1:3
    figure
    a = scatter(DW5.runoff(iWY2016EX),soilWaterP2{iWY2016EX,i},25,relS5min.relS(iWY2016EX));
    set(gca,'FontSize',myFontsize)
    ylabel('VWC (m3/m3)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(sprintf('SP2: Midslope,%s',depthNames{i}),'FontSize',myFontsize)
    cb = colorbar;
    ylabel(cb,'relS (mm)','FontSize',myFontsize) %Colorbar label
    ylim([0 0.5]);
    
    saveas(gcf,sprintf('HHFigs/SP2%sRun.tif',depthNames{i}))
end

%CSP3
for i = 1:3
    figure
    a = scatter(DW5.runoff(iWY2016EX),soilWaterP3{iWY2016EX,i},25,relS5min.relS(iWY2016EX));
    set(gca,'FontSize',myFontsize)
    ylabel('VWC (m3/m3)','FontSize',myFontsize)
    xlabel('Runoff (mm/hr)','FontSize',myFontsize)
    title(sprintf('SP3: Riparian,%s',depthNames{i}),'FontSize',myFontsize)
    cb = colorbar;
    ylabel(cb,'relS (mm)','FontSize',myFontsize) %Colorbar label
    ylim([0 0.5]);
    
    saveas(gcf,sprintf('HHFigs/SP3%sRun.tif',depthNames{i}))
end


%% Watershed scale water balance components

figure
set(gcf,'defaultAxesColorOrder',[0 0 0; 0 0 0])
% set(gcf,'Units','inches','Position',[0,0,6.5,7.56])

subplot(6,1,1:2) 

yyaxis left
bar(allDataDaily.datetime(iWY2016EX),allDataDaily.precip(iWY2016EX)...
    ,'EdgeColor',pColor,'FaceColor',pColor); %Precip on first axis
set(gca,'ydir','reverse','ylim',[0 200])
ylabel('Precip (mm/d)','fontsize',myFontsize)

yyaxis right
plot(allDataDaily.datetime(iWY2016EX),allDataDaily.runoff(iWY2016EX)...
    ,'Color',r2Color,'LineWidth',1) %Runoff on next
set(gca,'ylim',[0 100])
ylabel('Runoff (mm/d)','fontsize',myFontsize)

DailyXAxisRange = get(gca,'xlim');

%Then plot runoff on logged axis with hyet same as above
subplot(6,1,3:4)

yyaxis left
bar(allDataDaily.datetime(iWY2016EX),allDataDaily.precip(iWY2016EX)...
    ,'EdgeColor',pColor,'FaceColor',pColor); %Precip on first axis
set(gca,'ydir','reverse','ylim',[0 200])
ylabel('Precip (mm/d)','fontsize',myFontsize)

yyaxis right
semilogy(allDataDaily.datetime(iWY2016EX),allDataDaily.runoff(iWY2016EX)...
    ,'Color',r2Color,'LineWidth',1) %Logged runoff on next
set(gca,'ylim',[0.1 100])
ylabel('Runoff (mm/d)','fontsize',myFontsize)

%Then water balance residuals
subplot(6,1,5)
plot(allPETMonthly.months(iWY2016EX),allPETMonthly.PET(iWY2016EX)...
    ,'Color',petColor,'LineWidth',2) %Exclude right edge
set(gca,'xlim',DailyXAxisRange)
ylabel('PET (mm/d)','fontsize',myFontsize)

subplot(6,1,6)
plot(allDataDaily.datetime(iWY2016EX),allDataDaily.relS(iWY2016EX)...
    ,'Color',sColor,'LineWidth',2)
set(gca,'xlim',DailyXAxisRange)
ylabel('RelS (mm/d)','fontsize',myFontsize)