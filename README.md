# StiffenedGas
A very simple Julia module to calculate pressure, temperature or density of a substance according to the stiffened gas equation of state (EoS). The stiffened gas law is sometimes useful to do some numerical calculations with a fairly simple EoS, even including liquids, but without losing time with nonlinear stuff. 

Please, do not consider the stiffened gas law to be the most physical representation of the thermodynamics of a liquid or a gas. Like everything else, it's just a model. It needs to be used with a grain of salt.

That being said, feel free to include it in your projects.

## Prerequisites
It does not require any additional package, you only need to have Julia v1.5.

## How do I install it? Why it does not work with pkg?
Being super simple, this is not even a real package, it's just a module that you need to include.

Using it is very simple:
* If you are using a julia editor (e.g., vscode), or simply running julia from the command line, you just need to copy this repository in your project directory. Afterwords, add to the file in which you plan to use calculate a variable using the stiffened gas EoS the following lines:

  `include("PATH_TO_THE_StiffenedGas.jl_FILE")` replacing PATH_TO_THE_StiffenedGas.jl_FILE with the actual directory of the StiffenedGas.jl file (directory relative to your project file).
  
  `import .StiffenedGas`
  
  `using .StiffenedGas`

   ATTENTION: PLEASE DO NOT FORGET THE POINT BEFORE StiffenedGas

   Now you can simply call the function "StiffenedGas.main( ... )" to calculate what you wish. It will return the selected desired quantity.

* If you are more of a jupyter-notebook type, you can find the notebook version in the "notebook" folder. Just download this folder if you are uniquely interested in the notebook version. On the contrary, if you only need a .jl version, you can simply delete this folder if it bothers you.

By the way, if you feel like this should really be a package, feel free to contact me or send me a pull request.

## How do I use this?
Again, very simple. Let's say you need to calculate the temperature T (in K) of a liquid of your choise, that we will name my_liquid. We are interested in what happens if
- pressure is p = 1e5 Pa
- density  is rho = 1000 kg/m^3. 
Furthermore, my_liquid has
- gamma = 1.2
- pinf = 8e9 Pa
- cp = 4800. J/kg/K.

The StiffenedGas.main function returns a number (Float64) representing the temperature, if you set a few parameters that you need to feel according to the julia sintactic rules (i.e., func(param1, param2, ...)):
Parameters:
1. desired quantity: a string with the name of the unknown, i.e., "temperature", "pressure", or "density"
2. given quantity #1: since we are calculating the temperature, we set here the pressure (in pascals)
3. given quantity #2: since we are calculating the temperature, we set here the density (in kg/m^3)
4. name of the material: a string with the name of the desired material.* In this case "my_liquid" (OPTIONAL)
5. gamma: a parameter of the stiffened gas law. It equals cp/cv. (OPTIONAL)
6. pinf: another parameter of the stiffened gas law. It represents attractive forces. (OPTIONAL)
7. cp: the specific heat capacity of your material, in J/kg/K. (OPTIONAL)
8. materialDatabase: you usually don't need to fill this in from a user perspective. (OPTIONAL)

So just type in your code:
`T = StiffenedGas.main("temperature", 1e5, 1e3, "my_liquid", 1.2, 8e9, 4800.)

If you instead need the pressure, you need to put the temperature (in K) as parameter 2.:
`p = StiffenedGas.main("pressure", 315.6, 1e3, "my_liquid", 1.2, 8e9, 4800.)

If you need the density from pressure and temperature, just put the temperature as parameter 2. and the pressure as parameter 3.:
`rho = StiffenedGas.main("density", 315.6, 1e5, "my_liquid", 1.2, 8e9, 4800.)

And there you go.

if you don't put any parameter other than the first three, than the calculation are performed considering a perfect gas named "default" with gamma = 1.4, pinf = 0.0, and a unitary molar mass.

*desired material: ideally I will add a few standard material to the database. Now only liquid water (enter "liquidwater" as parameter 4.) is available. The hope is that with the database one can avoid of putting gamma pinf and cp, and just enter the name of the desired material. Contact me if you wish to contribute!

Have fun!
