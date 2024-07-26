function [trial] = parsetrial(text)
%PARSETRIAL Reads in the text segment related to a single trial and
%extracts values for expected fields into a struct.
%   To-do
% - have a warning message if the text doesn't have "trialNum" included
% - add a way to handle multiple touch points, currently not extracting
% that data


% Get Trial number
TriggersPattern = 'TrialNum\s+:\s(\d+)';
data = regexp(text, TriggersPattern, 'tokens');
trial.trialNum = str2double(cell2mat(data{1}));

% Get Startpad Touched TimePoint
TriggersPattern = 'Startpad Touched TimePoint\s+:\s+(\d+.\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.startpadTouchedTimePoint = NaN;
else
    trial.startpadTouchedTimePoint = str2double(cell2mat(data{1}));
end

% Ready Start TimePoint
TriggersPattern = 'Ready Start TimePoint\s+:\s+(\d+.\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.readyStartTimePoint = NaN;
else
    trial.readyStartTimePoint = str2double(cell2mat(data{1}));
end

% Ready Interface Time
TriggersPattern = 'Ready Interface Time\s+:\s+(\d+.\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.readyInterfaceTime = NaN;
else
    trial.readyInterfaceTime = str2double(cell2mat(data{1}));
end

% Cue Start TimePoint
TriggersPattern = 'Cue Start TimePoint\s+:\s+(\d+.\d+)|Cue Start TimePoint\s+:\s+(\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.cueStartTimePoint = NaN;
else
    trial.cueStartTimePoint = str2double(cell2mat(data{1}));
end

% Cue Interface Time
TriggersPattern = 'Cue Interface Time\s+:\s+(\d+.\d+)|Cue Interface Time\s+:\s+(\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.cueInterfaceTime = NaN;
else
    trial.cueInterfaceTime = str2double(cell2mat(data{1}));
end

% Target Start TimePoint
TriggersPattern = 'Target Start TimePoint\s+:\s+(\d+.\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.targetStartTimePoint = NaN;
else
    trial.targetStartTimePoint = str2double(cell2mat(data{1}));
end

% TargetType
TriggersPattern = 'TargetType\s+:\s+(\w+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.targetType = 'N/A';
else
    trial.targetType = data{1,1}{1,1};
end

% TargetPositionIndex  
TriggersPattern = 'TargetPositionIndex\s+:\s+(\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.targetPositionIndex = NaN;
else
    trial.targetPositionIndex = str2double(cell2mat(data{1}));
end

% Startpad Left TimePoint
TriggersPattern = 'Startpad Left TimePoint\s+:\s+(\d+.\d+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.startpadLeftTimePoint = NaN;
else
    trial.startpadLeftTimePoint = str2double(cell2mat(data{1}));
end

% Get Trial Result
TriggersPattern = 'Trial Result\s+:\s+(\w+),\s(\w+)';
data = regexp(text, TriggersPattern, 'tokens');
if isempty(data)
    trial.result = 'N/A';
    trial.resultDetail = 'N/A';
else
    trial.result = data{1,1}{1,1};
    trial.resultDetail = data{1,1}{1,2};
end


end

