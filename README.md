# readData-NMRC_GoNogoTask
Code in matlab for parsing and reading in the data related to touchscreen task software runs of NMRC_GoNogoTask_wpf-1.2, specifically the text output files. 


To run the code, open "script_compileGoNogo.m" in Matlab:
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