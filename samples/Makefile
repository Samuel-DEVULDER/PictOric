LUA=../tools/winb32/luajit.exe
PICTORIC=../PictOric.lua
CONVERT=convert

INPUTS=$(wildcard inputs/*.png)

PIPI=tools/pipi.exe

all:
	@MAKE=$(MAKE) sh tools/runme.sh
	
git:
	git commit -a -m "samples updated on `date`"

github: git
	git push

clean:
	@echo -n "Cleaning..."
	@rm -r outputs README.md 2>/dev/null || true
	@echo done
	
libpipi: $(INPUTS:inputs/%=outputs/libpipi/%)

outputs/%: 
	make DIR=$* $(INPUTS:inputs/%=$*/%)

output/libpipi/%.png: inputs/%.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "output/libpipi/$*.bmp"
	@$(PIPI) "output/libpipi/$*.bmp" -o "output/libpipi/$*.tap" "output/libpipi/$*.tap" -o "$@"
	@rm "output/libpipi/$*.bmp"
	@echo "done"
	
$(DIR)/%.png: inputs/%.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "$(DIR)/$*.bmp"
	@HOME="$(DIR)" USERPROFILE="$(DIR)" $(LUA) $(PICTORIC) "$(DIR)/$*.bmp" 2>&1 1>/dev/null | \
		sed -e  's%.*:\s*\(.*\)[\r\n].*%\1%;s%\s*$$%%g'
	@$(CONVERT) "$(DIR)/$*.tap.bmp" "$@" && rm "$(DIR)/$*.tap.bmp"
