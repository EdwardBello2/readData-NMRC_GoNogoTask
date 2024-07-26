
% to-do

%% Specify inputs and outputs 

% Specify the txt files to be converted into excel sheets
disp('User selecting .txt files...')
[infile, inpath] = uigetfile('./.txt', 'Select .txt files of recordings', 'Multiselect', 'on');
disp('Got em!')

% Specify the name & location of the output excel file
disp('User specifying output excel sheet...')
[outfile, outpath] = uiputfile('*.xlsx', 'Save new excel file or overwrite existing');



%% Export data from each file into separate sheets of the user-designated excel file

disp('Converting text files...')
nSheets = length(infile);
for iSheet = 1:nSheets
    % Get all text from a given recording text file
    inText = fileread([inpath infile{1,iSheet}]);
    
    % Convert all relevant trial data into a table
    [trialInfoTab] = gettrialinfotab(inText);
    
    % Export tabular data to the corresponding excel sheet
    [~,sheetName,~] = fileparts(infile{1,iSheet});
%     sheetName = file{1,iSheet};
    writetable(trialInfoTab,'test.xlsx','sheet',sheetName,'Range','A1');
    
end

disp('Complete!')
% % Read in one txt file
% % File to be read in:
% fn = 'Zebel-20221003-095928.txt';
% 
% 
% % Read in text file to one long character vector
% pn = 'C:\Users\bello043\Downloads\';
% inText = fileread([pn fn]);
% 
% % Specify excel sheet name
%  writetable(Tab1,filename,'sheet',sheet,'Range','A1')
%  sheet = 2;
%  writetable(Tab2,filename,'sheet',sheet,'Range','A1')



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



