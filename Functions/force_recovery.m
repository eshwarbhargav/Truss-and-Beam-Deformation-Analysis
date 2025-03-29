%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function ELEMENTS = force_recovery( MODEL, ELEMENTS,solution )

if strcmp( solution,'static')
    
    % --- Force recovery
    for i = 1 : MODEL.nels
        
        T = ELEMENTS(i).T;
        ptrs = ELEMENTS(i).ptrs;
        
        U_el_loc = T * MODEL.U_unc( ptrs );
        
        nodal_forces = ELEMENTS(i).K_el_loc * U_el_loc;
        
        %(take force in node 2: >0 in traction)
        ELEMENTS(i).nodal_forces = nodal_forces(2);
        
    end
    
elseif strcmp( solution,'eigenmodes')
    MODEL.U_unc_f=0;
    for j=1:max(size(MODEL.om)) %considering time=0 (so exp(j*om*t)=1)
        MODEL.U_unc_f=MODEL.U_unc_f+MODEL.U_unc(:,j);
    end
    for i = 1 : MODEL.nels
        
        T = ELEMENTS(i).T;
        ptrs = ELEMENTS(i).ptrs;
        
        U_el_loc = T * MODEL.U_unc_f( ptrs );
        
        nodal_forces = ELEMENTS(i).K_el_loc * U_el_loc;
        
        %(take force in node 2: >0 in traction)
        ELEMENTS(i).nodal_forces = nodal_forces(2);
        
    end
    
end