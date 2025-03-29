%% Coded for the fulfilment of Master's Degree at Politecnico Di Milano
% Author:: Eshwar Bhargav Bhupanam
% Course:: Spacecraft Structures
% Topic:: Trusses and Beams
% Year:: 2019-2020

%%
function MODEL = solve_structure( MODEL,INPUT )

constr_dofs = MODEL.constr_dofs;

% Store unconstrained K and F
MODEL.K_unc = MODEL.K;
MODEL.F_unc = MODEL.F;

% Impose constraints
MODEL.K( constr_dofs, : ) = [];     % Remove rows of constrained dofs
MODEL.K( :, constr_dofs ) = [];     % Remove cols of constrained dofs
MODEL.F( constr_dofs )    = [];     % Remove rows of constrained dofs

if strcmp( INPUT.solution,'static')
    % Solve problem
    MODEL.U = MODEL.K \ MODEL.F;
    
    % Expand displacements to the global vector
    MODEL.U_unc = zeros( MODEL.ndof, 1);
    MODEL.U_unc( MODEL.free_dofs ) = MODEL.U;
    
elseif strcmp( INPUT.solution,'eigenmodes')
    INPUT.mass = INPUT.mass*eye(MODEL.ndof);
    INPUT.mass( constr_dofs, : ) = [];
    INPUT.mass( :, constr_dofs ) = [];
    [V,D]=eig(MODEL.K,INPUT.mass);
    MODEL.U=V;
    
    % Expand displacements to the global vector
    MODEL.om = D;
    MODEL.U_unc = zeros( MODEL.ndof, max(size(D)));
    for i=1:max(size(D))
        MODEL.U_unc( MODEL.free_dofs,i ) = V(:,i);
    end
end
