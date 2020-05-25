#!/bin/sh
# -----------------------------------------------------------------------------
set -e
cd "`dirname $0`"

# -----------------------------------------------------------------------------

ERRATT="0.998 0.500 0.000"
DITHER="0 -3 2 1"
RESULT=result.md

# -----------------------------------------------------------------------------

export LC_TIME=en_US.UTF-8
NUMBER_OF_PROCESSORS=${NUMBER_OF_PROCESSORS:-1}
if test $NUMBER_OF_PROCESSORS -eq 1; then NUMBER_OF_PROCESSORS=2; fi
MAKE=${MAKE:-make -j`expr $NUMBER_OF_PROCESSORS - 1`}
MAKE="$MAKE --no-print-directory"

# -----------------------------------------------------------------------------
# remove space in file names
for n in *" "*
do
	if test -f "$n" 
	then
		mv "$n" "${n// /_}"
	fi
done

# -----------------------------------------------------------------------------
# convert picture to png & proper size
for n in *.*
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
dir=libpipi
if test ! -d $dir; then mkdir $dir; fi
TARGET=""; for n in *.png; do TARGET="$TARGET $dir/$n"; done
echo >>$dir/log.txt "*** Update started on `date`"
$MAKE $TARGET | tee -a $dir/log.txt
echo >>$dir/log.txt "*** Update ended on `date`"

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
	dir="a${aic}d${dither}e${att}"
	if test ! -d "$dir"; then mkdir "$dir"; fi
	
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
	TARGET=""
	for n in *.png; do TARGET="$TARGET $dir/$n"; done

	echo >>$dir/log.txt "*** Update started on `date`"
	$MAKE $TARGET "DIR=$dir"  | tee -a $dir/log.txt
	echo >>$dir/log.txt "*** Update ended on `date`"
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

for n in *.png
do
	# echo -n ${n%.*}...
	echo >>$RESULT -n "<a href="./$n"><img width=240 height=200	src=\"./$n\" title=\"$n\"></a>"
	prev="libpipi/$n"
	echo >>$RESULT -n "| <a href=\"./libpipi/${n%.*}.tap\"><img id=\"$prev\" width=240 height=200 src=\"./$prev\"></a>"
	cat $PAIR | while read d t
	do
		echo >>$RESULT -n "| <a href=\"./$d/${n%.*}.tap\"><img id=\"$d/$n\" width=240 height=200 src=\"./$d/$n\" title=\"$t\" onmousover=\"$prev.src='./libpipi/$n';\" onmouseout=\"$prev.src='./$d/$n';\"></a>"
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
