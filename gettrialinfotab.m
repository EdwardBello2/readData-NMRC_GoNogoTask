function [trialInfoTab] = gettrialinfotab(inText)
%GETTRIALINFOTAB Generate a matlab table of all trial info for a given
%recording from GoNogo task software, based on the text file generated.
%Input must be a character array of all text from the .txt file.
%   Detects individual segments of text pertaining to each "trial" of
%   reaching based on looking for where the phrase "trialNum" occurs in the text
%   file. For now all header info is ignored, and some metadata from trial
%   info has also been ignored.



%% Break up the text into header info and trial-specific info
% ignore header text for now

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

for iTrial = 1:nTrials
    trialInfoStruct(iTrial) = parsetrial(trialText{1,iTrial});
    
end



%% Export all trial data into a Table

trialInfoTab = struct2table(trialInfoStruct);





end

