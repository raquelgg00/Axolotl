.include "entity_templates.h.s"
.include "entity.h.s"
.include "animations.h.s"
.include "sys/ia.h.s"

.globl _spr_player1_00
.globl _spr_zombie_00
.globl _spr_escudero_08


player_tmp_cmps = e_cmp_render | e_cmp_movable | e_cmp_input | e_cmp_animated | e_cmp_collider
zombie_tmp_cmps  = e_cmp_render | e_cmp_ia | e_cmp_movable | e_cmp_collider
shot_tmp_cmps   = e_cmp_render | e_cmp_movable | e_cmp_collider
arcoiris_tmp_cmps = e_cmp_render | e_cmp_collider

player_tmp_collider = e_type_arcoiris         ;; el player colisiona contra (¿de momento nada? a lo mejor luego contra las paredes o no se...)
zombie_tmp_collider = e_type_player ;; el enemigo colisiona contra el player (al reves no)
shot_tmp_collider = e_type_zombie   ;; la bala colisiona con los enemigos
arcoiris_tmp_collider = #0x00

;; Ojo   ->  las posiciones iniciales de Y deben ser multiplos de 4
player_tmp:
    ;;                       Tipo               cmps        x       y     vx     vy   width  height  sprite                 ia                  anim       count        collides           last_dir
    DefineEntity player1, e_type_player  player_tmp_cmps  #0x27, #0x28, #0x00, #0x00, #0x05, #0x14, #_spr_player1_00,  #0x0000,         #player1_stop_down, #0x0C,  player_tmp_collider,      #0x00 

zombie_tmp:
    DefineEntity zombie, e_type_zombie    zombie_tmp_cmps #0x39, #0x20, #0x00, #0x00, #0x05, #0x14, #_spr_zombie_00, #ia_seguimiento_player, #0x0000,       #0x00,  zombie_tmp_collider,      #0x00

shot_tmp:
    DefineEntity shot1, e_type_shot      shot_tmp_cmps    #0x00, #0x00, #0x00, #0x00, #0x03, #0x02, #0x0000,          #0x0000,              #0x0000,        #0x00,  shot_tmp_collider,        #0x00

arcoiris_tmp:
    DefineEntity arcoiris, e_type_shot  arcoiris_tmp_cmps #0x10, #0x10, #0x00, #0x00, #0x05, #0x14, #_spr_escudero_08, #0x0000,              #0x0000,        #0x00,  shot_tmp_collider    ,   #0x00
