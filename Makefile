SRC		:=	$(wildcard src/*.v)

FAMILY		:=	synth_ice40
DEVICE		:=	8k
PACKAGE		:=	cm81

TARGET		:=	$(DEVICE)-$(PACKAGE).bin

all			:	build
				tinyprog -p $(TARGET)

build		:	$(TARGET)

clean		:
				$(RM) $(TARGET:.bin=.blif)
				$(RM) $(TARGET:.bin=.asc)

fclean		:	clean
				$(RM) $(TARGET)

re			:	fclean all

prepare		:
				@./prepare.sh
				@echo "\033[1;31mPlease run 'source $(shell pwd)/.env/bin/activate' to update your environment.\033[0m"
				@echo ""

help		:
				@echo "Usage: make [all|clean|fclean|re]"
				@echo "  all:    build and program the FPGA"
				@echo "  build:  build the FPGA"
				@echo "  clean:  remove build files"
				@echo "  fclean: remove build files and target"
				@echo "  re:     fclean and all"
				@echo "  prepare: prepare the development environment"
				@echo "  help:   print this message"

.PHONY		:	all build clean fclean re prepare help

%.blif		:	%.v $(SRC)
				yosys -p '$(FAMILY) -top top -blif $@' $^

%.asc		:	%.blif %.pcf
				arachne-pnr -d $(DEVICE) -P $(PACKAGE) -p $(@:.asc=.pcf) -o $@ $<

%.bin		:	%.asc
				icepack $< $@
