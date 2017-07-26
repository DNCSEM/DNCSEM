# DNCSEM
DNCSEM is motivated from CSEM data processing. CSEM is abbrevated from Controlled Source Electromagnetic method, which is an important geophycical method.
Aiming to make denoising and processing more extensible and easily, we provide this open source GUI. We integrated those complicated math and algorithm into simple interfaces.
Many functionalities are contained in this project, where users can explore and make further use, both for time domain and frequency domain data edit.

The main part is TimeDomain_Process, which located in menu Process. In this modular, it contains 10 functions. 
##1.ReadFile provide a access to load some original data and translate into data file for further process.
##2.ReadData load the data file into matrix and vector, at the same time creat prepared file, such as initial NPC data file. 
##3.ResizeData is optimal functionality for conputational convenience.
##4.CWT_analysis is applied to find good locations, in which CWT_analysis is on NPC. 
##5.ChoosingLocations provides interactive interfaces to choose the first set of locations.
##6.SlovingEqautins_1 is to solve the overdetermiend equation constructed by previous process. 
##7.LocationsEdit provides an access to edit the locations, to delete those bad locations for example.
##8.SlovingEqautins_N is to solve the new overdetermiend equation after locations edit.
##9.LocationsAutomatic provides automatic locations chosen method, to make the denoising result more accurate, in which different threshold can be given based on different conditions.
##10.Output modular is to output the final result based on given conditions.
These functionalities can be used seperately for different purpose.
