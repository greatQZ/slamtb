function drawPlkLin(MapFig,Lmk,color)

% DRAWPLKLIN  Draw Plucker line landmark in MapFig.

global Map

% r   = Lmk.state.r; % range
% plk = Map.x(r); % mean
% PLK = Map.P(r,r); % covariances matrix
% t   = Lmk.par.endpoints.t; % abscissas of endpoints, t = [t1;t2]
% 
% % extract endpoints - mean and covariance
% [e1,e2,E1_plk,E2_plk] = pluckerEndpoints(plk,t(1),t(2));
% E1 = E1_plk*PLK*E1_plk';
% E2 = E2_plk*PLK*E2_plk';

% extract endpoints info
e1 = Lmk.par.endp(1).e;
E1 = Lmk.par.endp(1).E;
e2 = Lmk.par.endp(2).e;
E2 = Lmk.par.endp(2).E;

% the mean:
set(MapFig.estLmk(Lmk.lmk).mean,...
    'xdata',   [e1(1);e2(1)],...
    'ydata',   [e1(2);e2(2)],...
    'zdata',   [e1(3);e2(3)],...
    'color',   satColor(color),...
    'visible', 'on');

% the covariance ellipses
[X,Y,Z] = cov3elli(e1, E1, 3, 10) ;
set(MapFig.estLmk(Lmk.lmk).ellipse(1),...
    'xdata',   X,...
    'ydata',   Y,...
    'zdata',   Z,...
    'color',   color,...
    'visible', 'on');

[X,Y,Z] = cov3elli(e2, E2, 3, 10) ;
set(MapFig.estLmk(Lmk.lmk).ellipse(1),...
    'xdata',   X,...
    'ydata',   Y,...
    'zdata',   Z,...
    'color',   color,...
    'visible', 'on');

% the label
n = Map.x(Lmk.r(1:3)); % Plucker's normal vector
posOffset = 0.2*n;     % label orthogonally out of the line.
set(MapFig.estLmk(Lmk.lmk).label,...
    'position', 0.5*(e1+e2) + posOffset,...
    'string',   num2str(Lmk.id),...
    'visible',  'on');
