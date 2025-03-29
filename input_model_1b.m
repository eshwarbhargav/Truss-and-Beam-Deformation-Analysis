%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function INPUT = input_model_1b
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
INPUT.elements = [1 2 1;
    1 3 1;
    2 3 1;
    1 4 1;
    2 4 1;
    3 4 1;
    3 5 1;
    3 6 1;
    4 5 1;
    4 6 1];
% -- Nodes
INPUT.nodes = [ 1 720 360;
    2 720 0;
    3 360 360;
    4 360 0;
    5 0 360;
    6 0 0];
% -- Section properties
INPUT.E = 10000;
A1 = 10;
INPUT.section_prop = [ A1 0 ];
% -- Concentrated mass
INPUT.mass = 1e-4;
% -- Loading conditions
INPUT.load = [ 1 2 -100;
    5 1 -2*100;
    5 2 100;
    6 1 2*100];
% -- Boundary conditions
INPUT.spc = [];

%if INPUT.section_prop(1,2) == 0 && INPUT.spc(:,2)>2
    %[j,~]=find(INPUT.spc(:,2)>2);
    %INPUT.spc(j,:)=[];
%else
    %INPUT.spc=INPUT.spc;
%end

INPUT.solution='eigenmodes';

end
 