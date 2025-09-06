function excelProcessorGUI( Param_Max, Param_Min, Net_Save)
    % Create the main figure window
    fig = figure('Name', 'GMM Processor', ...
                 'Position', [300, 100, 600, 400], ...
                 'NumberTitle', 'off', ...
                 'MenuBar', 'none', ...
                 'ToolBar', 'none', ...
                 'Resize', 'off');
    
    % Title
    uicontrol('Style', 'text', ...
              'String', 'GMM Processor', ...
              'Position', [200, 350, 300, 30], ...
              'FontSize', 18, ...
              'ForegroundColor','blue',...
              'FontWeight', 'bold');
    
    % Input file selection
    uicontrol('Style', 'text', ...
              'String', 'Input Excel File:', ...
              'Position', [20, 290, 180, 40], ...
              'HorizontalAlignment', 'left', ...
              'FontSize', 16, ...
              'FontWeight', 'bold');
    
    inputPathEdit = uicontrol('Style', 'edit', ...
                             'Position', [220, 300, 250, 25], ...
                             'HorizontalAlignment', 'left', ...
                             'BackgroundColor', 'white');
    
    browseButton = uicontrol('Style', 'pushbutton', ...
                            'String', 'Browse', ...
                            'Position', [490, 300, 80, 25], ...
                            'FontSize', 12, ...,
                            'Callback', @browseFile); %#ok<*NASGU> 
    
    % Process button
    processButton = uicontrol('Style', 'pushbutton', ...
                             'String', 'Process Excel File', ...
                             'Position', [220, 250, 180, 40], ...
                             'ForegroundColor','r',...
                             'FontSize', 14, ...,
                             'FontWeight', 'bold',...
                             'Callback', @processData);
    
    % Output file selection
    uicontrol('Style', 'text', ...
              'String', 'Output Excel File:', ...
              'Position', [20, 195, 190, 30], ...
              'HorizontalAlignment', 'left', ...
              'FontSize', 16, ...,
              'FontWeight', 'bold');
    
    outputPathEdit = uicontrol('Style', 'edit', ...
                              'Position', [220, 200, 250, 25], ...
                              'HorizontalAlignment', 'left', ...
                              'BackgroundColor', 'white');
    
%     % Status message area
    statusText = uicontrol('Style', 'text', ...
                          'String', 'Select an Excel file to process', ...
                          'Position', [140, 150, 500, 30], ...
                          'HorizontalAlignment', 'left', ...
                          'FontSize', 14, ...,
                          'ForegroundColor', [0.2, 0.2, 0.8]);
    
    % Results preview (if needed)
    uicontrol('Style', 'text', ...
              'String', 'Processing Log:', ...
              'Position', [50, 130, 160, 20], ...
              'HorizontalAlignment', 'left', ...
              'FontSize', 12, ...
              'FontWeight', 'bold');
    
    resultText = uicontrol('Style', 'edit', ...
                          'Max', 10, ...
                          'Min', 0, ...
                          'Position', [50, 20, 500, 100], ...
                          'HorizontalAlignment', 'left', ...
                          'BackgroundColor', [0.95, 0.95, 0.95], ...
                          'Style', 'listbox');
    
    % Store handles in a structure
    handles.inputPathEdit = inputPathEdit;
    handles.outputPathEdit = outputPathEdit;
    handles.statusText = statusText;
    handles.resultText = resultText;
    handles.fig = fig;
    
    % Store handles in the figure
    guidata(fig, handles);
    
    % File browser callback function
    function browseFile(~, ~)
        [filename, pathname] = uigetfile({'*.xlsx;*.xls', 'Excel Files (*.xlsx, *.xls)'}, ...
                                         'Select Excel File');
        if isequal(filename, 0)
            return; % User canceled
        end
        
        fullPath = fullfile(pathname, filename);
        handles = guidata(gcbo);
        set(handles.inputPathEdit, 'String', fullPath);
        
        % Auto-generate output filename
        [path, name, ~] = fileparts(fullPath);
        outputPath = fullfile(path, [name '_processed.xlsx']);
        set(handles.outputPathEdit, 'String', outputPath);
        
        set(handles.statusText, 'String', 'File selected. Click "Process Excel File" to continue.');
        set(handles.statusText, 'ForegroundColor', [0, 0.6, 0]);
    end

    % Output file selection callback
    function selectOutputFile(~, ~)
        handles = guidata(gcbo);
        inputPath = get(handles.inputPathEdit, 'String');
        
        if isempty(inputPath)
            errordlg('Please select an input file first.', 'Error');
            return;
        end
        
        [filename, pathname] = uiputfile({'*.xlsx', 'Excel File (*.xlsx)'; ...
                                         '*.csv', 'CSV File (*.csv)'; ...
                                         '*.mat', 'MAT File (*.mat)'}, ...
                                         'Save Output As', ...
                                         get(handles.outputPathEdit, 'String'));
        if isequal(filename, 0)
            return; % User canceled
        end
        
        fullPath = fullfile(pathname, filename);
        set(handles.outputPathEdit, 'String', fullPath);
    end

    % Process data callback function
    function processData(~, ~)
        handles = guidata(gcbo);
        inputPath = get(handles.inputPathEdit, 'String');
        outputPath = get(handles.outputPathEdit, 'String');
        
        % Validate inputs
        if isempty(inputPath)
            errordlg('Please select an input Excel file.', 'Error');
            return;
        end
        
        if ~exist(inputPath, 'file')
            errordlg('Input file does not exist.', 'Error');
            return;
        end
        
        if isempty(outputPath)
            errordlg('Please specify an output file.', 'Error');
            return;
        end
        
        set(handles.statusText, 'String', 'Processing...');
        set(handles.statusText, 'ForegroundColor', [0.8, 0.5, 0]);
        drawnow;
        
        try
            % Read the Excel file
            logMessage(handles, 'Reading Excel file...');
            [numData, txtData, rawData] = xlsread(inputPath); %#ok<*XLSRD> 
        
            logMessage(handles, sprintf('File contains %d rows and %d columns', size(rawData, 1), size(rawData, 2)));
            
            % Process the data (this is a sample processing step)
            % You can replace this with your specific processing requirements
            logMessage(handles, 'Processing data...');
            
            % Example: Calculate statistics for numeric columns
%             results = struct();

            if ~isempty(numData)

                for i=1:size(numData,1)
                    Mw   = numData(i,1);
                    VS30 = numData(i,2);
                    RJB  = numData(i,3);
                    FD   = numData(i,4);
                    FM   = numData(i,5);
                    Input(i,:)=[Mw, VS30, RJB, FM, FD]; %#ok<*AGROW> 
                    Output=Call_Back_Excel(Mw, VS30, RJB, FM, FD, Param_Max, Param_Min, Net_Save);
                    results(i,:)=Output';
                end
                
                logMessage(handles, 'Calculated IMs for defined input data');
            end
            
            % Example: Count text entries
            if ~isempty(txtData)
                textStats = cellfun(@(x) sum(cellfun(@(y) ischar(y) && ~isempty(y), x)), ...
                                   {txtData}, 'UniformOutput', false);
                logMessage(handles, sprintf('Processed %d text entries', textStats{1}));
            end
            
                    logMessage(handles, sprintf('Results saved to Excel file: %s', outputPath));
                    
                    filename = 'Resutls.xlsx';
                    sheet = 'Resutls';
                    xlRange = 'E2';
                    xlswrite(filename,results,sheet,xlRange); %#ok<*XLSWT> 
                     xlRange = 'A2';
                    xlswrite(filename,Input,sheet,xlRange);
            
            set(handles.statusText, 'String', 'Processing completed successfully!');
            set(handles.statusText, 'ForegroundColor', [0, 0.6, 0]);
            
        catch ME
            errordlg(sprintf('Error processing file: %s', ME.message), 'Error');
            logMessage(handles, sprintf('Error: %s', ME.message));
            set(handles.statusText, 'String', 'Error processing file');
            set(handles.statusText, 'ForegroundColor', [0.8, 0, 0]);
        end
    end

    % Helper function to add messages to the log
    function logMessage(handles, message)
        currentTime = datestr(now, 'HH:MM:SS');
        fullMessage = sprintf('[%s] %s', currentTime, message);
        
        currentContent = get(handles.resultText, 'String');
        if isempty(currentContent)
            newContent = {fullMessage};
        elseif ischar(currentContent)
            newContent = {currentContent; fullMessage};
        else
            newContent = [currentContent; {fullMessage}];
        end
        
        set(handles.resultText, 'String', newContent);
        set(handles.resultText, 'Value', length(newContent)); % Auto-scroll to bottom
        drawnow;
    end
end
