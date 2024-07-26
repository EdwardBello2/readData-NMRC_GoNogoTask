
% to-do




% Read in one txt file
% File to be read in:
fn = 'Zebel-20221003-095928.txt';


% Read in text file to one long character vector
pn = 'C:\Users\bello043\Downloads\';
inText = fileread([pn fn]);


%% Break up the text into header info and trial-specific info

% Get vector indices for all instances of TrialNum text
nChars = length(inText);
isTrialNum = false(1,nChars);
ch = 'TrialNum';
nCh = length(ch);
for iChar = 1:(nChars-nCh-1)
    % Check if "ch" is detected at the index "iChar"
    isMatch = strcmp(inText(iChar:iChar+nCh-1), ch);
    
    if isMatch, isTrialNum(iChar) = true; end
    
end

% break up text into separate cells -- first cell has header info, then
% each next one has trial info
idxTrialNum = find(isTrialNum);

headerText = inText(1:idxTrialNum(1)-1);

% gather text segments into a cell array accoring to num of trials
nTrials = length(idxTrialNum);
trialText = cell(1,nTrials);
for iTrial = 1:(nTrials-1)
    trialText{iTrial} = inText(idxTrialNum(iTrial):idxTrialNum(iTrial+1));
    
end
% handle the case for the last trial
trialText{nTrials} = inText(idxTrialNum(nTrials):end);



%% Get specific info from each trial

% create a struct with values parsed from each trial
for iTrial = 1:nTrials

% Get Trial number
TriggersPattern = 'TrialNum\s+:\s(\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Get Startpad Touched TimePoint
TriggersPattern = 'Startpad Touched TimePoint\s+:\s+(\d+.\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Ready Start TimePoint
TriggersPattern = 'Ready Start TimePoint\s+:\s+(\d+.\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Ready Interface Time
TriggersPattern = 'Ready Interface Time\s+:\s+(\d+.\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Cue Start TimePoint
TriggersPattern = 'Cue Start TimePoint\s+:\s+(\d+.\d+)|Cue Start TimePoint\s+:\s+(\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Cue Interface Time
TriggersPattern = 'Cue Interface Time\s+:\s+(\d+.\d+)|Cue Interface Time\s+:\s+(\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Target Start TimePoint
TriggersPattern = 'Target Start TimePoint\s+:\s+(\d+.\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% TargetType
TriggersPattern = 'TargetType\s+:\s+(\w+)';
data = regexp(inText, TriggersPattern, 'tokens');

% TargetPositionIndex  
TriggersPattern = 'TargetPositionIndex\s+:\s+(\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Startpad Left TimePoint
TriggersPattern = 'Startpad Left TimePoint\s+:\s+(\d+.\d+)';
data = regexp(inText, TriggersPattern, 'tokens');

% Get Trial Result
TriggersPattern = 'Trial Result\s+:\s+(\w+),\s(\w+)';
data = regexp(inText, TriggersPattern, 'tokens');

end

