function y=scenhbv_ov(t,x)
parameter = load('parameter c.mat');
bMatrix=parameter.bMatrix; %��1(bMatrix)��1-3_dose coverage
wMatrix=parameter.wMatrix; %��Matrix��1-timely_dose_coverage��
aMatrix=parameter.aMatrix; %natural birth rate����
gMatrix=parameter.gMatrix; %natural death rate��k
Kd=parameter.Kd; % death rate of Cirrhosis  GBD database
Kc=parameter.Kc; % death rate of HCC
%-------------------------------A----------------------------------------%
%no vaccination
     c=2.2;


%----------------------------------------B------------------------------------------------------------------------%
%only hbv vaccine scenario
        n1=0.005.*(t>=0&t<3)+0.0005.*(t>=3);
        n2=0.02.*(t>=0&t<3)+0.0002.*(t>=3);


%--------------------------------------------------C--------------------------------------------------------------%
De=6; 
Da=4;  
Dc=0.025;
q1=0.90; 
q2=0.275; 
q3=0.075; 
y1=0.00608;
y2=0.025;  
y3=0.03; 
Yd=0.03;  
Yc=0.005;
Yu=0.004;  
e1=0.97;
e2=0.878;
e3=0.70;

%-----------------------------------------------------D-----------------------------------------------------------%
%status quo/only hbv vaccine scenario
   Yc1=0.4*(t>=0&t<11)+0.6*(t>=11&t<20)+0.3*(t>=20);%0.013  


%-----------------------------------------------------E-----------------------------------------------------------%
 %status quo / only hbv vaccine scenario
    P=(0.15/10.*t.*(t>=0&t<10)+(0.15+0.051/3*(t-10))*(t>=10&t<13)+(0.201+0.1/15*(t-13))*(t>=13&t<28)+0.301.*(t>=28));

%-----------------------------------------------------F-----------------------------------------------------------%
d=0.0260438611572573;
e=0.0296129389530348;
f=0.0212050922677877;     
r1=0.141766505132361;
r2=0.185839715899721;
r3=0.498625657502373;
t1=3.22041046773064;
t2=11.5562958126382;
t3=16.8936769933300;

%----------------------------------------------------G------------------------------------------------------------%

% birth rate function(aMatrix)    
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
    vac3fun(t>=i-1&t<i)=bMatrix(i);          
    i=i+1;                                     % status quo:0.0051
end                                            % 1992:0.7
                                               % 2002:0.2340

% ��_2��in time vaccination function(wMatrix)
vac1fun= 0.04.*(t>=0);
i=1;
while i<=length(wMatrix)
    vac1fun(t>=i-1&t<i)=wMatrix(i);         
    i=i+1;                                     % status quo:0.04
end                                            % 1992:0.7780
                                               % 2002:0.4590

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

%----------------------------------------------------H------------------------------------------------------------%
N=x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8)+x(9)+x(10)+x(11);
y=[birthfun*vac3fun*(N-c*(x(6)+x(7)))+birthfun*(1-e1)*(1-vac3fun)*(N-c*(x(6)+x(7)))-(d*x(1)*(x(3)+x(4)+x(5))+e*x(1)*x(6)+f*x(1)*x(7))/N-e3*P*x(1)+0.05*(x(16)+x(17))-deathfun*x(1);
(d*x(1)*(x(3)+x(4)+x(5))+e*x(1)*x(6)+f*x(1)*x(7))/N-De*x(2);
n1*De*x(2)-Da*x(3);
n2*De*x(2)-Da*x(4);
(1-n1-n2)*De*x(2)-Da*x(5);
q1*Da*x(3)+q2*Da*x(4)+q3*Da*x(5)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)+y1*(x(7)+x(8))-Dc*x(6)-deathfun*x(6)-Yc*x(6);
((1-r1)*(t>=0&t<t1)+(1-(r1+r2/(t2-t1)*(t-t1)))*(t>=t1&t<t2)+(1-(r1+r2+(0.9-r3)/(t3-t2)*(t-t2)))*(t>=t2&t<t3)+(1-r1-r2-(0.9-r3))*(t>=t3))*Dc*x(6)+birthfun*vac1fun*c*x(7)+birthfun*(1-e2)*(1-vac1fun)*c*x(7)-y1*x(7)-y2*x(7)-deathfun*x(7)-Yd*x(7)-Yu*x(7);
((r1)*(t>=0&t<t1)+(r1+r2/(t2-t1)*(t-t1))*(t>=t1&t<t2)+(r1+r2+(0.9-r3)/(t3-t2)*(t-t2))*(t>=t2&t<t3)+(r1+r2+(0.9-r3))*(t>=t3))*Dc*x(6)-y1*x(8)-y2*x(8)-deathfun*x(8);
birthfun*e1*(1-vac3fun)*(N-c*(x(6)+x(7)))+birthfun*e2*(1-vac1fun)*c*(x(6)+x(7))+e3*P*x(1)+(1-q1)*Da*x(3)+(1-q2)*Da*x(4)+(1-q3)*Da*x(5)+y2*(x(7)+x(8))-deathfun*x(9);
Yd*x(7)-y3*x(10)-(deathfun+Kdfun)*x(10);
Yc*x(6)+Yu*x(7)+y3*x(10)-(deathfun+Kcfun)*x(11);
y1*x(8)+y2*x(8)+deathfun*x(8);
birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-(deathfun+Yu+Yd)*x(13);%birthfun*vac1fun*c*(x(6)+x(7))+birthfun*(1-e2)*(1-vac1fun)*c*(x(6)+x(7))-deathfun*x(13);
Kdfun*x(10);
q1*Da*x(3)+q2*Da*x(4)+birthfun*vac1fun*c*x(6)+birthfun*(1-e2)*(1-vac1fun)*c*x(6)-Dc*x(15)-deathfun*x(15)-Yc1*x(15);
birthfun*e1*(1-vac3fun)*(N-c*(x(6)+x(7)))-(deathfun+0.05)*x(16);
birthfun*e2*(1-vac1fun)*c*(x(6)+x(7))-(deathfun+0.05)*x(17)];