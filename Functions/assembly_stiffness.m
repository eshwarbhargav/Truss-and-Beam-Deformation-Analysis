%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function MODEL = assembly_stiffness( ELEMENTS, MODEL )

% --- Assembly stiffness matrix 
for i = 1 : MODEL.nels
    
ptrs = ELEMENTS( i ).ptrs; 
K_el = ELEMENTS( i ).K_el;

MODEL.K( ptrs, ptrs ) = MODEL.K( ptrs, ptrs ) + K_el;
end