function filename=generate_cache_filename( script, var )
% GENERATE_CACHE_FILENAME Generate unique filename that can used for caching.
%   FILENAME=GENERATE_CACHE_FILENAME( SCRIPT, VAR ) 
%
% Example (<a href="matlab:run_example generate_cache_filename">run</a>)
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

store.var=var;
store.deps=find_deps( script );
store.dep_dates=cellfun( @filedate, store.deps );

tmp_name=[tempname '.mat'];
save( tmp_name, 'store' );
[status, result]=system(['cat ' tmp_name ' | hexdump -C | sed "1,6 d" | sha1sum']);
delete( tmp_name );
if ~status
    filename=fullfile( '.cache', result(1:40) );
else
    warning( 'Could not create unique cache filename. ' );
    filename='';
end
