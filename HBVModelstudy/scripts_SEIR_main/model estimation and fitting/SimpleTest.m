clc
clear

data = load('HBV.mat');

xi = data.xi;   %233540   1329405 8323815 （2014）9.75%*1171710000=114241725
x0 = [431240686;0;51187;200821;3573602;83176687;18487682;243724;666823529;140930686;184195;0;3000000;64630;11110952;0;0];% 1992年 1~4岁HBsAg 9.67%*155480000=15034916  
tspan = linspace(0,28,29);
%tspan = linspace(0,100,101);

defr1r2r3t1t2t30 = [0.02 0.03 0.02 0.2 0.5 0.3 4 10 20];%[0.02 0.03 0.02 0.2 0.5 0.3 4 10 20]；0.03 0.04 0.04 0.2 0.5 0.3 4 10 23  ；；0.03 0.05 0.03 0.2 0.5 0.3 4 10 23（对应1992年流调 1~59岁）[431240686;32000;51187;200821;3573602;73176687;11487682;243724;666823529;140930686;184195;0;3000000;0;0]
result0 = fminsearch(@(defr1r2r3t1t2t3)ObjFun0(defr1r2r3t1t2t3,tspan,x0,xi),defr1r2r3t1t2t30);

D0 = ObjFun3(result0,tspan,x0);
[ResultsD,ResultsS,ResultsE,ResultsA1,ResultsA2,ResultsA3,ResultsIc,ResultsIu,ResultsId,ResultsR,ResultsCD,ResultsHCC,ResultsX12,ResultsHor,Resultsdcc,ResultsC5,ResultsRW3,ResultsRW1]=ObjFun3(result0,tspan,x0);
plot(xi,'b')% xi
hold on
plot(D0,'r')
legend('真实数据','拟合数据')