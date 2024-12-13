How the Script Works
Initialize COMSOL:
The script imports the required COMSOL classes (com.comsol.model.* and com.comsol.model.util.*) and initializes the environment with ModelUtil.create.

Create a Geometry:
The sphere geometry is defined using the geom object, where sph specifies the sphere feature.

Set Cylindrical Reactor Properties:
The radius and height of the reactor is defined with radiusCylinder and heightCylinder, respectively.

Set Sphere Properties:
The radius of the sphere is defined with the .set('r', radius) method.

Build and Save:
The geometry is built using the .run method, and the model can optionally be saved as a COMSOL model file (.mph).

Prerequisites
You need to have COMSOL Multiphysics with MATLAB LiveLink installed and licensed.
Ensure the COMSOL LiveLink for MATLAB is set up correctly. You can check this in the COMSOL installation documentation.
Running the Script
Open MATLAB and ensure COMSOL LiveLink is active.
Run the script. COMSOL will launch in the background, create the bed of disperdes spheres, and optionally save the model to a file.
