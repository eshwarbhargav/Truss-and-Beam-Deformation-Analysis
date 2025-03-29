%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%% Initializing....
clear vars; clc; close all
% --- 1. Pre-process
INPUT = input_model_1b;
% Adding path to core function files
addpath(strcat(cd,'/Functions'));
% --- 2. Solution
[ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT );
% --- 3. Post-process: recovery of forces, plot deformed shapes, ... 
ELEMENTS = force_recovery( MODEL, ELEMENTS,INPUT.solution );

%% Plotting

if strcmp( INPUT.solution,'static')
    scale=25;
    figure
    grid on
    hold on
    legend('show')
    for i = 1:length(INPUT.elements)
        x = [INPUT.nodes(ELEMENTS(i).nodes(1),2), INPUT.nodes(ELEMENTS(i).nodes(2),2)];
        y = [INPUT.nodes(ELEMENTS(i).nodes(1),3), INPUT.nodes(ELEMENTS(i).nodes(2),3)];
        plot(x,y,'b--','DisplayName',strcat('Actual\_E', num2str(i)));
    end
    
    for i = 1:length(INPUT.elements)
        x = [INPUT.nodes(ELEMENTS(i).nodes(1),2)+scale*MODEL.U_unc(ELEMENTS(i).nodes(1)*NODES(1).ndof-NODES(1).ndof+1), INPUT.nodes(ELEMENTS(i).nodes(2),2)+scale*MODEL.U_unc(ELEMENTS(i).nodes(2)*NODES(1).ndof-NODES(1).ndof+1)];
        y = [INPUT.nodes(ELEMENTS(i).nodes(1),3)+scale*MODEL.U_unc(ELEMENTS(i).nodes(1)*NODES(1).ndof-NODES(1).ndof+2), INPUT.nodes(ELEMENTS(i).nodes(2),3)+scale*MODEL.U_unc(ELEMENTS(i).nodes(2)*NODES(1).ndof-NODES(1).ndof+2)];
        plot(x,y,'r-','DisplayName',strcat('Deformed\_E', num2str(i)));
    end
    MODEL.U;
    MODEL.reaction_forces=MODEL.K_unc*MODEL.U_unc;

elseif strcmp( INPUT.solution,'eigenmodes')
    scale=1;
    for k = 1:size(MODEL.U,1)
        figure
        grid on
        hold on
        legend('show')
        title('Mode ');
        for i = 1:length(INPUT.elements)
            x = [INPUT.nodes(ELEMENTS(i).nodes(1),2), INPUT.nodes(ELEMENTS(i).nodes(2),2)];
            y = [INPUT.nodes(ELEMENTS(i).nodes(1),3), INPUT.nodes(ELEMENTS(i).nodes(2),3)];
            plot(x,y,'b--','DisplayName',strcat('Actual\_E', num2str(i)))
        end
        
        for i = 1:length(INPUT.elements)
            x = [INPUT.nodes(ELEMENTS(i).nodes(1),2)+scale*MODEL.U_unc(ELEMENTS(i).nodes(1)*NODES(1).ndof-NODES(1).ndof+1,k), INPUT.nodes(ELEMENTS(i).nodes(2),2)+scale*MODEL.U_unc(ELEMENTS(i).nodes(2)*NODES(1).ndof-NODES(1).ndof+1,k)];
            y = [INPUT.nodes(ELEMENTS(i).nodes(1),3)+scale*MODEL.U_unc(ELEMENTS(i).nodes(1)*NODES(1).ndof-NODES(1).ndof+2,k), INPUT.nodes(ELEMENTS(i).nodes(2),3)+scale*MODEL.U_unc(ELEMENTS(i).nodes(2)*NODES(1).ndof-NODES(1).ndof+2,k)];
            plot(x,y,'r-','DisplayName',strcat('Deformed\_E', num2str(i)))
        end
        hold off
    end
    sqrt(diag(MODEL.om));
end