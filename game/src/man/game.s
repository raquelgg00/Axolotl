.include "game.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "ia/ia.h.s"

.globl _spr_player
.globl _spr_enemy

e_type_player: .db 0x00
e_type_enemy:  .db 0x00

game_prepare_templates:
    ;; Preparamos los tipos para el player
    ld a, #e_type_render
    or #e_type_movable
    or #e_type_input
    ld ix, #player_tmp
    ld e_status(ix), a

    ;; Preparamos los tipos para el enemy
    ld a, #e_type_render
    or #e_type_ia
    or #e_type_movable
    ld ix, #enemy_tmp
    ld e_status(ix), a


ret

;; Ojo, las posiciones iniciales de Y deben ser multiplos de 4
player_tmp:
    DefineEntity p1, #0x27, #0x28, #0x00, #0x00, #0x08, #0x14, #_spr_player, e_type_player, #0x0000

enemy_tmp:
    DefineEntity e1, #0x39, #0x20, #0xFF, #0x00, #0x08, #0x14, #_spr_enemy, e_type_enemy, #ia_mover_drcha_izq
    


game_init:
    
    call render_init

    ;; Preparar el template
    call game_prepare_templates

    ;; Crear al Jugador
    call entity_create
    ex de, hl               ;; de = EntidadCreada
    ld hl, #p1              ;; hl = player_tmp
    call entity_copy

    ;;Crear el primer enemigo
    call entity_create
    ex de, hl               ;; de = EntidadCreada
    ld hl, #e1              ;; hl = player_tmp
    call entity_copy
ret 


game_play:

    ld ix, #entity_vector   ;; IX => 1a entidad
    ;; call render_draw        ;; Dibujamos la entidad

    loop:
        call ia_update
        call physics_update
        call render_update

        call entity_destroy

        ;;MAN ENTITY UPDATEE
        call cpct_waitVSYNC_asm ;; O EL WAIT

    jr    loop

ret 

;; wait, man_game_create_template_entity