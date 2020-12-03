# PictOric
Image conversion tool for the [Oric](https://en.wikipedia.org/wiki/Oric) machines.

## Features
* Powerful image conversion algorithm adapted to [Oric's gfx constraints](http://osdk.org/index.php?page=articles&ref=ART9).
* [Victor Ostromoukhov](http://www-perso.iro.umontreal.ca/~ostrom/varcoeffED/SIGGRAPH01_varcoeffED.pdf)'s error-diffusion coefficients.
* Works as GrafX2 external script.
* Works in command-line:
	* basically accepts 24bits uncompressed BMP natively as input,
	* but can use Image-magick's `convert` tool to support any other types of images.
* TAP file is created next to the input image.
* Optionally:
	* Saves a BMP preview of the converted file next to the TAP file (*on* by default, see code).
	* Adds a basic loader in the TAP file (*on* by default, see code).\
	  You just then need to type `CLOAD ""` to load and display the picture on the machine.
	* Starts an emulator on the generated TAP file when the conversion finishes (*off* by default, see code).
	  <img src="http://forum.defence-force.org/download/file.php?id=1672&t=1">

## Installation

Just copy [PictOric.lua](./PictOric.lua) wherever you want (possibly inside the share/grafx2/scripts folder). 

If you intend to use it in command-line, add the appropriate exes (`convert` and `luajit`) in your path or next to the lua script. 

*Notice*: 
* Windows exes are available in the tools/winb32 folder. Standalone `convert.exe`can also be found inside [that installer](https://imagemagick.org/download/binaries/ImageMagick-7.0.10-10-Q16-x64-static.exe).
* For other machine/platform, you'll have to manually compile the LuaJIT and ImageMagick projects sitting in the tools folder.

## Usage 

* __from GrafX2__, simply click on the "Fx" button in the GUI and navigate to the folder where you saved `PictOric.lua` and double click on it.
  
  <img src="http://forum.defence-force.org/download/file.php?id=1775&t=1">
  
  Conversion takes typically around 20secs on modern machines (by 2020 standards ;) ).

* __from the command line__, just run:
  
  ```<lua-interperter> <path-to>PictOric.lua <filename>.<ext>```
  
  or if you are running on some linux variant where both `lua` and `PictOric.lua`are on the `$PATH`
  
  ```PictOric.lua <filename>.<ext>```
  
  where:
  * `<lua-intepreter>` is the lua interpreter you want to use (LuaJIT.exe for instance under windows)
  * `<filename>.<ext>` is the full path to the picture you want to convert.
  
  Conversion time is much smaller when using LuaJIT than when using the builtin interpreter of GrafX2.
	
## Discussion
The discussion about this algorithm takes place on the [Defence-Force forum](http://forum.defence-force.org/viewtopic.php?p=20025#p20025)

## Samples
<img src="http://forum.defence-force.org/download/file.php?id=1700"> <img src="http://forum.defence-force.org/download/file.php?id=1719">
<img src="http://forum.defence-force.org/download/file.php?id=1698"> <img src="http://forum.defence-force.org/download/file.php?id=1718">
<img src="http://forum.defence-force.org/download/file.php?id=1717"> <img src="http://forum.defence-force.org/download/file.php?id=1763">
<img src="http://forum.defence-force.org/download/file.php?id=2085"> <img src="http://forum.defence-force.org/download/file.php?id=2084">
<img src="http://forum.defence-force.org/download/file.php?id=1702">

Source | Converted
---|----
<img with="65%" height="65%" src="http://forum.defence-force.org/download/file.php?id=1663&t=1"> | <img src="http://forum.defence-force.org/download/file.php?id=1660">
<img halign="center" with="135%" height="135%" src="http://forum.defence-force.org/download/file.php?id=1678"> | <img src="http://forum.defence-force.org/download/file.php?id=1680">

<img src="http://forum.defence-force.org/download/file.php?id=1840">
