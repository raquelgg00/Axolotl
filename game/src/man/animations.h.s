.globl magoQuieto
.globl k_size_animation

k_size_animation = 3

e_time    = 0
e_frameL  = 1
e_frameH  = 2

.macro DefineFrame _name, _tiempo, _sprite
    _name:
        .db _tiempo
        .dw _sprite      
              
.endm