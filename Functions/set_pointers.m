%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function ELEMENTS = set_pointers( ELEMENTS, NODES, nels )

for i = 1 : nels
    A=ELEMENTS(i).nodes;
    ELEMENTS(i).ptrs = [];
    for j = 1:NODES(1).ndof
        ELEMENTS(i).ptrs(1,j)=(A(1)*NODES(1).ndof)-(NODES(1).ndof-j);
        ELEMENTS(i).ptrs(1,j+NODES(1).ndof)=(A(2)*NODES(1).ndof)-(NODES(1).ndof-j);
    end
end
