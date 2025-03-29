%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function INPUT = input_model_2
% --- Input
% INPUT.elements: [ node_A node_B ID_prop ]
% INPUT.nodes: [ ID_node x_coord y_coord ] in [mm]
% INPUT.E: Young's modulus [MPa]
% INPUT.section_prop : [ A J ] A in [mm^2] J in [mm^4]
%                      set J=0 for truss
% INPUT.mass: [ ID_node component magn] in [Tons]
% INPUT.load: [ ID_node component magn ] [N]
% INPUT.spc: [ ID_node component ] (constrained component)
% INPUT.solution: 'static' or 'eigenmodes'


% -- Initializing structure format
INPUT = struct();

% -- Elements
INPUT.elements = [1 3 1;
    3 5 1;
    5 7 1;
    2 7 1;
    2 8 1;
    6 8 1;
    4 6 1;
    1 4 1;
    3 4 1;
    3 6 1;
    4 5 1;
    5 6 1;
    5 8 1;
    6 7 1;
    7 8 1];
% -- Nodes
INPUT.nodes = [ 1 0 0;
    2 4*2540 0;
    3 2540 0;
    4 2540 3810;
    5 2*2540 0;
    6 2*2540 5080;
    7 3*2540 0;
    8 3*2540 3810];
% -- Section properties
INPUT.E = 200000;
A1 = 10;
INPUT.section_prop = [ A1 0 ];
% -- Concentrated mass 
INPUT.mass = 1e-4;
% -- Loading conditions 
INPUT.load = [ 4 2 -35;
    6 2 -35;
    8 2 -35];
% -- Boundary conditions 
INPUT.spc = [ 1 1
1 2 
2 1
2 2];

if INPUT.section_prop(1,2) == 0
    [j,~]=find(INPUT.spc(:,2)>2);
    INPUT.spc(j,:)=[];
else
    INPUT.spc=INPUT.spc;
end

INPUT.solution='eigenmodes';
end