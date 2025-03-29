%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function [ ELEMENTS, NODES, MODEL ] = set_model( INPUT )

ELEMENTS=struct();
for i=1:length(INPUT.elements)
    
    ELEMENTS(i).nodes=INPUT.elements(i,1:end-1);
    ELEMENTS(i).EA=INPUT.E*INPUT.section_prop(1);
    ELEMENTS(i).EJ=INPUT.E*INPUT.section_prop(2);
    if INPUT.section_prop(1,end) == 0
        ELEMENTS(i).type = 'truss';
        ELEMENTS(i).dofs = 4;
    else
        ELEMENTS(i).type = 'beam';
        ELEMENTS(i).dofs = 6;
    end
    ELEMENTS(i).ptrs= '(filled later)';
    ELEMENTS(i).K_el_loc= '(filled later)';
    ELEMENTS(i).K_el= '(filled later)';
    ELEMENTS(i).l= '(filled later)';
    ELEMENTS(i).alpha= '(filled later)';
    ELEMENTS(i).T= '(filled later)';
    ELEMENTS(i).nodal_forces= '(filled later)';
end

NODES=struct();
for i=1:length(INPUT.nodes)
    NODES(i).coord_x=INPUT.nodes(i,2);
    NODES(i).coord_y=INPUT.nodes(i,3);
    if INPUT.section_prop(1,end) == 0
        NODES(i).ndof=2; %truss
    else
        NODES(i).ndof=3; %beams
    end
end

MODEL = struct(); 

MODEL.ndof= length(NODES)*NODES(1).ndof;
MODEL.nels=length(ELEMENTS); 
MODEL.nnodes=length(NODES);
MODEL.K=zeros(MODEL.ndof); 
MODEL.F=zeros(MODEL.ndof,1); 
for i = 1:size(INPUT.load,1)
    j=INPUT.load(i,1)*NODES(i).ndof-NODES(i).ndof;
    k=INPUT.load(i,2);
    MODEL.F((j+k),1) = INPUT.load(i,3);
end
C=INPUT.spc;
MODEL.constr_dofs=zeros(1, length(C));
for i = 1:length(C)
    MODEL.constr_dofs(1,i)=(C(i,1)*NODES(1).ndof)-NODES(1).ndof+C(i,2);
end
MODEL.constr_dofs=sort(MODEL.constr_dofs);
MODEL.free_dofs=setdiff(1:MODEL.ndof, MODEL.constr_dofs);
MODEL.nfree_dofs=length(MODEL.free_dofs);
MODEL.K_unc= '(filled later)';  
MODEL.F_unc= '(filled later)';  
MODEL.U= '(filled later)';
MODEL.U_unc= '(filled later)';
MODEL.om= '(filled later)';

end
    

