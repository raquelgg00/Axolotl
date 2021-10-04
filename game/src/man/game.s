.include "game.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"

e_type_player: .db 0x00
e_type_enemy: .db 0x00

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

player_tmp:
    DefineEntity p1, #0x27, #0x27, #0x00, #0x00, #0x01, #0x04, #0x0F, e_type_player

enemy_tmp:
    DefineEntity e1, #0x39, #0x12, #0x00, #0x00, #0x01, #0x04, #0xFF, e_type_enemy
    


game_init:
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
        ;;IA UPDATE
        call physics_update
        call render_update

        ;;MAN ENTITY UPDATEE
        call cpct_waitVSYNC_asm ;; O EL WAIT

    jr    loop

ret 

;; wait, man_game_create_template_entity