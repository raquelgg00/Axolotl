.include "man/animations.h.s"

.globl _spr_player1_00
.globl _spr_player1_01
.globl _spr_player1_02
.globl _spr_player1_03
.globl _spr_player1_04
.globl _spr_player1_05
.globl _spr_player1_06
.globl _spr_player1_07
.globl _spr_zombie_00
.globl _spr_zombie_01
.globl _spr_zombie_02
.globl _spr_zombie_03
.globl _spr_zombie_04
.globl _spr_zombie_05
.globl _spr_zombie_06
.globl _spr_zombie_07

player1_stop_down:
    DefineFrame 0x0C, #_spr_player1_00
    DefineFrame 0x0C, #_spr_player1_04
    DefineFrame 0x00, player1_stop_down

player1_stop_right:
    DefineFrame 0x0C, #_spr_player1_03
    DefineFrame 0x0C, #_spr_player1_07
    DefineFrame 0x00, player1_stop_right
    
player1_stop_left:
    DefineFrame 0x0C, #_spr_player1_02
    DefineFrame 0x0C, #_spr_player1_06
    DefineFrame 0x00, player1_stop_left

player1_stop_up:
    DefineFrame 0x0C, #_spr_player1_01
    DefineFrame 0x0C, #_spr_player1_05
    DefineFrame 0x00, player1_stop_up




zombie_stop_down:
    DefineFrame 0x0C, #_spr_zombie_00
    DefineFrame 0x0C, #_spr_zombie_04
    DefineFrame 0x00, zombie_stop_down

zombie_stop_right:
    DefineFrame 0x0C, #_spr_zombie_03
    DefineFrame 0x0C, #_spr_zombie_07
    DefineFrame 0x00, zombie_stop_right
    
zombie_stop_left:
    DefineFrame 0x0C, #_spr_zombie_02
    DefineFrame 0x0C, #_spr_zombie_06
    DefineFrame 0x00, zombie_stop_left

zombie_stop_up:
    DefineFrame 0x0C, #_spr_zombie_01
    DefineFrame 0x0C, #_spr_zombie_05
    DefineFrame 0x00, zombie_stop_up