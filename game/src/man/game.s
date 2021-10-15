.include "game.h.s"
.include "entity_templates.h.s"
.include "entity.h.s"
.include "sys/animations.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/ia.h.s"
.include "sys/collision.h.s"
.include "cpctelera.h.s"

player_shot:     .db 0x00
registro_aux_ix: .db 0x0000

;llamada_ia:  .db 0x02

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

    ;;Crear el primer enemigo
    ld de, #zombie
    call game_create_template

    ;;Crear el arcoiris
    ld de, #arcoiris
    call game_create_template
ret 

;; ===================
;; METODO PARA DISPARAR
;; Comprueba que no se haya generado un disparo y crea una nueva entidad disparo
;; ===================
game_player_shot:

    ld a, (player_shot)
    cp #0
    jp nz, disparo_lanzado
        ;; Si no se ha disparado, es decir, player_shot = 0
        add #1
        ld (player_shot), a
        ld de, #shot1
        ld a, #20
        ld b, #20
        call entity_set4creation
    disparo_lanzado:
ret 


game_play:

    ld ix, #entity_vector   ;; IX => 1a entidad
    ;; call render_draw        ;; Dibujamos la entidad

    loop:
        
        cpctm_setBorder_asm HW_BRIGHT_RED ; PINTAMOS BORDE DE ROJO


        ; POR SI HAY QUE LLAMAR A LA IA MENOS VECES (pero tiembla un poco los zombies)
        ;ld a, (llamada_ia)
        ;cp #0
        ;jr nz, no_IA
           call ia_update
        ;    ld a, #0x02
        ;no_IA:
        ;dec a
        ;ld (llamada_ia), a

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

        cpctm_setBorder_asm HW_BLACK     ; PINTAMOS BORDE DE GRIS

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