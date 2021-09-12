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
c=2.2*(t>=0&t<14)+2.0*(t>=14&t<18)+1.8*(t>=18);%1.5; %�ȣ�������Ⱥ������3.12 �����pad��3.12*0.9=2.808;�����������Ԥ������£�cһֱ��Ϊ2.808
De=6; % De:1/Ǳ����
Da=4;  % Da:1/�����Ҹ���
Dc=0.025; % Dc:1/�����Ҹθ�Ⱦ�� 0.0027
n1=0.005.*(t>=0&t<3)+0.0005.*(t>=3&t<13)+0.00005.*(t>=13);%0.0005.*(t>=0&t<3)+0.00005.*(t-3).*(t>=3&t<13)+0.00001.*(t>=13); %��1:E to A1�ı�������GBD���ݹ������
n2=0.02.*(t>=0&t<3)+0.0002.*(t>=3&t<13)+0.00002.*(t>=13);%0.005.*(t>=0&t<3)+0.0005.*(t-3).*(t>=3&t<13)+0.00001.*(t>=13); %��2:E to A2�ı�����0.02; n3=1-��1-��2 % E to A3�ı�����0.02
q1=0.90; % A1 to Ic �ı���
q2=0.275; % A2 to Ic �ı���
q3=0.075; % A3 to Ic �ı���
y1=0.00608;% ��1: Iu��Id to Ic�Ľ�չ��
y2=0.025;  % ��2: Iu��Id to R�Ľ�չ�� 0.005~0.025
y3=0.03; % ��3: Cirrhosis to HCC�ķ�����0.0045  3%~6%
Yd=0.03;  % CHB to Cirrhosis �ķ����� /0.021 ;0.02   2%~10%
Yc=0.005; % Ic to HCC �ķ����ʣ�0.0075��0.004    0.5%~1%
Yu=0.004;  % Iu to HCC �ķ�����
e1=0.97;
e2=0.99;
e3=0.70;
Yc1=0.4*(t>=0&t<11)+0.6*(t>=11&t<20)+0.3*(t>=20);%0.013
bMatrix=parameter.bMatrix; %��ʱ���йصĲ�������1(bMatrix)��3������ʣ�e1:�������Ҹ�������Ч��; p(t)�����˽�����;e3:��Գ��˵�������Ч��
wMatrix=parameter.wMatrix; %��_2����������ʣ�e2:�������Ҹ������ĸӤ�����Ч��;
aMatrix=parameter.aMatrix; %��Ȼ�����ʣ���
gMatrix=parameter.gMatrix; %��Ȼ�����ʣ�k
Kd=parameter.Kd; % Cirrhosis������ ��ʱ���й� 
Kc=parameter.Kc; % HCC��������

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

% 1-��1(1-bMatrix)��3-vaacination rate function(bMatrix)
vac3fun= 0.0051.*(t>=0);
i=1;
while i<=length(bMatrix)
    vac3fun(t>=i-1&t<i)=bMatrix(i);% 1
    i=i+1;
end

% ��_2��in time vaccination function(wMatrix)
vac1fun= 0.04.*(t>=0);% 1
i=1;
while i<=length(wMatrix)
    vac1fun(t>=i-1&t<i)=wMatrix(i);
    i=i+1;
end

% Kc��death due to HCC
Kcfun= 0.6124.*(t>=0);%0.8285
i=1;
while i<=length(Kc)
    Kcfun(t>=i-1&t<i)=Kc(i);
    i=i+1;
end

% Kd��death due to Cirrhosis
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
birthfun*e2*(1-vac1fun)*c*(x(6)+x(7))-(deathfun+0.05)*x(17)];%ԭ��hcc�������滻Ϊ5���������Ը�Ⱦ��;M ��δ֪
%Kcfun*x(11)
%q1*Da*x(3)+q2*Da*x(4)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)-Dc*x(11)-deathfun*x(11)-Yc*x(11)
%birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-deathfun*x(13)-(birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6))*Yc-(Yu+Yd)*(birthfun*vac1fun*c*x(7)+birthfun*(1-e2)*(1-vac1fun)*c*x(7))
% double(r1+r2+r3>1)*10];
