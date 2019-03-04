%% Hillslope Hydro for water years 2015-2017

%Clear variables, load data, etc
clearvars -except CalhounData
close all

load AllRunoffPrecip.mat %Data pulled from PrecipAndQAnalysis.m

%% Create Timetable Array with T1 well data
%Find start and stop dates for inclusive time range to fit all 8 wells
for i = 1:8
    startDates(i) = CalhounData(i).data.datetime(1); %#ok<*SAGROW>
    endDates(i) = CalhounData(i).data.datetime(end);
end
startDate = datestr(min(startDates));
endDate = datestr(max(endDates));

%Create vector at 5 min resolution for that date range
timeVector = (datetime(startDate):minutes(5):datetime(endDate))';

%Create blank timetable to add well data into
T1 = NaN(length(timeVector),8);
T1 = array2table(T1);
T1 = table2timetable(T1,'RowTimes',timeVector);

%Create variable names that reflect each well and add to T1
wellNames = {'W1shal','W1deep','W2shal','W2deep','W3shal','W3deep','W4shal','W4deep'};
T1.Properties.VariableNames = wellNames;

%Add data from all 8 wells into T1
for i = 1:8
    %Extract well data into a temp timetable
    tempWellData = CalhounData(i).data(:,1:2);
    tempWellData.datetime = datetime(tempWellData.datetime,'ConvertFrom','datenum');
    tempWellData = table2timetable(tempWellData);
    
    %Make sure tempWellData is in even 5 min. time steps
    tempWellData.datetime.Second = 0;
    tempWellData.datetime.Minute = 5*(round(tempWellData.datetime.Minute/5));
    
    %Find intersecting dates between temp variable and T1
    [tempOverlap,iOverlap,~] = intersect(T1.Time,tempWellData.datetime);
    
    length(tempOverlap) == height(tempWellData)
    
    %Write temp variable data into overlapping indices in T1
    T1.(T1.Properties.VariableNames{i})(iOverlap) = tempWellData.level;
end

%% Prelim figs of WT depth and Q
