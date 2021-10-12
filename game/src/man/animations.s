.include "man/animations.h.s"

.globl _spr_mago_0
.globl _spr_mago_1
.globl _spr_mago_2
.globl _spr_mago_3
.globl _spr_mago_4
.globl _spr_mago_5
.globl _spr_mago_6
.globl _spr_mago_7

mago_stop_down:
    DefineFrame mago_0, 0x0C, #_spr_mago_0
    DefineFrame mago_4, 0x0C, #_spr_mago_4
    DefineFrame mago_fin1, 0x00, mago_stop_down

mago_stop_right:
    DefineFrame mago_3, 0x0C, #_spr_mago_3
    DefineFrame mago_7, 0x0C, #_spr_mago_7
    DefineFrame mago_fin2, 0x00, mago_stop_right
    
mago_stop_left:
    DefineFrame mago_2, 0x0C, #_spr_mago_2
    DefineFrame mago_6, 0x0C, #_spr_mago_6
    DefineFrame mago_fin3, 0x00, mago_stop_left

mago_stop_up:
    DefineFrame mago_1, 0x0C, #_spr_mago_1
    DefineFrame mago_5, 0x0C, #_spr_mago_5
    DefineFrame mago_fin4, 0x00, mago_stop_up