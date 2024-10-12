% Data for different mu values
muValues = [1, 10, 100, 1000];
x1_star = [0.433777, 0.331354, 0.313738, 0.311790];
x2_star = [1.210166, 0.995540, 0.955252, 0.950732];

% Plot x1* vs mu
figure;
semilogx(muValues, x1_star, '-o', 'LineWidth', 2);
xlabel('\mu');
ylabel('x_1^*');
title('Convergence of x_1^* with \mu');
grid on;

% Plot x2* vs mu
figure;
semilogx(muValues, x2_star, '-o', 'LineWidth', 2);
xlabel('\mu');
ylabel('x_2^*');
title('Convergence of x_2^* with \mu');
grid on;
