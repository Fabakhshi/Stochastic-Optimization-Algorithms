
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Penalty method for minimizing
%
% (x1-1)^2 + 2(x2-2)^2, s.t.
%
% x1^2 + x2^2 - 1 <= 0.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The values below are suggestions - you may experiment with
% other values of eta and other (increasing) sequences of the
% µ parameter (muValues).


muValues = [1 10 100 1000];
eta = 0.0001;
xStart =  [1, 2];
gradientTolerance = 1E-6;

for i = 1:length(muValues)
 mu = muValues(i);
 x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
 sprintf('x(1) = %3f, x(2) = %3f mu = %d',x(1),x(2),mu)
end

% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    x = xStart;
   
    while true 
        
        gradF = ComputeGradient(x, mu);
       
        if norm(gradF) < gradientTolerance
            break;
        end
        
        x = x - eta * gradF;
    end
end

% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x, mu)

    gradientF = [2 * (x(1) - 1); 4 * (x(2) - 2)];
    
    constraint = x(1)^2 + x(2)^2 - 1;
    
    if constraint > 0
        gradientPenalty = 2 * mu * constraint * [2 * x(1); 2 * x(2)];
    else
        gradientPenalty = [0; 0];
    end
    
    gradF = gradientF + gradientPenalty;
end

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

