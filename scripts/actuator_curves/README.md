## README

This subfolder contains the following three python script files: 

```
+-- actuator_curves
|  components.py
|  generateDB.py
|  plotActuatorCurves.py
```

### `components.py`

This script defines the classes of `motor`, `reducer` and the `actuator`. It also has the functions that `copmuteMotorCurves` as well as `computeActuatorCurves`. 

### `generateDB.py`

This scripts creates a dictionary database of components and actuators where each motor, reducer or actuator combination and all its parameters are defined. 

### `plotActuatorCurves.py`

This scripts extracts the data from the previously generated database and plots the actuator curves for teh actuator combination selected in the script. 


### How to Use these Scripts: 

1. Run the `generateDB.py`. This will create two databases, namely  `componentsDB.dat` and `actuatorsDB.dat`. 
2. Comment/Uncomment the desired actuator combination from the ones defined in the script `plotActuatorCurves.py`.
3. Run `plotActuatorCurves.py`. 