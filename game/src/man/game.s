.include "game.h.s"
.include "entity_templates.h.s"
.include "entity.h.s"
.include "sys/animations.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/ia.h.s"
.include "sys/collision.h.s"
.include "cpctelera.h.s"

    
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
        
        cpctm_setBorder_asm HW_BRIGHT_RED ; PINTAMOS BORDE DE ROJO

        call ia_update

        cpctm_setBorder_asm HW_BRIGHT_YELLOW ; PINTAMOS BORDE DE AMARILLO

        call physics_update

        cpctm_setBorder_asm HW_ORANGE ; PINTAMOS BORDE DE NARANJA

        call sys_collision_update

        cpctm_setBorder_asm HW_PINK  ; PINTAMOS BORDE DE ROSA

        call animations_update
 
        cpctm_setBorder_asm HW_GREEN   ; PINTAMOS BORDE DE VERDE
        
        call render_update

        cpctm_setBorder_asm HW_BLUE    ; PINTAMOS BORDE DE AZUL

        call entity_update ;; borramos entidades

        cpctm_setBorder_asm HW_WHITE     ; PINTAMOS BORDE DE GRIS

        call cpct_waitVSYNC_asm
        ;ld e, #10
        ;call main_espera


    jr    loop

ret 


main_espera:
      halt
      halt
      call cpct_waitVSYNC_asm
      dec e
    jp nz, main_espera
ret


;; man_game_create_template_entity (rutina para pasar la template y que cree la entidad)