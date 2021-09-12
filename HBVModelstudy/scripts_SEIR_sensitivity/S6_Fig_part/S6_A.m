beta1 = 0.026; 
beta2 = 0.030;
beta3 = 0.021;
mu = 0.109;
k = 0.0071;
omiga2 = 0.4;%0.04
rho1 = 0.00005;
rho2 = 0.00002; 
theta = 0.9; %1.8
De = 6;
Da = 4;
Dc = 0.025; 
q1 = 0.90;
q2 = 0.275;
q3 = 0.075;
y1 = 0.00608; 
y2 = 0.025; 
Yd = 0.03; 
Yc = 0.005; 
Yu = 0.004; 
e2=0.99;
r = 0.499; %ascerntain rate

%step = The step size of the parameter change��step=10��omiga2_flow = [omiga2,omiga2+omiga2/10,omiga2+omiga2*2/10,...,omiga2*2]

step = 10;

para1 = omiga2; 
para2 = theta;    

para1_flow = [0*para1:para1/step:2*para1]; 
para2_flow = [para2:para2/step:3*para2]; 

Re = zeros(size(para1_flow,2),size(para2_flow,2));


for i = 1:size(para1_flow,2)
    for j = 1:size(para2_flow,2)
        omiga2 = para1_flow(i);
        theta = para2_flow(j);
        F = [0 beta1 beta1 beta1 beta2 beta3;
         0 0 0 0 0 0;
         0 0 0 0 0 0;
         0 0 0 0 0 0;
         0 0 0 0 mu*omiga2*theta+theta*mu*(1-e2)*(1-omiga2) 0;
         0 0 0 0 0 mu*omiga2*theta+theta*mu*(1-e2)*(1-omiga2)];
         V = [De 0 0 0 0 0;
             -rho1*De Da 0 0 0 0;
             -rho2*De 0 Da 0 0 0;
             -(1-rho1-rho2)*De 0 0 Da 0 0;
             0 -q1*Da -q2*Da -q3*Da Dc+k+Yc -y1;
             0 0 0 0 -(1-r)*Dc (y1+y2+k+Yd+Yu)];
        Vinv = inv(V); 

        tmp = F * Vinv;
        rad = max(abs(eig(tmp)));
        Re(i,j) = rad;
    end
end
save('theta_omiga2_Re.mat','para1_flow','para2_flow','Re');
surf(para2_flow,para1_flow,Re),xlabel('theta'),ylabel('omiga2'),zlabel('Re') 
                                           
grid off 
colorbar


