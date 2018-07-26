function output=P(n1,n2,ng1,ng2,nrms1,nrms2,eta)

% bivariate normal distribution

output=1/(2*pi*nrms1*nrms2*sqrt(1-eta^2)) .*...
    exp(- 1./(2.*(1-eta.^2)) .* ...
    ( (n1-ng1).^2./nrms1.^2 + (n2-ng2).^2./nrms2.^2 -2.*eta.*(n1-ng1).*(n2-ng2)./(nrms1.*nrms2) ) ); 

end