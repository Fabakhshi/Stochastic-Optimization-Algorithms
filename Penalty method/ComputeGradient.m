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

    