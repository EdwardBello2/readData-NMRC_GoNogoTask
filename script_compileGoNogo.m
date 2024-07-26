% Author: Ed Bello
%
% This script asks the user for one or more .txt files that the GoNogo task
% outputs, and compiles reach-trial data* into excel file format. Each sheet 
% in the excel file is dedicated to each different .txt file (i.e. one
% sheet per recording). The excel file will name each sheet according to 
% the txt file name(s) chosen by user. 
%
% How to use: 
% 1) After opening this script in Matlab, press "Run" in the "EDITOR" tab. 
% 2) The first dialog box will open asking for .txt files. Navigate to whichever
% folder all your .txt files of interest are and select file(s). If more
% than one file is desired, just hold SHIFT or CTRL. 
% 3) Next a 2nd dialog box will appear asking you to specify a name and
% location for the compiled excel file. If you create an excel file of the 
% same name as an existing one, this script will overwrite the original
% excel file (close out the target excel sheet if overwriting, otherwise
% the code will throw a "file open by another application" error).
%
% * Currently some parts of trial data in each .txt are not converted; ask Ed if there's
% more you want extracted from the text files!



%% Specify inputs and outputs 

% Specify the txt files to be converted into excel sheets
disp('User selecting .txt files...')
[temp, inpath] = uigetfile('/.txt', 'Select .txt files of recordings', 'Multiselect', 'on');
% Make sure the infile variable is a cell type
if ~iscell(temp)
    infile = {temp};
    
else
    infile = temp;
    
end

if infile{1,1} == 0, error('User must specify at least one file!'); end

disp('Got em!')

% Specify the name & location of the output excel file
disp('User specifying output excel sheet...')
[outfile, outpath] = uiputfile('*.xlsx', 'Save new excel file or overwrite existing');

% 

%% Export data from each file into separate sheets of the user-designated excel file

disp('Converting text files...')
nSheets = length(infile);    
for iSheet = 1:nSheets
    disp([num2str(iSheet) ' of ' num2str(nSheets)])
    % Get all text from a given recording text file
    inText = fileread([inpath infile{1,iSheet}]);
    
    % Convert all relevant trial data into a table
    [trialInfoTab] = gettrialinfotab(inText);
    
    % Export tabular data to the corresponding excel sheet
    [~,sheetName,~] = fileparts(infile{1,iSheet});
%     sheetName = file{1,iSheet};
    writetable(trialInfoTab,[outpath outfile],'sheet',sheetName,'Range','A1');
    
end

disp('Complete!')
