


CFLAGS = -g -Os -Wall

.PHONY: all
all: main exe_mini.bin exe_mini.hex exe_mini.dump inj.sh



# main: main.o exe.o
main: main.o exe_mini.o
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

TEMP += main main.o exe_mini.o

exe_mini.bin: exe_mini.o
	objcopy --only-section=.text -O binary $< $@

TEMP += exe_mini.bin

exe_mini.hex: exe_mini.bin
	hexdump -e '16/1 "%02x " "\n"' $< > $@

TEMP += exe_mini.hex

exe_mini.dump: exe_mini.o
	objdump -Mintel -d $< > $@

TEMP += exe_mini.dump

inj.sh: mk_inj.sh exe_mini.bin
	./mk_inj.sh > $@
	chmod 755 $@

TEMP += inj.sh

.PHONY: clean
clean:
	rm -f $(TEMP)
