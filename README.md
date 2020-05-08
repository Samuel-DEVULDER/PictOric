# PictOric
Image conversion tool for the Oric machines.

## Features
* Powerful image conversion algorithm adapted to Oric's gfx constraints.
* Victor Ostromoukhov's error-diffusion coefficients (http://www-perso.iro.umontreal.ca/~ostrom/varcoeffED/SIGGRAPH01_varcoeffED.pdf).
* Works as GrafX2 External Script.
* Works in command-line:
	* accept 24bits uncompressed BMP natively.
	* uses Image-magick convert tool to accept any input image.
* TAP file is created next to the input image.
* Optionnally (on by default, see code) 
	* saves a BMP preview of the converted file next to the TAP file.
	* Adds a basic loader in the TAP file. (Just type "CLOAD" to view the picture.)
<img src="http://forum.defence-force.org/download/file.php?id=1672&t=1">

## Installation

Just copy PictOric.lua wherever you want (possibly inside the share/grafx2/scripts folder). 

If you intend to use it in command-line, add the appropriate exes (convert and luajit) next to the lua script. 

*Notice*: 
* Windows exes are available in the tools/winb32 folder. 
* For other machine/platform, you'll have to manually compile the LuaJIT and ImageMagick projects sitting in the tools folder.

## Usage 

### from GrafX2
Simply click on the "Fx" button in the GUI and navigate to the folder where you saved PictOric.lua and select it.
<img src="http://forum.defence-force.org/download/file.php?id=1727&t=1">

### from the command line
To run it from the command-line just run
```<lua-interperter> oric_tst5.lua <filename>.<ext>```
Where:
* `<lua-intepreter>` is the lua interpreter you want to use (LuaJIT.exe for instance under windows)
* `<filename>.<ext>` is the full path to the picture you want to convert
	
## Discussion
The discussion about this algorithm takes place on the [Defence-Force forum](http://forum.defence-force.org/viewtopic.php?p=20025#p20025)

## Samples
<img src="http://forum.defence-force.org/download/file.php?id=1700"> <img src="http://forum.defence-force.org/download/file.php?id=1719">
<img src="http://forum.defence-force.org/download/file.php?id=1698"> <img src="http://forum.defence-force.org/download/file.php?id=1718">
<img src="http://forum.defence-force.org/download/file.php?id=1717"> <img src="http://forum.defence-force.org/download/file.php?id=1763">
<img src="http://forum.defence-force.org/download/file.php?id=1762"> 

<img src="http://forum.defence-force.org/download/file.php?id=1840">

Source | Converted
---|----
<img src="http://forum.defence-force.org/download/file.php?id=1663&t=1"> | <img src="http://forum.defence-force.org/download/file.php?id=1660">
<img src="http://forum.defence-force.org/download/file.php?id=1678"> | <img src="http://forum.defence-force.org/download/file.php?id=1680">

