figure;
% plot(nrms1,abs(rhodvals));
% hold on;
plot(nrms1,rhodemt)
hold on;
c=rhodemt(3).*nrms1(3);
y=c./nrms1;
plot(nrms1,y)