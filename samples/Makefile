LUA=../tools/winb32/luajit.exe
PICTORIC=../PictOric.lua
CONVERT=convert

PIPI=tools/pipi.exe
LIBPIPI=libpipi

all:
	@MAKE=$(MAKE) sh runme.sh
	
clean:
	@echo -n "Cleaning..."
	@rm -r $(LIBPIPI) 2>/dev/null || true
	@for d in */.pictoric.lua; do x=`dirname "$$d"`; rm -r "$$x/"; done
	@echo done
	
$(LIBPIPI)/%.png: %.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "$(LIBPIPI)/$*.bmp"
	@$(PIPI) "$(LIBPIPI)/$*.bmp" -o "$(LIBPIPI)/$*.tap" "$(LIBPIPI)/$*.tap" -o "$@"
	@rm "$(LIBPIPI)/$*.bmp"
	@echo "done"
	
$(DIR)/%.png: %.png ../PictOric.lua
	@echo -n "$@..."
	@$(CONVERT) "$<" "$(DIR)/$*.bmp"
	@HOME="$$DIR" USERPROFILE="$$DIR" $(LUA) $(PICTORIC) "$(DIR)/$*.bmp" 2>&1 1>/dev/null | \
		sed -e  's%.*:\s*\(.*\)[\r\n].*%\1%;s%\s*$$%%g'
	@$(CONVERT) "$(DIR)/$*.tap.bmp" "$@" && rm "$(DIR)/$*.tap.bmp"
