.include "entity_templates.h.s"
.include "entity.h.s"
.include "animations.h.s"
.include "sys/ia.h.s"

.globl _spr_mago_0
.globl _spr_enemy


player_tmp_cmps = e_cmp_render | e_cmp_movable | e_cmp_input | e_cmp_animated | e_cmp_collider
enemy_tmp_cmps  = e_cmp_render | e_cmp_ia | e_cmp_movable | e_cmp_collider

player_tmp_collider = 0x00         ;; el player colisiona contra (¿de momento nada? a lo mejor luego contra las paredes o no se...)
enemy_tmp_collider = e_type_player ;; el enemigo colisiona contra el player (al reves no)


;; Ojo   ->  las posiciones iniciales de Y deben ser multiplos de 4
player_tmp:
    ;;                       Tipo               cmps        x       y     vx     vy   width  height  sprite                 ia            anim       count        collides
    DefineEntity player1, e_type_player  player_tmp_cmps  #0x27, #0x28, #0x00, #0x00, #0x08, #0x1D, #_spr_mago_0,  #0x0000,          #mago_stop_down, #0x0C,  player_tmp_collider 
enemy_tmp:
    DefineEntity enemy1, e_type_enemy    enemy_tmp_cmps   #0x39, #0x20, #0x00, #0x00, #0x08, #0x14, #_spr_enemy, #ia_seguimiento_player, #0x0000,    #0x00,  enemy_tmp_collider
