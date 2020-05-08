# PictOric
Image conversion tool for the Oric machine.

Features:
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
	