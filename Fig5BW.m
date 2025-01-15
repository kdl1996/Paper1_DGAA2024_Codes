% Input parameters
clear all;
close all;
kact=-0.5; %% actual k. not the running index.
  a1=-1;a2=-2;b1=a1*2*kact;b2=(a2*2)/kact;v10=0.5;v20=0.2;
 
 
  tspan = 0:0.1:50;


y0mat=[-5 10;-5 6;-5 2;-5 -2; -5 -6;5 10;5 6;5 2;5 -2; 5 -6;-2 -10;0 -10;2 -10;4 -10;
    -2 10;2 10];
    
x=-5:0.1:5;
 z=-(1/kact)*x;
  options=odeset('RelTol',1e-2,'AbsTol',1e-6,'Events',@events);
for k=1:size(y0mat,1)
  y0=y0mat(k,:);
  [t,y] = ode45(@(t,y) replicator(t,y,a1,b1,v10,a2,b2,v20), tspan, y0);
  tsol{k}=t;
  y1sol{k}=y(:,1);
  y2sol{k}=y(:,2);
end
  
  hold on 
figure(1)
 h1=plot(x,z,'k--','LineWidth',2);
for k=1:size(y0mat,1)
plot(y1sol{k},y2sol{k},'k-');
box on
end
 hold off
 legend(h1,'Attractor')
axis square
 grid off
 set(gca,'FontSize',24,'FontName','Times','LineWidth',2)
 xlabel('$m_1$','Interpreter','latex')
 ylabel('$m_2$','Interpreter','latex','Rotation',0)
%% xticks([-5 -4 -3 -2 -1 0 1 2 3 4 5])
yticks([-10 -5 0 5 10])


%  print('dkattract2.eps','-depsc')
% % print('dkattract2.jpg','-jpeg')



% figure(2)
% plot(t,y1sol{3},'r-',t,y2sol{3},'b-','LineWidth',2);
% legend('$m_1$','$m_2$','Interpreter','latex')
% axis square
%  grid on
%  set(gca,'FontSize',24,'FontName','Times','LineWidth',2)
%  xlabel('$t$','Interpreter','latex')
y0=[-5,2];
tspanb = 0:1:50;
  [t,y] = ode45(@(t,y) replicator(t,y,a1,b1,v10,a2,b2,v20), tspanb, y0);
  tsol=t;
  y1sol=y(:,1);
  y2sol=y(:,2);

 figure(2)
plot(tsol,y1sol,'k-',tsol,y2sol,'ko','LineWidth',2);
legend('$m_1$','$m_2$','Interpreter','latex')
axis square
 grid off
 set(gca,'FontSize',24,'FontName','Times','LineWidth',2)
 xlabel('$t$','Interpreter','latex')


%   dydt=vdp1(t,y,a1,b1,v10,a2,b2,v20);
   function dydt = replicator(t,y,a1,b1,v10,a2,b2,v20)
        dydt = [(2*a1*y(1)+b1*y(2))*v10/(1-2*a1*v10*t);
            (2*a2*y(2)+b2*y(1))*v20/(1-2*a2*v20*t)];
   end
  