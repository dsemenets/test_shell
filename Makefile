PREBUILDS = ../prebuilds
QEMU = qemu-system-aarch64
CPU = cortex-a53
CPU_OPT = -cpu ${CPU}
MACHINE_OPT = -machine virt,gic-version=3,virtualization=true
DBG = -gdb tcp::4224
ZEPHYR = build/zephyr/zephyr.bin
OPTS = -chardev stdio,id=con,mux=on -serial chardev:con -mon chardev=con,mode=readline
SHIELD = -DSHIELD=xen_dom0
.PHONY: build rebuild run

build:
	west build -b qemu_cortex_a53 -- ${SHIELD}

rebuild:
	west build -b qemu_cortex_a53 -p always -- ${SHIELD}

menuconfig:
	west build -b qemu_cortex_a53 -t menuconfig -- ${SHIELD}

update:
	cd .. && west update

wrun:
	west build -t run
run:
	${QEMU} ${DBG}  ${CPU_OPT} -m 6G -nographic ${MACHINE_OPT}  -device loader,file=${ZEPHYR},addr=0x40600000 -dtb ${PREBUILDS}/virt_gicv3.dtb ${OPTS}  -kernel ${PREBUILDS}/xen

debug:
	${QEMU} ${DBG}  ${CPU_OPT} -S -m 6G -nographic ${MACHINE_OPT}  -device loader,file=${ZEPHYR},addr=0x40600000 -dtb ${PREBUILDS}/virt_gicv3.dtb ${OPTS}  -kernel ${PREBUILDS}/xen
