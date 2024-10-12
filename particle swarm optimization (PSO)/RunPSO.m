% Define the objective function
objectiveFunction = @(x) (x(1)^2 + x(2) - 11)^2 + (x(1) + x(2)^2 - 7)^2;

% Define the problem bounds
xMin = [-5, -5];
xMax = [5, 5];

% PSO parameters
nParticles = 20;
nIterations = 100;
nRuns = 10; % Number of PSO runs

% Initialize a matrix to store all local best solutions and values
localBestSolutions = zeros(nRuns, 2);
localBestValues = zeros(nRuns, 1);
allLocalBest = zeros(nIterations, 2);  % Initialize to store local best solutions

vmax = (xMax(1) - xMin(1)) / 2;

% Define inertia weight limits and decay factor
wMax = 1.4;  
wMin = 0.3;  
beta = 0.99; 

% Initialize cognitive and social coefficients
c1 = 2;  
c2 = 2;  

% Initialize the inertia weight
w = wMax;

for run = 1:nRuns
    % Initialize particles
    particles = xMin + (xMax - xMin) .* rand(nParticles, 2);
    velocities = -vmax + 2 * vmax .* rand(nParticles, 2);
    personalBest = particles;
    personalBestValue = zeros(nParticles, 1);
    localBest = zeros(1, 2);
    localBestValue = inf;

    % Initialize the PSO loop
    for iter = 1:nIterations
        
        w = max(w * beta, wMin);  % Ensure w does not go below wMin
        
        % Evaluate the objective function for each particle
        for i = 1:nParticles
            currentValue = objectiveFunction(particles(i, :));
            personalBestValue(i) = currentValue;

            % Update personal best
            if personalBestValue(i) < objectiveFunction(personalBest(i, :))
                personalBest(i, :) = particles(i, :);
            end
            
            % Update local best
            if personalBestValue(i) < localBestValue
                localBest = personalBest(i, :);
                localBestValue = personalBestValue(i);
            end
        end

        % Update particle velocities and positions
        for i = 1:nParticles
            r1 = rand(1, 2);
            r2 = rand(1, 2);
            velocities(i, :) = w * velocities(i, :) + c1 * r1 .* (personalBest(i, :) - particles(i, :)) + c2 * r2 .* (localBest - particles(i, :));
            particles(i, :) = particles(i, :) + velocities(i, :);

            % Ensure particles stay within the bounds
            particles(i, :) = min(max(particles(i, :), xMin), xMax);
        end

        % Store the local best solution at each iteration
        allLocalBest(iter, :) = localBest;
    end

    % Store the local best solution and value
    localBestSolutions(run, :) = localBest;
    localBestValues(run) = localBestValue;
end

% Find unique local best solutions and values
[uniqueSolutions, ia, ~] = unique(localBestSolutions, 'rows');
uniqueValues = localBestValues(ia);

% Calculate the objective function values for the unique solutions
uniqueObjectiveValues = zeros(size(uniqueSolutions, 1), 1);
for i = 1:size(uniqueSolutions, 1)
    uniqueObjectiveValues(i) = objectiveFunction(uniqueSolutions(i, :));
end

% Display all the unique local best solutions and their corresponding objective values
fprintf('All Minimum Points Found by PSO:\n');
fprintf('Solutions:\n');
disp(uniqueSolutions);
fprintf('Objective Values:\n');
disp(uniqueObjectiveValues);
