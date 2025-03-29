%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function INPUT = input_model_0
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
    3 2 1;
    1 3 1;
    4 3 1];
% -- Nodes
INPUT.nodes = [ 1 0 0;
    2 1732 0;
    3 866 500;
    4 0 1000];
% -- Section properties
INPUT.E = 72000;
A1 = 1600;
INPUT.section_prop = [ A1 0 ]; % J=0 (Truss)
% -- Concentrated mass
INPUT.mass = [];
% -- Loading conditions
INPUT.load = [ 2 2 -10000 ];
% -- Boundary conditions
INPUT.spc = [ 1 1  % (node 1, constrained x)
    1 2                % (node 1, constrained y)
    4 1                % (node 4, constrained x)
    4 2                % (node 4, constrained y)
    3 1 ];             % (node 3, constrained x)

if INPUT.section_prop(1,2) == 0
    [j,~]=find(INPUT.spc(:,2)>2);
    INPUT.spc(j,:)=[];
else
    INPUT.spc=INPUT.spc;
end

INPUT.solution='static';

end
 