function output=rhodtoymodel
T=0;

nrms1=0.5; %nrms of active layer in units of 10^10 cm^-2
nrms2=0.5;  %nrms of passive layer in units of 10^10 cm^-2
eta=0; %correlation coefficient in the bivariate normal distribution
ng1=[40:0.05:49 49.05:0.01:51 51.05:0.05:60]; %avrg density of active layer in units of 10^10 cm^-2.
ng2=-50; %avrg density of passive layer in units of 10^10 cm^-2.

% Define the monolayer and drag conductivity functions
monocondA=@(n1) 6e-4*T^2+5*abs(n1); %conductivity in units of e^2/h, where n is in units of 10^10cm^-2.
% Numbers taken from nimp=5e10 cm^-2 numerical calculation of sigma. 

monocondP=@(n2) 6e-4*T^2+5*abs(n2);

dragcond=@(n1,n2) -5.*min(abs(n1),abs(n2)).*(1-sign(n1).*sign(n2))./2+ 1e-2.*sqrt(abs(n1).*abs(n2)).*(1+sign(n1).*sign(n2))./2;

rhodfun=@(n1,n2) - dragcond(n1,n2)./(monocondA(n1).*monocondP(n2) - dragcond(n1,n2).^2);

rhodvals=zeros(1,length(ng1));
sigmademt=zeros(1,length(ng1));
sigmaAeff=zeros(1,length(ng1));
sigmaPeff=zeros(1,length(ng1));

for j=1:length(ng1)
    tic
    sigmaAeff(j)=EMTmono(ng1(j),nrms1,monocondA);
    sigmaPeff(j)=EMTmono(ng2,nrms2,monocondP); 
    
    numerator= integral2(@(n1,n2) P(n1,n2,ng1(j),ng2,nrms1,nrms2,eta) .* dragcond(n1,n2) .* sigmaAeff(j)./ ... 
        ( (sigmaAeff(j)+monocondA(n1)).*(sigmaPeff(j)+monocondP(n2)) ),ng1(j)-5.*nrms1,ng1(j)+5.*nrms1,ng2-5.*nrms2,ng2+5.*nrms2,'Method','iterated','RelTol',1e-4);
    
    denominator=integral2(@(n1,n2) P(n1,n2,ng1(j),ng2,nrms1,nrms2,eta) .* monocondA(n1) ./ ... 
        ( (sigmaAeff(j)+monocondA(n1)).*(sigmaPeff(j)+monocondP(n2)) ),ng1(j)-5.*nrms1,ng1(j)+5.*nrms1,ng2-5.*nrms2,ng2+5.*nrms2,'Method','iterated','RelTol',1e-4);
    
    sigmademt(j)=numerator./denominator;
    rhodvals(j)=rhodfun(ng1(j),ng2);
    toc
end

rhodemt=-sigmademt./(sigmaAeff.*sigmaPeff-sigmademt.^2);

save(['rhodemtvsng1-nrms12-' num2str(nrms1) '.mat'])

figure;
% plot(ng1,abs(rhodvals));
% hold on;
plot(ng1,rhodemt)
% ylim([-10 0])

end