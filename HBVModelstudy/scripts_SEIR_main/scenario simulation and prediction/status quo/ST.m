[t,x]=ode45('scenhbv_sq',(0:100),[431240686;0;51187;200821;3573602;83176687;18487682;243724;666823529;140930686;184195;0;3000000;64630;11110952;0;0]);
close all
D = [x(1,8)+x(1,12);x(2:end,8)-x(1:end-1,8)+x(2:end,12)-x(1:end-1,12)];
plot(t,D)