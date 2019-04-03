%% Hillslope Hydro Data organization for water years 2015-2017

%Clear variables, load data, create hillslope hydro .mat
clearvars -except CalhounData
close all

load PrecipAndQData.mat %Data pulled from PrecipAndQAnalysis.m
load AllRunoffPrecip.mat %Data pulled from PrecipAndQAnalysis.m

%Save all data except CalhounData to a new .mat that will be added onto below
save HillslopeHydroData.mat -regexp ^(?!CalhounData)\w

%% Create Timetable Array with T1 well data (this code works but is commented out since output is loaded as .mat below)
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
        
    %Write temp variable data into overlapping indices in T1
    T1.(T1.Properties.VariableNames{i})(iOverlap) = tempWellData.level;
    
    %Find data gaps less than 1 hour and apply a linear interp
    iNotNaN = find(~isnan(T1.(T1.Properties.VariableNames{i}))); %Extract data that is not NaN
    notNaNDates = T1.Time(iNotNaN);
    
    diffDates = diff(notNaNDates); %Find interval between non-NaN data
    
    iStartGaps = []; iOrigStartGaps = []; iOrigEndGaps = []; iGaps = []; %#ok<NASGU>
    iStartGaps = find((diffDates > hours(1))); %Find starting index of gaps > 1 hr, pad with 0 so same length as iNotNaN
    iOrigStartGaps = iNotNaN(iStartGaps)+1; %Then convert to indices in original data for start of gap
    iOrigEndGaps = iNotNaN(iStartGaps+1)-1; %Get end of gap by incrementing up by one index
    iGaps = [iOrigStartGaps iOrigEndGaps]; %Concatenate
    
%     for j = 1:size(iGaps,1) %Check to make sure gaps are all NaN
%         sum(~isnan(T1.(T1.Properties.VariableNames{i})(iOrigStartGaps(j):iOrigEndGaps(j))))
%     end
    
    T1.(T1.Properties.VariableNames{i})(iNotNaN(1):iNotNaN(end)) = ... %Use fillmissing to linear interp within data range
        fillmissing(T1.(T1.Properties.VariableNames{i})(iNotNaN(1):iNotNaN(end)),'linear');
    
    for j = 1:size(iGaps,1) %Overwrite gaps with NaN
        T1.(T1.Properties.VariableNames{i})(iGaps(j,1):iGaps(j,2)) = NaN;
    end
      
end

%Add precip and runoff data to T1
T1 = synchronize(T1,allRunoffPrecip,'union','fillwithMissing');

%Append T1 onto HH data
save HillslopeHydroData.mat T1 -append

%% Create Timetable Array with T2 well data (this code works but is commented out since output is loaded as .mat below)
iWells = 9:14; %Indices of T2 wells in CalhounData

%Find start and stop dates for inclusive time range to fit all 6 wells
startDates = []; endDates = []; %Delete dates from previous transect
for i = 1:length(iWells)
    startDates(i) = CalhounData(iWells(i)).data.datetime(1); %#ok<*SAGROW>
    endDates(i) = CalhounData(iWells(i)).data.datetime(end);
end
startDate = datestr(min(startDates));
endDate = datestr(max(endDates));

%Create vector at 5 min resolution for that date range
timeVector = (datetime(startDate):minutes(5):datetime(endDate))';

%Create blank timetable to add well data into
T2 = NaN(length(timeVector),6);
T2 = array2table(T2);
T2 = table2timetable(T2,'RowTimes',timeVector);

%Create variable names that reflect each well and add to T2
wellNames = {'W1shal','W1deep','W2shal','W2deep','W3shal','W3deep'};
T2.Properties.VariableNames = wellNames;

%Add data from all 6 wells into T2
for i = 1:length(iWells)
    %Extract well data into a temp timetable
    tempWellData = CalhounData(iWells(i)).data(:,1:2);
    tempWellData.datetime = datetime(tempWellData.datetime,'ConvertFrom','datenum');
    tempWellData = table2timetable(tempWellData);
    
    %Make sure tempWellData is in even 5 min. time steps
    tempWellData.datetime.Second = 0;
    tempWellData.datetime.Minute = 5*(round(tempWellData.datetime.Minute/5));
    
    %Find intersecting dates between temp variable and T2
    [tempOverlap,iOverlap,~] = intersect(T2.Time,tempWellData.datetime);
        
    %Write temp variable data into overlapping indices in T2
    T2.(T2.Properties.VariableNames{i})(iOverlap) = tempWellData.level;
    
    %Find data gaps less than 1 hour and apply a linear interp
    iNotNaN = find(~isnan(T2.(T2.Properties.VariableNames{i}))); %Extract data that is not NaN
    notNaNDates = T2.Time(iNotNaN);
    
    diffDates = diff(notNaNDates); %Find interval between non-NaN data
    
    iStartGaps = []; iOrigStartGaps = []; iOrigEndGaps = []; iGaps = []; %#ok<NASGU>
    iStartGaps = find((diffDates > hours(1))); %Find starting index of gaps > 1 hr, pad with 0 so same length as iNotNaN
    iOrigStartGaps = iNotNaN(iStartGaps)+1; %Then convert to indices in original data for start of gap
    iOrigEndGaps = iNotNaN(iStartGaps+1)-1; %Get end of gap by incrementing up by one index
    iGaps = [iOrigStartGaps iOrigEndGaps]; %Concatenate
    
%     for j = 1:size(iGaps,1) %Check to make sure gaps are all NaN
%         sum(~isnan(T2.(T2.Properties.VariableNames{i})(iOrigStartGaps(j):iOrigEndGaps(j))))
%     end
    
    T2.(T2.Properties.VariableNames{i})(iNotNaN(1):iNotNaN(end)) = ... %Use fillmissing to linear interp within data range
        fillmissing(T2.(T2.Properties.VariableNames{i})(iNotNaN(1):iNotNaN(end)),'linear');
    
    for j = 1:size(iGaps,1) %Overwrite gaps with NaN
        T2.(T2.Properties.VariableNames{i})(iGaps(j,1):iGaps(j,2)) = NaN;
    end
      
end

%Add precip and runoff data to T2
T2 = synchronize(T2,allRunoffPrecip,'union','fillwithMissing');

%Append T2 onto HH data
save HillslopeHydroData.mat T2 -append

%% Create Timetable Array with Deep Well data (this code works but is commented out since output is loaded as .mat below)
DW = CalhounData(28).data(:,1:2);

%convert to timetable
DW = timetable(datetime(DW.datetime,'ConvertFrom','datenum'),DW.level);
DW.Properties.VariableNames = {'level'};
DW.Properties.VariableUnits = {'mm'};

%interpolate onto regular 5 min time series
DW5 = retime(DW,'regular','linear','TimeStep',minutes(5));

%Large data gaps (Determined manually):
%13-Apr-2016 21:20:00 -> 30-Apr-2016 19:20:00
%05-Aug-2016 05:00:00 -> 10-Aug-2016 13:00:00
%05-Oct-2016 02:20:00 -> 18-Oct-2016 13:20:00
dataGaps =... 
    {timerange('13-Apr-2016 21:20:00','30-Apr-2016 19:20:00','open')...
    timerange('05-Aug-2016 05:00:00','10-Aug-2016 13:00:00','open')...
    timerange('05-Oct-2016 02:20:00','18-Oct-2016 13:20:00','open')};

%Replace data gaps with NaNs
for i = 1:length(dataGaps)
    DW5.level(dataGaps{i}) = NaN;
end

%Add runoff and precip data
DW5 = synchronize(DW5,allRunoffPrecip,'union','fillwithMissing');

%Append DW5 onto HH data
save HillslopeHydroData.mat DW5 -append

%% Save all data except CalhounData as 
% save('AllWellData.mat','T1','T2','DW5');


%% Change in h vs Runoff

% %Create hourly data for well depth, runoff, and precip
% T1hourly = T1;
% T1hourly.runoff = T1hourly.runoff/12; %Convert from mm/hr to just depth of water over 5 min interval
% T1hourly.discharge = T1hourly.discharge*300; %Convert from L/s to just volume of water over 5 min interval
% T1hourly{:,1:8} = T1hourly{:,1:8}./12; %Divide well levels by 12 so that sum over hourly will = average depth 
% T1hourly = retime(T1hourly,'hourly',@sum);

