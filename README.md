# PictOric
Image conversion tool for the Oric machines.

## Features
* Powerful image conversion algorithm adapted to [Oric's gfx constraints](http://osdk.org/index.php?page=articles&ref=ART9).
* [Victor Ostromoukhov](http://www-perso.iro.umontreal.ca/~ostrom/varcoeffED/SIGGRAPH01_varcoeffED.pdf)'s error-diffusion coefficients.
* Works as GrafX2 external script.
* Works in command-line:
	* accept 24bits uncompressed BMP natively.
	* uses Image-magick convert tool to accept any input image.
* TAP file is created next to the input image.
* Optionnally:
	* saves a BMP preview of the converted file next to the TAP file (*on* by default, see code).
	* Adds a basic loader in the TAP file (*on* by default, see code). You just then need to `CLOAD ""` to view the picture on the oric.
	* Starts an emulator on the generated TAP file when the conversion finishes (*off* by default, see code).
	  <img src="http://forum.defence-force.org/download/file.php?id=1672&t=1">

## Installation

Just copy [PictOric.lua](./PictOric.lua) wherever you want (possibly inside the share/grafx2/scripts folder). 

If you intend to use it in command-line, add the appropriate exes (convert and luajit) next to the lua script. 

*Notice*: 
* Windows exes are available in the tools/winb32 folder. 
* For other machine/platform, you'll have to manually compile the LuaJIT and ImageMagick projects sitting in the tools folder.

## Usage 

* *from GrafX2*: 
  Simply click on the "Fx" button in the GUI and navigate to the folder where you saved PictOric.lua and select it. Conversion takes around 20secs usually.
  
  <img src="http://forum.defence-force.org/download/file.php?id=1727&t=1">

* *from the command line*: 
  To run it from the command-line just run:
```
              <lua-interperter> oric_tst5.lua <filename>.<ext>
```
  where:
  * `<lua-intepreter>` is the lua interpreter you want to use (LuaJIT.exe for instance under windows)
  * `<filename>.<ext>` is the full path to the picture you want to convert
  Conversion time is much smaller when using LuaJIT than when using the builtin interpreter of GrafX2.
	
## Discussion
The discussion about this algorithm takes place on the [Defence-Force forum](http://forum.defence-force.org/viewtopic.php?p=20025#p20025)

## Samples
<img src="http://forum.defence-force.org/download/file.php?id=1700"> <img src="http://forum.defence-force.org/download/file.php?id=1719">
<img src="http://forum.defence-force.org/download/file.php?id=1698"> <img src="http://forum.defence-force.org/download/file.php?id=1718">
<img src="http://forum.defence-force.org/download/file.php?id=1717"> <img src="http://forum.defence-force.org/download/file.php?id=1763">

<img src="http://forum.defence-force.org/download/file.php?id=1840">

Source | Converted
---|----
<img with="65%" height="65%" src="http://forum.defence-force.org/download/file.php?id=1663&t=1"> | <img src="http://forum.defence-force.org/download/file.php?id=1660">
<img halign="center" with="135%" height="135%" src="http://forum.defence-force.org/download/file.php?id=1678"> | <img src="http://forum.defence-force.org/download/file.php?id=1680">

