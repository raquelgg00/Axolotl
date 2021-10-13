.globl player1_stop_down
.globl player1_stop_up
.globl player1_stop_left
.globl player1_stop_right
.globl zombie_stop_down
.globl zombie_stop_up
.globl zombie_stop_left
.globl zombie_stop_right
.globl k_size_animation

k_size_animation = 3

e_time    = 0
e_frameL  = 1
e_frameH  = 2

.macro DefineFrame _tiempo, _sprite
    .db _tiempo
    .dw _sprite      
              
.endm