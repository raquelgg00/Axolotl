.include "game.h.s"
.include "entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/ia.h.s"

.globl _spr_player
.globl _spr_enemy


player_tmp_cmps = e_cmp_render | e_cmp_movable | e_cmp_input
enemy_tmp_cmps  = e_cmp_render | e_cmp_ia | e_cmp_movable

;; Ojo   ->  las posiciones iniciales de Y deben ser multiplos de 4
player_tmp:
    ;;                   Tipo       cmps                x      y     vx     vy  width  height  sprite            ia
    DefineEntity p1, e_type_player  player_tmp_cmps #0x27, #0x28, #0x00, #0x00, #0x08, #0x14, #_spr_player,  #0x0000

enemy_tmp:
    ;;                   Tipo       cmps              x      y     vx     vy    width  height  sprite            ia
    DefineEntity e1, e_type_enemy   enemy_tmp_cmps #0x39, #0x20, #0xFF, #0x00, #0x08, #0x14, #_spr_enemy, #ia_mover_drcha_izq
    


game_init:
    
    call render_init


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