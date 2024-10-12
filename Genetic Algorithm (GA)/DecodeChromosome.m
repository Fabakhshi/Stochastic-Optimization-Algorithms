% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
 
 n = numberOfVariables;
 m = size(chromosome,2);
 k = fix(m/n);

 x(1) = 0.0;
 for j = 1:k
 x(1) = x(1) + chromosome(j)*2^(-j);
 end
 x(1) = -maximumVariableValue + 2*maximumVariableValue*x(1)/(1 - 2^(-k));

 x(2) = 0.0;
 for j = 1:k
 x(2) = x(2) + chromosome(j+k)*2^(-j);
 end
 x(2) = -maximumVariableValue + 2*maximumVariableValue*x(2)/(1 - 2^(-k));
 
end
