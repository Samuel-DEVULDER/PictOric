# PictOric
Image conversion tool for the [Oric](https://en.wikipedia.org/wiki/Oric) machines.

## Features
* Powerful image conversion algorithm adapted to [Oric's gfx constraints](http://osdk.org/index.php?page=articles&ref=ART9).
	* [Victor Ostromoukhov](http://www-perso.iro.umontreal.ca/~ostrom/varcoeffED/SIGGRAPH01_varcoeffED.pdf)'s variable error-diffusion coefficients algorithm.
	* Special Ordered dithering algorithm. **New v1.3**\
	  By default Bayer's matrix (2x2, 4x4, 8x8, 16x16, 32x32) and clustered matrices (3x3, 6x6, 12x12, 24x24, 48x48) are provided. But you can add new ones in the configuration file. 
* AIC images can be generated. **New v1.3**\
  You can choose the color pair by yourself or let the tool choose for you.
* Works as GrafX2 external script.
	* Easy access to most configuration parameters is possible via the UI. **New v1.3**
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
* Windows exes are available in the tools/winb32 folder. Standalone `conver.exe`can also be found inside [that installer](https://imagemagick.org/download/binaries/ImageMagick-7.0.10-10-Q16-x64-static.exe).
* For other machine/platform, you'll have to manually compile the LuaJIT and ImageMagick projects sitting in the tools folder.

## Usage 

* __from GrafX2__, simply click on the "Fx" button in the GUI and navigate to the folder where you saved `PictOric.lua` and double click on it.
  
  <img src="http://forum.defence-force.org/download/file.php?id=1775&t=1">
  
  Conversion takes typically around 20secs on modern machines (by 2020 standards ;) ).
  
  If you press the "x" key while pushing the "Run" button a Window will pop up allowing you to enable the **AIC Mode** or the **Ordered dithering mode** as well as changing various configuration parameters (see below.) These parameters will be reused the next time you run the tool (even on the command line). If you want to tweek other parameters, just select the "Extra settings" entry and press "Ok". Another window will appear with even more parameters to change. In case you want to revert to the default settings, check the "Reset all to defaults" entry and press Ok. If you don't want you changes to be applied, just press the "Cancel" button, otherwise the "Ok" button applies and saves the settings to disk. 

* __from the command line__, just run:
  
  ```<lua-interperter> <path-to>PictOric.lua <filename>.<ext>```
  
  where:
  * `<lua-intepreter>` is the lua interpreter you want to use (LuaJIT.exe for instance under windows)
  * `<filename>.<ext>` is the full path to the picture you want to convert.
  
  Conversion time is much smaller when using LuaJIT than when using the builtin interpreter of GrafX2.

## Parameters

PictOric saves its configuration paramters in the LUA file `$HOME/.pictoric.lua` for Unix-like machines and under `%USERPROFILE%\.pictoric.lua` for windows-like machines. If it is missinbg or contains syntax-errors, il will be ignored and a default one will be used by the tool.

### Adding other dithering patterns

You can add other dithering patterns to the tool by adding a entries like `[n] = { {a11,a12,...}, {a21, a22, ...}, ... }` representing a [threshold map](https://en.wikipedia.org/wiki/Ordered_dithering)  (integers starting from 1, like in Image Magick's [threshold.xml](http://www.imagemagick.org/source/thresholds.xml) file) in the `dither_mat = {}` entry of the returned structure. That matrix will be used if you enter `n` as the dither-level in the UI (`n` can be any non zero integer). For instance if you have
```
	...
    dither_map = {
		[1] = {{1,1},
		       {2,2}}
	},
	...
```
Then selecting "1" as dither-level will use horizontal-lines patterns for dithering instead of the classical 2x2 Bayer matrix.
	
### Suggested values

By default, PictOric uses a 0.998 error damping factor. The closest it is to one, the more the error will propagate to the surrounding pixels allowing it to be corrected. This works well for the default error-diffusion algorithm because it has lots of degrees of freedom to correct the errors. However, if you plan to used Ordered dithering or even simple AIC images, there is much less possibility to correct an error in its local neighbourhood. So it is propagated rather far away in the pictures leaving some ugly artifacts if you keep that parameter close to the unit. Therefore it is suggessted that you use a value of 0.707 (sqrt(2)) when you inted to make AIC or Ordered-dithering pictures.

If you use 0 as aic color #1 or color #2, the tool will find the best color pair it can to reduce the global error in AIC mode. However this is slow and I'm often quite unhappy with the chosend picture. So for the moment I **strongly** encourage you to use the 3,6 as color pair. This pair offers a wide variety of colors and produces very good looking pictures most of the time.

A good Bayer's ordered dithering matrix is the 8x8 one which is select with level=3. But for AIT the 6x6 matrix (level=-2) usually provide nice result (see sample below.)

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

<img src="http://forum.defence-force.org/download/file.php?id=2145&sid=9efc468fe649d142e40b547b6e3b6566">