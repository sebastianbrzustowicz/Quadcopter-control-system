# Quadcopter simulation in MATLAB/Simulink

Main objective was to model and design the control system for the quadcopter in simulation.   
Auxiliary scripts help to obtain the parameters of a specific physical quadcopter.   
Regulation method for attitude is PD approach.  
It is possible to use other control systems on the existing model.  

## Simulation example result
In a simulation it is possible to adjust trajectory or attitude as desired.

Position and attitude control:
<p align="center">
  <img src="https://github.com/sebastianbrzustowicz/Quadcopter-simulation/assets/66909222/639ddc2e-403c-49e3-8e2d-757c4fd235db" width="49%" height="auto"/>
  <img src="https://github.com/sebastianbrzustowicz/Quadcopter-simulation/assets/66909222/f11ace10-d537-4824-bee1-91825b3f0c01" width="49%" height="auto"/>
</p>

Visualisation of output data (sine wave desired altitude):

![Altitude_sine](https://github.com/sebastianbrzustowicz/Quadcopter-simulation/assets/66909222/61c91293-be52-4cb9-950e-3c093b689976)

Visualisation of output data (sine wave desired roll angle):

![Orientation_sine](https://github.com/sebastianbrzustowicz/Quadcopter-simulation/assets/66909222/fb353c09-91c2-4ed5-84b0-7c3b71f74747)

Control system structure:

![Closed_loop_quadcopter](https://github.com/sebastianbrzustowicz/Quadcopter-simulation/assets/66909222/7360aa53-fd18-4b61-8b31-a34e55ddf3c1)

## Folders

`model` - MATLAB/Simulink source files for simulation   
`Moment_of_inertia` - script for specifying quadcopter model parameters (rigid body)   
`Motors_characteristics` - script for specifying quadcopter model parameters (motors)  
`Tensometer_calibration` - script for calibrating a measuring tool  
