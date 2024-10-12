% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x)

 fNumerator1 = (1.5 - x(1) + x(1)*x(2))^2;
 fNumerator2 = (2.25 - x(1) + x(1)*x(2)^2)^2;
 fNumerator3 = (2.625 - x(1) + x(1)*x(2)^3)^2;
 
 g = fNumerator1 + fNumerator2 + fNumerator3;
 
 fitness = 1/(g + 1);

end
