.include "man/animations.h.s"

.globl _spr_mago_0
.globl _spr_mago_4

magoQuieto:
    DefineFrame mago_0, 0x0C, #_spr_mago_0
    DefineFrame mago_1, 0x0C, #_spr_mago_4
    DefineFrame mago_fin, 0x00, magoQuieto
    