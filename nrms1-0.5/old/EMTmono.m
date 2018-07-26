function output=EMTmono(ng,nrms,monocond)
% Inputs:
% average density ng: in 10^10 cm^-2
% root mean square density fluctuation nrms: in 10^10cm^-2
% monocond is the monolayer conductivity function. 

% Output: 
% EMT conductivity in units of e^2/hbar.

% Example usage:
% fun=@(n) abs(n);
% ng=10; nrms=1;
% sigma=EMTmono(ng,nrms,fun);

P=@(n) exp(-((n-ng).^2)./(2.*nrms.^2)) ; 

topintgrnd=@(n,y) P(n) ./ (1+y./monocond(n));
botintgrnd=@(n,y) P(n) ./ (monocond(n)+y);

uppintgrl=@(y) integral(@(n) topintgrnd(n,y), ng-10.*nrms,ng+10.*nrms,'ArrayValued',true,'RelTol',1e-4);
lowintgrl=@(y) integral(@(n) botintgrnd(n,y), ng-10.*nrms,ng+10.*nrms,'ArrayValued',true,'RelTol',1e-4);
% Note that if ng=0, lowintgrl(0) diverges.

% Note that sigma_emt = 0 is not a solution of the EMT equation as it
% yields 1 = 0. The fact that uppintgrl(y)/lowintgrl(y) approaches 0
% as y goes to zero does not imply y = 0 is a solution, because if y were
% 0, then when you shift the lowintgrl(y)*y term to rhs from the original emt
% equation, you are in fact adding zero to both sides. There is then
% nothing to divide both sides by so that you get uppintgrl(y)/lowintgrl(y)
% = 0.

fiter=@(y) uppintgrl(y)./lowintgrl(y);

function Ans = solve(ng, delta)    
        %Guess
        y0 = Inf;
        y1 = monocond(ng)+1e-9; %Shift this slightly away from zero to prevent lowintgrl(y) from receiving y=0, which causes a divergence. 


        while abs((y1 - y0) / y1) >= delta
            y0 = y1;
            y1 = fiter(y1);
        end

        Ans = y1; %* echarge^2 /hbar
end

output=solve(ng,1e-6);
end