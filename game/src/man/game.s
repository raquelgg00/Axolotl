.include "game.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"



player_tmp:
    DefineEntity p1, #0x27, #0x27, #0x00, #0x00, #0x01, #0x04, #0xFF, e_type_alive


game_init:
    ;; Crear al Jugador
    call entity_create
    ex de, hl               ;; de = EntidadCreada
    ld hl, #p1              ;; hl = player_tmp
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