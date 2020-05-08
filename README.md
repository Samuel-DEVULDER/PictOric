# PictOric
Image conversion tool for the Oric machine.

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
	
## Discussion
The discussion about this algorithm takes place on the Defence-Force forum:
http://forum.defence-force.org/viewtopic.php?p=20025#p20025


## Samples:
Source | Converted
---|----
<img src="http://forum.defence-force.org/download/file.php?id=1663&t=1"> | <img src="http://forum.defence-force.org/download/file.php?id=1660">
<img src="http://forum.defence-force.org/download/file.php?id=1678"> | <img src="http://forum.defence-force.org/download/file.php?id=1680">

<img src="http://forum.defence-force.org/download/file.php?id=1700"> <img src="http://forum.defence-force.org/download/file.php?id=1719">
<img src="http://forum.defence-force.org/download/file.php?id=1698"> <img src="http://forum.defence-force.org/download/file.php?id=1718">
<img src="http://forum.defence-force.org/download/file.php?id=1717"> <img src="http://forum.defence-force.org/download/file.php?id=1763">
<img src="http://forum.defence-force.org/download/file.php?id=1762"> <img src="http://forum.defence-force.org/download/file.php?id=1840">
