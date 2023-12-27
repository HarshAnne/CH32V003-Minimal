## CONFIGURATION #############################################################

TARGET = Blink

## TOOLS #####################################################################

CC = riscv64-unknown-elf-gcc
OC = riscv64-unknown-elf-objcopy
OD = riscv64-unknown-elf-objdump

## OPTIONS ###################################################################

CFLAGS:=-march=rv32emc \
		-mabi=ilp32e \
		-I/usr/include/newlib \
		-nostdlib \
		-I.

LDFLAGS:=-T ch32v003.ld

## FILES #####################################################################

SRCFILES:= main.c
SYSFILES:= startup_ch32v00x.S system_ch32v00x.c

## TARGETS ###################################################################

$(TARGET).hex : $(TARGET).elf
	$(OD) -S $^ > $(TARGET).lst
	$(OD) -t $^ > $(TARGET).map
	$(OC) -O binary $< $@
	$(OC) -O ihex $< $@

$(TARGET).elf : $(SRCFILES) $(SYSFILES)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

clean :
	rm -rf $(TARGET).elf $(TARGET).bin $(TARGET).hex $(TARGET).lst $(TARGET).map
