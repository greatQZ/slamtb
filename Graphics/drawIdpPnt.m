function drawIdpPnt(MapFig, Lmk, color)

% DRAWIDPPNT  Draw inverse-depth point landmark in MapFig.

global Map

posOffset = [0;0;.2];

% idp
idp = Map.x(Lmk.state.r) ;
IDP = Map.P(Lmk.state.r,Lmk.state.r) ;

% Euclidean
[euc,EUC] = propagateUncertainty(idp,IDP,@idp2p);

% the ellipse
[X,Y,Z] = cov3elli(euc, EUC, 3, 10) ;
set(MapFig.Lmk(Lmk.lmk).ellipse(1),...
    'xdata',   X,...
    'ydata',   Y,...
    'zdata',   Z,...
    'color',   color,...
    'visible', 'on');

% the mean:
set(MapFig.Lmk(Lmk.lmk).mean,...
    'xdata',   euc(1),...
    'ydata',   euc(2),...
    'zdata',   euc(3),...
    'color',   satColor(color),...
    'visible', 'on');

% the label
set(MapFig.Lmk(Lmk.lmk).label,...
    'position', euc + posOffset,...
    'string',   num2str(Lmk.id),...
    'visible',  'on');
