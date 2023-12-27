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

all : $(TARGET).bin $(TARGET).hex $(TARGET).elf

$(TARGET).bin : $(TARGET).elf
	$(OC) -O binary $< $@

$(TARGET).hex : $(TARGET).elf
	$(OC) -O ihex $< $@

$(TARGET).elf : $(SRCFILES) $(SYSFILES)
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)
	$(OD) -S $@ > $(TARGET).lst
	$(OD) -t $@ > $(TARGET).map
	
clean :
	rm -rf $(TARGET).elf $(TARGET).bin $(TARGET).hex $(TARGET).lst $(TARGET).map
