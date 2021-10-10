.include "game.h.s"
.include "entity_templates.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/ia.h.s"

    
;; ===============================
;; CREA UNA ENTIDAD CON UN TEMPLATE
;; Input: DE --> template que queremos
;; ===============================
game_create_template:
    call entity_create
    ;; de tiene la template y hl la entidad creada, hay que intercambiarlas
    ex de, hl
    call entity_copy
ret

game_init:
    
    call render_init

    ;; Crear al Jugador
    ld de, #player1
    call game_create_template
    ;call entity_create
    ;ex de, hl               ;; de = EntidadCreada
    ;ld hl, #p1              ;; hl = player_tmp
    ;call entity_copy

    ;;Crear el primer enemigo
    ld de, #enemy1
    call game_create_template
    ;call entity_create
    ;ex de, hl               ;; de = EntidadCreada
    ;ld hl, #e1              ;; hl = player_tmp
    ;call entity_copy
ret 


game_play:

    ld ix, #entity_vector   ;; IX => 1a entidad
    ;; call render_draw        ;; Dibujamos la entidad

    loop:

        ;; Falta poner Animation


        call ia_update

        ; PINTAMOS BORDE DE GREEN
        ld h, #22     ;; color del fondo
        call setBorder

        call physics_update


        ; PINTAMOS BORDE DE ROJO
        ld h, #28    ;; color del borde en la paleta
        call setBorder

        
        call render_update

        ; PINTAMOS BORDE DE BLANCO
        ld h, #0  ;; color del fondo
        call setBorder


        call entity_update 

        ;;call cpct_waitVSYNC_asm
        ld e, #10
        call main_espera

    jr    loop

ret 

setBorder:
    ; PINTAMOS BORDE
    ld l, #16    ;; color del borde en la paleta
    call cpct_setPALColour_asm
ret

main_espera:
      halt
      halt
      call cpct_waitVSYNC_asm
      dec e
    jp nz, main_espera
ret


;; man_game_create_template_entity (rutina para pasar la template y que cree la entidad)