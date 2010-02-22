function err=tensor_error(T1, T2, relerr)
% TENSOR_ERROR Short description of tensor_error.
%   TENSOR_ERROR Long description of tensor_error.
%
% Example (<a href="matlab:run_example tensor_error">run</a>)
%
% See also

%   Elmar Zander
%   Copyright 2010, Inst. of Scientific Comuting
%   $Id$ 
%
%   This program is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version. 
%   See the GNU General Public License for more details. You should have
%   received a copy of the GNU General Public License along with this
%   program.  If not, see <http://www.gnu.org/licenses/>.

if nargin<3
    relerr=false;
end


norm_T1=tensor_norm(T1);
norm_T2=tensor_norm(T2);
inner_T1_T2=tensor_scalar_product( T1, T2 );
err=norm_T1^2+norm_T2^2-2*inner_T1_T2;

if relerr
    err=err/norm_T2;
end
    