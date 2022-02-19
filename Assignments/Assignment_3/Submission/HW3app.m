classdef HW3APP < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        PRNEditFieldLabel             matlab.ui.control.Label
        PRNEditField                  matlab.ui.control.EditField
        SamplingFreqHZEditFieldLabel  matlab.ui.control.Label
        SamplingFreqHZEditField       matlab.ui.control.EditField
        IntermediateFreqHZEditFieldLabel  matlab.ui.control.Label
        IntermediateFreqHZEditField   matlab.ui.control.EditField
        msecofdataEditFieldLabel      matlab.ui.control.Label
        msecofdataEditField           matlab.ui.control.EditField
        StartProcessingButton         matlab.ui.control.Button
        msectoAverageEditFieldLabel   matlab.ui.control.Label
        msectoAverageEditField        matlab.ui.control.EditField
        StartAnimationButton          matlab.ui.control.Button
        UIAxes                        matlab.ui.control.UIAxes
        UIAxes_2                      matlab.ui.control.UIAxes
        UIAxes_3                      matlab.ui.control.UIAxes
        UIAxes2                       matlab.ui.control.UIAxes
        UIAxes3                       matlab.ui.control.UIAxes
        UIAxes4                       matlab.ui.control.UIAxes
        UIAxes4_2                     matlab.ui.control.UIAxes
        UIAxes4_3                     matlab.ui.control.UIAxes
        UIAxes4_4                     matlab.ui.control.UIAxes
        UIAxes5                       matlab.ui.control.UIAxes
        UIAxes6                       matlab.ui.control.UIAxes
        AmplitudeDataLabel            matlab.ui.control.Label
        FrequencyLabel                matlab.ui.control.Label
        AnimationLabel                matlab.ui.control.Label
        InputsforProcessingLabel      matlab.ui.control.Label
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changed function: SamplingFreqHZEditField
        function SamplingFreqHZEditFieldValueChanged(app, event)
            value = app.SamplingFreqHZEditField.Value;
            
        end

        % Button pushed function: StartProcessingButton
        function StartProcessingButtonPushed(app, event)
            prn = app.PRNEditField.Value;
            msec_to_process = app.msecofdataEditField.Value;
            fs = app.SamplingFreqHZEditField.Value;
            intfreq = app.IntermediateFreqHZEditField.Value;
            
            [e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq] = findandtrack(prn, msec_to_process, fs, intfreq);
            plotresults(app, e_i,e_q,p_i,p_q,l_i,l_q,carrierfq,codefq);
        end

        % Button pushed function: StartAnimationButton
        function StartAnimationButtonPushed(app, event)
            avgnum = app.msectoAverageEditField.Value;
            corrplot(app, avgnum)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1023 663];
            app.UIFigure.Name = 'UI Figure';

            % Create PRNEditFieldLabel
            app.PRNEditFieldLabel = uilabel(app.UIFigure);
            app.PRNEditFieldLabel.HorizontalAlignment = 'right';
            app.PRNEditFieldLabel.Position = [69 611 31 22];
            app.PRNEditFieldLabel.Text = 'PRN';

            % Create PRNEditField
            app.PRNEditField = uieditfield(app.UIFigure, 'text');
            app.PRNEditField.Position = [49 590 71 22];

            % Create SamplingFreqHZEditFieldLabel
            app.SamplingFreqHZEditFieldLabel = uilabel(app.UIFigure);
            app.SamplingFreqHZEditFieldLabel.HorizontalAlignment = 'right';
            app.SamplingFreqHZEditFieldLabel.Position = [31 560 114 22];
            app.SamplingFreqHZEditFieldLabel.Text = 'Sampling Freq. (HZ)';

            % Create SamplingFreqHZEditField
            app.SamplingFreqHZEditField = uieditfield(app.UIFigure, 'text');
            app.SamplingFreqHZEditField.ValueChangedFcn = createCallbackFcn(app, @SamplingFreqHZEditFieldValueChanged, true);
            app.SamplingFreqHZEditField.Position = [49 539 71 22];

            % Create IntermediateFreqHZEditFieldLabel
            app.IntermediateFreqHZEditFieldLabel = uilabel(app.UIFigure);
            app.IntermediateFreqHZEditFieldLabel.HorizontalAlignment = 'right';
            app.IntermediateFreqHZEditFieldLabel.Position = [22 505 131 22];
            app.IntermediateFreqHZEditFieldLabel.Text = 'Intermediate Freq. (HZ)';

            % Create IntermediateFreqHZEditField
            app.IntermediateFreqHZEditField = uieditfield(app.UIFigure, 'text');
            app.IntermediateFreqHZEditField.Position = [49 484 71 22];

            % Create msecofdataEditFieldLabel
            app.msecofdataEditFieldLabel = uilabel(app.UIFigure);
            app.msecofdataEditFieldLabel.HorizontalAlignment = 'right';
            app.msecofdataEditFieldLabel.Position = [48 450 74 22];
            app.msecofdataEditFieldLabel.Text = 'msec of data';

            % Create msecofdataEditField
            app.msecofdataEditField = uieditfield(app.UIFigure, 'text');
            app.msecofdataEditField.Position = [49 429 71 22];

            % Create StartProcessingButton
            app.StartProcessingButton = uibutton(app.UIFigure, 'push');
            app.StartProcessingButton.ButtonPushedFcn = createCallbackFcn(app, @StartProcessingButtonPushed, true);
            app.StartProcessingButton.Position = [33 384 104 22];
            app.StartProcessingButton.Text = 'Start Processing';

            % Create msectoAverageEditFieldLabel
            app.msectoAverageEditFieldLabel = uilabel(app.UIFigure);
            app.msectoAverageEditFieldLabel.HorizontalAlignment = 'right';
            app.msectoAverageEditFieldLabel.Position = [101 177 95 22];
            app.msectoAverageEditFieldLabel.Text = 'msec to Average';

            % Create msectoAverageEditField
            app.msectoAverageEditField = uieditfield(app.UIFigure, 'text');
            app.msectoAverageEditField.Position = [112 144 71 22];

            % Create StartAnimationButton
            app.StartAnimationButton = uibutton(app.UIFigure, 'push');
            app.StartAnimationButton.ButtonPushedFcn = createCallbackFcn(app, @StartAnimationButtonPushed, true);
            app.StartAnimationButton.Position = [215 144 100 22];
            app.StartAnimationButton.Text = 'Start Animation';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Title')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            app.UIAxes.Position = [224 359 201 121];

            % Create UIAxes_2
            app.UIAxes_2 = uiaxes(app.UIFigure);
            title(app.UIAxes_2, 'Title')
            xlabel(app.UIAxes_2, 'X')
            ylabel(app.UIAxes_2, 'Y')
            app.UIAxes_2.Position = [462 359 201 121];

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.UIFigure);
            title(app.UIAxes_3, 'Title')
            xlabel(app.UIAxes_3, 'X')
            ylabel(app.UIAxes_3, 'Y')
            app.UIAxes_3.Position = [224 484 439 159];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Title')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            app.UIAxes2.Position = [705 492 272 159];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Title')
            xlabel(app.UIAxes3, 'X')
            ylabel(app.UIAxes3, 'Y')
            app.UIAxes3.Position = [705 345 272 148];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.UIFigure);
            title(app.UIAxes4, 'Title')
            xlabel(app.UIAxes4, 'X')
            ylabel(app.UIAxes4, 'Y')
            app.UIAxes4.Position = [331 198 176 139];

            % Create UIAxes4_2
            app.UIAxes4_2 = uiaxes(app.UIFigure);
            title(app.UIAxes4_2, 'Title')
            xlabel(app.UIAxes4_2, 'X')
            ylabel(app.UIAxes4_2, 'Y')
            app.UIAxes4_2.Position = [331 47 176 139];

            % Create UIAxes4_3
            app.UIAxes4_3 = uiaxes(app.UIFigure);
            title(app.UIAxes4_3, 'Title')
            xlabel(app.UIAxes4_3, 'X')
            ylabel(app.UIAxes4_3, 'Y')
            app.UIAxes4_3.Position = [516 198 176 139];

            % Create UIAxes4_4
            app.UIAxes4_4 = uiaxes(app.UIFigure);
            title(app.UIAxes4_4, 'Title')
            xlabel(app.UIAxes4_4, 'X')
            ylabel(app.UIAxes4_4, 'Y')
            app.UIAxes4_4.Position = [516 51 176 139];

            % Create UIAxes5
            app.UIAxes5 = uiaxes(app.UIFigure);
            title(app.UIAxes5, 'Title')
            xlabel(app.UIAxes5, 'X')
            ylabel(app.UIAxes5, 'Y')
            app.UIAxes5.Position = [691 185 300 153];

            % Create UIAxes6
            app.UIAxes6 = uiaxes(app.UIFigure);
            title(app.UIAxes6, 'Title')
            xlabel(app.UIAxes6, 'X')
            ylabel(app.UIAxes6, 'Y')
            app.UIAxes6.Position = [691 47 300 143];

            % Create AmplitudeDataLabel
            app.AmplitudeDataLabel = uilabel(app.UIFigure);
            app.AmplitudeDataLabel.Position = [263 633 88 22];
            app.AmplitudeDataLabel.Text = 'Amplitude Data';

            % Create FrequencyLabel
            app.FrequencyLabel = uilabel(app.UIFigure);
            app.FrequencyLabel.Position = [752 633 62 22];
            app.FrequencyLabel.Text = 'Frequency';

            % Create AnimationLabel
            app.AnimationLabel = uilabel(app.UIFigure);
            app.AnimationLabel.Position = [366 336 59 22];
            app.AnimationLabel.Text = 'Animation';

            % Create InputsforProcessingLabel
            app.InputsforProcessingLabel = uilabel(app.UIFigure);
            app.InputsforProcessingLabel.Position = [31 633 118 22];
            app.InputsforProcessingLabel.Text = 'Inputs for Processing';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = HW3APP

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end
