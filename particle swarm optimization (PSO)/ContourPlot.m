x1 = linspace(-5, 5, 100);
x2 = linspace(-5, 5, 100);
[X1, X2] = meshgrid(x1, x2);

f = (X1.^2 + X2 - 11).^2 + (X1 + X2.^2 - 7).^2;

contour(X1, X2, f, 50);

xlabel('x1')
ylabel('x2')
title('Contour Plot of f(x1, x2)')

colorbar

% Define the coordinates of the point to show
xPoint = [-3.7793, -2.8051, 3, 3.5844];
yPoint = [-3.2832, 3.1313, 2, -1.8481]; 

hold on;

plot(xPoint, yPoint, 'ro', 'MarkerSize', 7);

hold off;



