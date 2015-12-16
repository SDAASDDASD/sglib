function unittest_gpcbasis_modify(varargin)
% UNITTEST_GPCBASIS_MODIFY Test the GPCBASIS_MODIFY function.
%
% Example (<a href="matlab:run_example unittest_gpcbasis_modify">run</a>)
%   unittest_gpcbasis_modify
%
% See also GPCBASIS_MODIFY, MUNIT_RUN_TESTSUITE 

%   Elmar Zander
%   Copyright 2015, Institute of Scientific Computing, TU Braunschweig
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

munit_set_function( 'gpcbasis_modify' );

V_u = gpcbasis_create('hlp', 'p', 2);
V_un = gpcbasis_create('hlp', 'p', 4);

V_un2 = gpcbasis_modify(V_u, 'p', 4);
assert_equals(V_un2, V_un, 'bases24');


[V_un2, P] = gpcbasis_modify(V_u, 'p', 4);
a_i_alpha = gpc
