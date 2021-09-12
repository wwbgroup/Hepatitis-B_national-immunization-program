function D = ObjFun0(defr1r2r3t1t2t3,tspan,x0,xi)
        
        parameter = load('parameter c.mat');
		[~,x] = ode45(@(t,x)ODEfunction(t,x,defr1r2r3t1t2t3,parameter),tspan,x0);
        D = sqrt(sum(([x(1,8)+x(1,12);x(2:end,8)-x(1:end-1,8)+x(2:end,12)-x(1:end-1,12)]-xi).^2));
%         D = sqrt(sum(([x(1,8)+x(1,12);x(2:end,8)-x(1:end-1,8)+x(2:end,12)-x(1:end-1,12)]-xi).^2))+x(16)*1000000;
end