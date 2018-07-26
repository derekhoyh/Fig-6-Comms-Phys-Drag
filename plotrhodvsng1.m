function plotrhodvsng1
load('rhodemtvsng1-nrms12-0.5.mat')
figure;
plot(ng1,rhodvals,'-','LineWidth',2,'color','k');
hold on;
plot(ng1,rhodemt,'-','LineWidth',2,'color','r'); 

load('rhodemtvsng1-nrms12-1.mat')
plot(ng1,rhodemt,'-','LineWidth',2,'color','b');

load('rhodemtvsng1-nrms12-2.mat')
plot(ng1,rhodemt,'-','LineWidth',2,'color','g')


set(gca,'FontSize',20)

h=gca;
h.XMinorTick='on';
h.YMinorTick='on';

legend({'$n_{\mathrm{rms}} = 0$' '$n_{\mathrm{rms}} = 0.5\times 10^{10}\mathrm{cm}^{-2} $' '$n_{\mathrm{rms}} = 1 \times 10^{10}\mathrm{cm}^{-2} $' '$n_{\mathrm{rms}} = 2\times 10^{10}\mathrm{cm}^{-2} $'}, 'Interpreter', 'latex','FontSize',14, 'Location', 'NorthEast','Orientation','Vertical')
xlabel('$n_{A}$ $(10^{10} \mathrm{cm}^{-2})$', 'FontSize', 30, 'Interpreter', 'latex');
ylabel('$\rho_{D}(\frac{h}{e^{2}})$', 'FontSize', 30, 'Interpreter', 'latex');
% title('Assuming uncorrelated puddles','FontSize', 16, 'Interpreter', 'latex');
ylim([0 0.4])

axes('Position',[0.24 0.65 0.2 0.2])
load('rhodvsnrms-ng-pm50.mat')
plot(nrms1,rhodemt,'LineWidth',1.5,'color','k')
set(gca,'FontSize',13)
text(0.4,1,'$\rho_{D} \sim \frac{1}{n_{\mathrm{rms}}}$','FontSize',14,'Interpreter', 'latex');
h=gca;
h.XMinorTick='on';
h.YMinorTick='on';
ylim([0 2])
xlabel('$n_{\mathrm{rms}}$ $(10^{10} \mathrm{cm}^{-2})$', 'FontSize', 15, 'Interpreter', 'latex');
ylabel('$\rho_{D}(\frac{h}{e^{2}})$', 'FontSize', 15, 'Interpreter', 'latex');


print('Fig6.pdf','-dpdf')

end