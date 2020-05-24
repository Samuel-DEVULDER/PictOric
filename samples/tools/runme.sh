#!/bin/sh

set -e

cd "`dirname $0`"/..

export HOME=$PWD
export USERPROFILE=`cygpath -s -w "$HOME"`

dir=libpipi
if [ ! -d $dir ]; then mkdir $dir; else rm $dir/* || true; fi
for n in *.*
do
	if test -f "$n"
	then
		echo -n "$dir/$n..."
		if convert "$n"  -resize 240x200 -gravity center -background black -extent 240x200 .pictoric.bmp 2>/dev/null
		then
			if cmp -s "$n" "${n%.*}.png"
			then
				true
			else
				rm "$n"
				cp .pictoric.bmp "${n%.*}.png"
			fi
			tools/pipi.exe .pictoric.bmp -o .pictoric.tap .pictoric.tap -o .pictoric.bmp
			convert ".pictoric.bmp" "$dir/${n%.*}.png"
			mv .pictoric.tap "$dir/${n%.*}.tap"
		fi
		echo done
	fi
done
sleep 10

for att in 0.998 0.707 0.500
do
	for aic in 0 1 
	do		
		for dither in 0 -3 2 
		do
			params="aic=$aic, dither_lvl=$dither, err_att=$att"
		
			cat >$HOME/.pictoric.lua <<EOF
return {
	dist2_alg = 1,
	oric_emul = "",
	save_bmp = 1,
	$params
}
EOF
			
			dir="$params"
	
			if [ ! -d "$dir" ]; then mkdir "$dir"; else rm "$dir"/* || true; fi
			echo -n >"$dir/log.txt"
			cp "$HOME/.pictoric.lua" "$dir/"
			
			echo ""
			for n in *.png
			do
				cp "$n" .pictoric.pix
				echo -n "$dir/${n%.*}..." | tee -a "$dir/log.txt"
				# set -x
				../tools/winb32/luajit.exe ../PictOric.lua .pictoric.pix 2>&1 1>/dev/null | sed -e  's%.*:\s*\(.*\)[\r\n].*%\1%;s%\s*$%%g'| tee -a "$dir/log.txt"
				convert .pictoric.tap.bmp "$dir/${n%.*}.png"
				cp .pictoric.tap "$dir/${n%.*}.tap"
			done
			sleep 10
		done
	done
done

rm .pictoric.* || true

HLINE="--|--"
HEADER="<div style=\"width:240px\">source image</div>"
HEADER="$HEADER | <div style=\"width:240px\">\`libpipi\`</div>"	
for i in *=* 
do 
	HLINE="$HLINE|--"
	HEADER="$HEADER | <div style=\"width:240px\">\`PictOric\`<br><br>${i// /<br>}</div>"
done

cat >result.md <<EOF
# Here is a comparison of various settings on various pictures
$HEADER
$HLINE
EOF

for n in *.png
do
	LINE="<a href="./$n"><img width=240 height=200	src=\"./$n\" title=\"$n\"></a>"
	LINE="$LINE | <a href=\"./libpipi/${n%.*}.tap\"><img width=240 height=200 src=\"./libpipi/$n\"></a>"
	for d in *=*
	do	
		LINE="$LINE | <a href=\"./$d/${n%.*}.tap\"><img width=240 height=200 src=\"./$d/$n\" title=\"$d\"></a>"
	done
	echo >>result.md $LINE
done
echo >>result.md "(Click to get the TAP file.)"