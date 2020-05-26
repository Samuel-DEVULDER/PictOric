#!/bin/sh
# -----------------------------------------------------------------------------
set -e
cd "`dirname $0`"/..

# -----------------------------------------------------------------------------

ERRATT="0.998 0.500 0.000"
DITHER="0 -3 2 1"
RESULT=README.md

# -----------------------------------------------------------------------------

export LC_TIME=en_US.UTF-8
MAKE=${MAKE:-make}
MAKE="$MAKE --no-print-directory --output-sync" # -j$NUMBER_OF_PROCESSORS

# -----------------------------------------------------------------------------
# remove space in file names
for n in inputs/*" "*
do
	if test -f "$n"; then mv "$n" "${n// /_}"; fi
done

# -----------------------------------------------------------------------------
# convert picture to png & proper size
for n in inputs/*.*
do
	case "$n" in
	*.md|*.png|*.sh) ;;
	*) 	if test -f "$n"
		then
			convert "$n" -resize 240x200 -gravity center -background black -extent 240x200 "${n%.*}.png" 2>/dev/null || true
		fi;;
	esac
done

# -----------------------------------------------------------------------------
# generate libpipi versions
dir=outputs/libpipi
if test ! -d $dir; then mkdir -p $dir; fi
$MAKE libpipi | tee -a $dir/log.txt

# -----------------------------------------------------------------------------
# generate PictOric versions
PAIR=.pair
echo -n >$PAIR
for aic in 0 1 
do		
for dither in $DITHER 
do
for att in $ERRATT
do
	dir="outputs/a${aic}d${dither}e${att}"
	if test ! -d "$dir"; then mkdir -p "$dir"; fi
	
	echo >>$PAIR "$dir" "aic=$aic, dither_lvl=$dither, err_att=$att"		
	cat >$dir/.pictoric.lua <<EOF
return {
	aic=$aic,
	dist2_alg = 1,
	dither_lvl=$dither,
	err_att=$att,
	oric_emul = "",
	save_bmp = 1
}
EOF
	
	$MAKE $dir.dir | tee -a $dir/log.txt
done
done
done

# -----------------------------------------------------------------------------
# Generae result file
echo -n Generating $RESULT..

LEN=""; for i in {1..56}; do LEN="$LEN&nbsp;"; done

echo  >$RESULT    "# Here is a comparison of various settings on various pictures"
echo >>$RESULT
echo >>$RESULT "Click on picture to download the TAP file."
echo >>$RESULT
echo >>$RESULT -n "$LEN<br>source image<br>$LEN | $LEN<br>\`libpipi\`<br>$LEN"
cat $PAIR | while read d t
do
	echo >>$RESULT -n " | \`PictOric\`<br>$LEN<br>${t// /<BR>}"
done
echo >>$RESULT

echo >>$RESULT -n "--|--"
cat $PAIR | while read d t
do
	echo >>$RESULT -n "|--"
done
echo >>$RESULT

for n in inputs/*.png
do
	n=`basename $n`
	# echo -n ${n%.*}...
	echo >>$RESULT -n "<a href="./$n"><img width=240 height=200	src=\"./inputs/$n\" title=\"$n\"></a>"
	echo >>$RESULT -n "| <a href=\"./outputs/libpipi/${n%.*}.tap\"><img width=240 height=200 src=\"./outputs/libpipi/$n\"></a>"
	cat $PAIR | while read d t
	do
		echo >>$RESULT -n "| <a href=\"./$d/${n%.*}.tap\"><img id=\"$d/$n\" width=240 height=200 src=\"./$d/$n\" title=\"$t\"></a>"
		prev="$d/$n"
	done
	echo >>$RESULT
done
echo >>$RESULT
echo >>$RESULT "Generated on: " `date`
echo done

# -----------------------------------------------------------------------------
# cleanup
rm $PAIR
