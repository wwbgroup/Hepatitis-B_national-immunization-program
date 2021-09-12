function y=ODEfunction(t,x,defr1r2r3t1t2t3,parameter)

d = defr1r2r3t1t2t3(1);
e = defr1r2r3t1t2t3(2);
f = defr1r2r3t1t2t3(3);
r1 = defr1r2r3t1t2t3(4);
r2 = defr1r2r3t1t2t3(5);
r3 = defr1r2r3t1t2t3(6);
t1 = defr1r2r3t1t2t3(7);
t2 = defr1r2r3t1t2t3(8);
t3 = defr1r2r3t1t2t3(9);
c=2.2*(t>=0&t<14)+2.0*(t>=14&t<18)+1.8*(t>=18);%1.5; %θ：孕龄人群比例；3.12 详见居pad；3.12*0.9=2.808;所以无疫苗干预的情况下，c一直均为2.808
De=6; % De:1/潜伏期
Da=4;  % Da:1/急性乙肝期
Dc=0.025; % Dc:1/慢性乙肝感染期 0.0027
n1=0.005.*(t>=0&t<3)+0.0005.*(t>=3&t<13)+0.00005.*(t>=13);%0.0005.*(t>=0&t<3)+0.00005.*(t-3).*(t>=3&t<13)+0.00001.*(t>=13); %ρ1:E to A1的比例；用GBD数据估算比例
n2=0.02.*(t>=0&t<3)+0.0002.*(t>=3&t<13)+0.00002.*(t>=13);%0.005.*(t>=0&t<3)+0.0005.*(t-3).*(t>=3&t<13)+0.00001.*(t>=13); %ρ2:E to A2的比例；0.02; n3=1-ρ1-ρ2 % E to A3的比例；0.02
q1=0.90; % A1 to Ic 的比例
q2=0.275; % A2 to Ic 的比例
q3=0.075; % A3 to Ic 的比例
y1=0.00608;% γ1: Iu和Id to Ic的进展率
y2=0.025;  % γ2: Iu和Id to R的进展率 0.005~0.025
y3=0.03; % γ3: Cirrhosis to HCC的发生率0.0045  3%~6%
Yd=0.03;  % CHB to Cirrhosis 的发生率 /0.021 ;0.02   2%~10%
Yc=0.005; % Ic to HCC 的发生率；0.0075；0.004    0.5%~1%
Yu=0.004;  % Iu to HCC 的发生率
e1=0.97;
e2=0.99;
e3=0.70;
Yc1=0.4*(t>=0&t<11)+0.6*(t>=11&t<20)+0.3*(t>=20);%0.013
bMatrix=parameter.bMatrix; %跟时间有关的参数：ω1(bMatrix)：3针接种率；e1:新生儿乙肝疫苗有效性; p(t)：成人接种率;e3:针对成人的疫苗有效性
wMatrix=parameter.wMatrix; %ω_2：首针接种率；e2:新生儿乙肝疫苗对母婴阻断有效性;
aMatrix=parameter.aMatrix; %自然出生率：μ
gMatrix=parameter.gMatrix; %自然死亡率：k
Kd=parameter.Kd; % Cirrhosis死亡率 与时间有关 
Kc=parameter.Kc; % HCC的死亡率

% birth rate function(aMatrix)     %%%question:1.if t>28, ?; 2.ode45?
birthfun= 0.0109.*(t>=0);
i=1;
while i<=length(aMatrix)
    birthfun(t>=i-1&t<i)=aMatrix(i);
    i=i+1;
end
% death rate function(gMatrix)
deathfun= 0.00667.*(t>=0);
i=1;
while i<=length(gMatrix)
    deathfun(t>=i-1&t<i)=gMatrix(i);
    i=i+1;
end

% 1-ω1(1-bMatrix)：3-vaacination rate function(bMatrix)
vac3fun= 0.0051.*(t>=0);
i=1;
while i<=length(bMatrix)
    vac3fun(t>=i-1&t<i)=bMatrix(i);% 1
    i=i+1;
end

% ω_2：in time vaccination function(wMatrix)
vac1fun= 0.04.*(t>=0);% 1
i=1;
while i<=length(wMatrix)
    vac1fun(t>=i-1&t<i)=wMatrix(i);
    i=i+1;
end

% Kc：death due to HCC
Kcfun= 0.6124.*(t>=0);%0.8285
i=1;
while i<=length(Kc)
    Kcfun(t>=i-1&t<i)=Kc(i);
    i=i+1;
end

% Kd：death due to Cirrhosis
Kdfun= 0.000379.*(t>=0);
i=1;
while i<=length(Kd)
    Kdfun(t>=i-1&t<i)=Kd(i);
    i=i+1;
end
N=x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8)+x(9)+x(10)+x(11);

y=[birthfun*vac3fun*(N-c*(x(6)+x(7)))+birthfun*(1-e1)*(1-vac3fun)*(N-c*(x(6)+x(7)))-(d*x(1)*(x(3)+x(4)+x(5))+e*x(1)*x(6)+f*x(1)*x(7))/N-e3*(0.15/10.*t.*(t>=0&t<10)+(0.15+0.051/3*(t-10))*(t>=10&t<13)+(0.201+0.1/15*(t-13))*(t>=13&t<28)+0.301.*(t>=28))*x(1)+0.05*(x(16)+x(17))-deathfun*x(1);
(d*x(1)*(x(3)+x(4)+x(5))+e*x(1)*x(6)+f*x(1)*x(7))/N-De*x(2);
n1*De*x(2)-Da*x(3);
n2*De*x(2)-Da*x(4);
(1-n1-n2)*De*x(2)-Da*x(5);
q1*Da*x(3)+q2*Da*x(4)+q3*Da*x(5)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)+y1*(x(7)+x(8))-Dc*x(6)-deathfun*x(6)-Yc*x(6);
((1-r1)*(t>=0&t<t1)+(1-(r1+r2/(t2-t1)*(t-t1)))*(t>=t1&t<t2)+(1-(r1+r2+(0.9-r3)/(t3-t2)*(t-t2)))*(t>=t2&t<t3)+(1-r1-r2-(0.9-r3))*(t>=t3))*Dc*x(6)+birthfun*vac1fun*c*x(7)+birthfun*(1-e2)*(1-vac1fun)*c*x(7)-y1*x(7)-y2*x(7)-deathfun*x(7)-Yd*x(7)-Yu*x(7);
((r1)*(t>=0&t<t1)+(r1+r2/(t2-t1)*(t-t1))*(t>=t1&t<t2)+(r1+r2+(0.9-r3)/(t3-t2)*(t-t2))*(t>=t2&t<t3)+(r1+r2+(0.9-r3))*(t>=t3))*Dc*x(6)-y1*x(8)-y2*x(8)-deathfun*x(8);
birthfun*e1*(1-vac3fun)*(N-c*(x(6)+x(7)))+birthfun*e2*(1-vac1fun)*c*(x(6)+x(7))+e3*(0.15/10.*t.*(t>=0&t<10)+(0.15+0.051/3*(t-10))*(t>=10&t<13)+(0.201+0.1/15*(t-13))*(t>=13&t<28)+0.301.*(t>=28))*x(1)+(1-q1)*Da*x(3)+(1-q2)*Da*x(4)+(1-q3)*Da*x(5)+y2*(x(7)+x(8))-deathfun*x(9);
Yd*x(7)-y3*x(10)-(deathfun+Kdfun)*x(10);
Yc*x(6)+Yu*x(7)+y3*x(10)-(deathfun+Kcfun)*x(11);
y1*x(8)+y2*x(8)+deathfun*x(8);
birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-(deathfun+Yu+Yd)*x(13);%birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-deathfun*x(13);
Kdfun*x(10);
q1*Da*x(3)+q2*Da*x(4)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)-Dc*x(15)-deathfun*x(15)-Yc1*x(15);
birthfun*e1*(1-vac3fun)*(N-c*(x(6)+x(7)))-(deathfun+0.05)*x(16);
birthfun*e2*(1-vac1fun)*c*(x(6)+x(7))-(deathfun+0.05)*x(17)];%原来hcc死亡已替换为5岁以下慢性感染者;M 是未知
%Kcfun*x(11)
%q1*Da*x(3)+q2*Da*x(4)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)-Dc*x(11)-deathfun*x(11)-Yc*x(11)
%birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-deathfun*x(13)-(birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6))*Yc-(Yu+Yd)*(birthfun*vac1fun*c*x(7)+birthfun*(1-e2)*(1-vac1fun)*c*x(7))
% double(r1+r2+r3>1)*10];
