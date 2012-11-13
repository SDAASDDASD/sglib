function norm_I=gpc_norm( V )
% GPC_NORM Compute the norm of the system of GPC polynomials.
%  NORM_I=GPC_NORM( V ) returns the norms of the GPC
%  polynomials specified by the V. The returned vector
%  is a column vector.
%
% Example (<a href="matlab:run_example gpc_norm">run</a>)
%  I_u=[0 0; 1 1; 2 2; 2 3; 3 3];
%  V_u={'H', I_u};
%  norm_I_u=gpc_norm(V_u);
%  fprintf('|H_{%1d,%1d}| => %g\n', [I_u norm_I_u]')
%  
%  V_u={{'H', 'L'}, I_u};
%  norm_I_u=gpc_norm(V_u);
%  fprintf('|H_{%1d}L_{%1d}| => %g\n', [I_u norm_I_u]')
%
% See also 

%   Elmar Zander
%   Copyright 2012, Institute of Scientific Computing, TU Braunschweig.
%   $Id$
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

sys = V{1};
I = V{2};

if iscell(sys)
    norm_I = ones(size(I,1), 1);
    for m = 1:size(I,2)
        N = max(max(I(:,m)));
        nrm = poly_norm(sys{m}, (0:N)');
        norm_I=norm_I .* nrm(I(:,m)+1);
    end
    norm_I = sqrt(norm_I);
else
    N = max(max(I));
    nrm = poly_norm(sys, 0:N);
    % Note: the reshape in the next line is necessary, as otherwise, if I
    % is just a column vector it would be transformed into a row vector
    norm_I=sqrt(prod(reshape(nrm(I+1), size(I)), 2));
end


function nrm = poly_norm(sys, n)
switch sys
    case 'H'
        nrm = factorial(n);
    case 'L'
        % Note: the U(-1,1) measure is used here, not the Lebesgue measure
        nrm = 1 ./ (2*n + 1);
    case {'Hn', 'Ln'}
        nrm = ones(size(n));
    otherwise
        error('Unknown polynomials system: %s', sys);
end
