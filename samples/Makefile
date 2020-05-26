PIPI=tools/pipi.exe
LUA=../tools/winb32/luajit.exe
PICTORIC=../PictOric.lua
CONVERT=convert

INPUTS=$(wildcard inputs/*.png)
OUTPUTS=outputs

.PHONY: outputs/a0d0e0.998 $(wildcard OUTPUTS/*)

all:
	@MAKE=$(MAKE) sh tools/runme.sh
	
git:
	git commit -a -m "samples updated on `date`"

github: git
	git push

clean:
	-rm -r $(OUTPUTS) README.md
	
libpipi: 
	@echo "*** Update started on `date` for $@"
	@$(MAKE) $(INPUTS:inputs/%=$(OUTPUTS)/libpipi/%)
	@echo "*** Update ended on `date` for $@"

$(OUTPUTS)/%.dir:
	@echo "*** Update started on `date` for $*"
	@$(MAKE) DIR=$(OUTPUTS)/$* $(INPUTS:inputs/%=$(OUTPUTS)/$*/%)
	@echo "*** Update ended on `date` for $*"

$(OUTPUTS)/libpipi/%.png: inputs/%.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "$(OUTPUTS)/libpipi/$*.bmp"
	@$(PIPI) "$(OUTPUTS)/libpipi/$*.bmp" -o "$(OUTPUTS)/libpipi/$*.tap" "$(OUTPUTS)/libpipi/$*.tap" -o "$@"
	@rm "$(OUTPUTS)/libpipi/$*.bmp"
	@echo "done"
	
$(DIR)/%.png: inputs/%.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "$(DIR)/$*.bmp"
	@HOME="$(DIR)" USERPROFILE="$(DIR)" $(LUA) $(PICTORIC) "$(DIR)/$*.bmp" 2>&1 1>/dev/null | \
		sed -e  's%.*:\s*\(.*\)[\r\n].*%\1%;s%\s*$$%%g'
	@$(CONVERT) "$(DIR)/$*.tap.bmp" "$@" && rm "$(DIR)/$*.tap.bmp" "$(DIR)/$*.bmp"
