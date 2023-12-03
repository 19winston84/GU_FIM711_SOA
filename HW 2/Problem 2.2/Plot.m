% clf;
% close all;
% 
% x1 = linspace(-5, 5, 1000); 
% x2 = linspace(-5, 5, 1000);
% 
% [X1, X2] = meshgrid(x1, x2);
% 
% Z = log(0.01+(X1.^2 + X2 - 11).^2 + (X1 + X2.^2 - 7).^2);
% 
% contour(X1, X2, Z, 50); 
% 
% xlabel('x1');
% ylabel('x2');
% title('Contour Plot of f(x1, x2)');
% 
% colorbar;
% % 

x= 3.5844;  
y = -1.8481;
A = 4*x*(x^2+y-11)+2*(x+y^2-7);
B = 4*y*(y^2+x-7)+2*(y+x^2-11);
disp(A);
disp(B);