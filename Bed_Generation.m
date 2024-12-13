% Start COMSOL server
import com.comsol.model.*
import com.comsol.model.util.*

% Initialize COMSOL and create a new model
ModelUtil.clear;
model = ModelUtil.create('Model');
model.modelNode.create('comp1');

% Define parameters for particles confined in a cyliendrical reactor
radiusCylinder = 0.0127;       % Radius of the cylinder
heightCylinder =0.254;       % Height of the cylinder
particleRadius = 1.75e-04;     % Radius of the spherical particles


Bulk_Volume = (pi/4) * (2*radiusCylinder)^2 * heightCylinder;
Solid_Volume = (pi/6) * (2*particleRadius)^3;
Bulk_Volume_Fraction = 0.4

%numParticles = ceil(Bulk_Volume * Bulk_Volume_Fraction/Solid_Volume);
numParticles = 10;

% Set the geometry in the model
geom = model.geom.create('geom1', 3);

% Get initial positions of particles from your existing model
initialPosition = [0.065, 0.110,0.020];  % Initial position of particles
% Initialize an array to store particle positions
particlePositions = zeros(numParticles+7203, 3);
counter = 0;
% Create particles inside the cylinder based on initial positions
for i = 1:numParticles
    
    % Generate random displacements for each particle within the cylinder
    theta = 2 * pi * rand; % Random angle
    r = radiusCylinder * sqrt(rand); % Random radius within the circle
    x = initialPosition(1) + r * cos(theta); % Random x-coordinate
    y = initialPosition(2) + r * sin(theta); % Random y-coordinate
    z = initialPosition(3) + heightCylinder * rand; % Random z-coordinate

   % x = initialPosition(1) + radiusCylinder * (2*rand - 1); % Random x-coordinate
   % y = initialPosition(2) + radiusCylinder * (2*rand - 1); % Random y-coordinate
   % z = initialPosition(3) + heightCylinder * rand; % Random z-coordinate

    % Check for collisions with existing particles
    isCollision = true;
    while isCollision
        isCollision = false;
        % Check for collision with existing particles
        for j = 1:i-1
            distance = norm([x, y, z] - particlePositions(j, :));
            if distance < (2 * particleRadius)% Check for overlap
                isCollision = true;
                % Regenerate random position
                theta = 2 * pi * rand; % Random angle
                r = radiusCylinder * sqrt(rand); % Random radius within the circle
                x = initialPosition(1) + r * cos(theta); % Random x-coordinate
                y = initialPosition(2) + r * sin(theta); % Random y-coordinate
                z = initialPosition(3) + heightCylinder * rand; % Random z-coordinate
                break;  % Exit loop if collision detected
            end
        end
    end
    % Store particle position
    
    particlePositions(i, :) = [x, y, z];
   
    
    % Create a sphere for the particle

     if i == 1
        geom.create(['sph' num2str(i)], 'Sphere');
        geom.feature(['sph' num2str(i)]).set('r', particleRadius);
        geom.feature(['sph' num2str(i)]).set('pos', initialPosition);
     else
        geom.create(['sph' num2str(i)], 'Sphere');
        geom.feature(['sph' num2str(i)]).set('r', particleRadius);
        geom.feature(['sph' num2str(i)]).set('pos', [x y z]);
     end

     counter=counter + 1;
     progress=100*(counter/numParticles)
end

% Build the geometry
model.geom('geom1').run;


% Save the modified model
model.save('GeldarB_bed.mph');

disp('COMSOL model with randomly distributed particles with initial positions confined in a cylindrical box has been generated and saved.');

