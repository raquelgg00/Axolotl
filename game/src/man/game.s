.include "game.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/ia.h.s"

.globl _spr_player
.globl _spr_enemy


game_prepare_templates:

    ; Cambio operadores lo hago con | en vex de 
    ;; ESTO NO DEBERIA YA HACER FALTA
    ;ld a, #e_type_render
    ;or #e_type_movable
    ;or #e_type_input
    ;ld ix, #player_tmp
    ;ld e_tipo(ix), a

    ;; Preparamos los componentes para el template del player
    ld ix, #player_tmp
    ld a, #(e_cmp_render | e_cmp_movable | e_cmp_input)
    ld e_cmps(ix), a

    ;; Preparamos los componentes para el template del enemigo
    ld ix, #enemy_tmp
    ld a, #(e_cmp_render | e_cmp_ia | e_cmp_movable)
    ld e_cmps(ix), a

ret

;; Ojo   ->  las posiciones iniciales de Y deben ser multiplos de 4
;; OJO 2 ->  En cmps se mete 0, pero en la funcion game_prepare_templates lo editamos para meterles distintos componentes
player_tmp:
    ;;                   Tipo       cmps    x      y     vx     vy    width  height  sprite            ia
    DefineEntity p1, e_type_player  #0x00 #0x27, #0x28, #0x00, #0x00, #0x08, #0x14, #_spr_player,  #0x0000

enemy_tmp:
    ;;                   Tipo       cmps    x      y     vx     vy    width  height  sprite            ia
    DefineEntity e1, e_type_enemy   #0x00 #0x39, #0x20, #0xFF, #0x00, #0x08, #0x14, #_spr_enemy, #ia_mover_drcha_izq
    


game_init:
    
    call render_init

    ;; Preparar el template
    call game_prepare_templates

    ;; OPTIMIZAR CON EL GAME_CREATE_TEMPLATE
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


        call entity_update ;; cambiar por entity_update

        ;;MAN ENTITY UPDATEE
        call cpct_waitVSYNC_asm ;; O EL WAIT

    jr    loop

ret 

setBorder:
    ; PINTAMOS BORDE
    ld l, #16    ;; color del borde en la paleta
    call cpct_setPALColour_asm
ret


;; man_game_create_template_entity (rutina para pasar la template y que cree la entidad)