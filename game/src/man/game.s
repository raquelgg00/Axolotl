.include "game.h.s"
.include "entity_templates.h.s"
.include "entity.h.s"
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

        ;; Falta poner Animation
        
        call ia_update

        call physics_update
        call sys_collision_update
 
        cpctm_setBorder_asm HW_GREEN   ; PINTAMOS BORDE DE GREEN
        
        call render_update

        cpctm_setBorder_asm HW_BLUE    ; PINTAMOS BORDE DE BLANCO

        call entity_update ;; borramos entidades

        cpctm_setBorder_asm HW_WHITE     ; PINTAMOS BORDE DE BLANCO

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