%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function [ ELEMENTS, NODES, MODEL ] = analyze_structure( INPUT )

% --- Set model
[ ELEMENTS, NODES, MODEL ] = set_model( INPUT );
% --- Set pointers
ELEMENTS = set_pointers( ELEMENTS, NODES, MODEL.nels );
% --- Build element stiffness matrices
ELEMENTS = element_stiffness( ELEMENTS, NODES, MODEL.nels );
% --- Assembly stiffness matrix
MODEL = assembly_stiffness( ELEMENTS, MODEL );
% --- Impose constraints and solve 
MODEL = solve_structure( MODEL,INPUT );

end