.include "game.h.s"
.include "entity.h.s"

player_tmp:
    DefineEntity p1, #0x27, #0x27, #0x00, #0x00, #0x01, #0x04, #0xFF, e_type_alive


game_init:

    ;; Crear al Jugador
    call entity_create
    ex de, hl               ;; de = EntidadCreada
    ld hl, #p1              ;; hl = player_tmp
    call entity_copy
    
ret 