function [] = draw_circle_r( x,y,r )
theta=0:0.1:2*pi;
Circle1=x+r*cos(theta);
Circle2=y+r*sin(theta);
c=[123,14,52];
plot(Circle1,Circle2,'r','linewidth',1);
axis equal
end