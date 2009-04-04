function demo_sparsity_plots( varargin )
% DEMO_SPARSITY_PLOTS Generates the sparsity plots from A. Keese's diss.
% DEMO_SPARSITY_PLOTS( OPTIONS ) Generates the sparsity plots from 
%   A. Keese's diss.(fig 41. on page 72). 


init_demos
clf

setuserwaitmode( 'continue' );

disp( 'sparsity plot (lexicographic ordering, A. Keese)' );
sp_plots( true, false);

if false
userwait;

    disp( 'sparsity plot (degree ordering)' );
    sp_plots( false, false);
    userwait;

    disp( 'sparsity plot (reduced bandwidth ordering)' );
    sp_plots( false, true);
    userwait;
end



function sp_plots( do_sorting, do_rcm )
% SP_PLOTS Show sparsity plots.
% If DO_SORTING is true then the multiindices are sorted lexicographically
% like in A. Keese's thesis. Otherwise a (to me more natural) ordering is
% used, where lower orders come first, and for each order, the multiindices
% are then ordered lexicographically (highest ranking right). If DO_RCM is
% true a bandwidth reduction based on the reverse Cuthill-McKee algorithm
% is used (DO_SORTING is more or less no effect then).

m=4;
p=4;
p2=[1,2,4,5];
I=multiindex(m,p);
if do_sorting
    I=sortrows(I,m:-1:1);
end

M=size(I,1);
hermite_triple_fast( 10 );
for n=1:4
    J=multiindex(m,p2(n));
    if do_sorting
        J=sortrows(J,m:-1:1);
    end
    
    M2=size(J,1);
    S=zeros(M);
    for i=1:M
        for j=1:i
            S(i,j)=any( hermite_triple_fast( I(i,:), I(j,:), J(:,:) ) );
            S(j,i)=S(i,j);
        end
    end
    subplot(2,2,n);

    % bandwidth reduction with reverse cuthill-mckee
    if do_rcm
        r=symrcm(S);
        S=S(r,r);
    end;
    
    spy(S);
    drawnow;
    
    %print bandwidth
    [i,j]=find(sparse(S));
    fprintf( 'bandwidth: %d\n', 1+max(abs(i-j)) );
end
