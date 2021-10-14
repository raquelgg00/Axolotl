.include "collision.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "man/entity_templates.h.s"


registro_hl:  .dw 0x000
registro_aux: .dw 0x000

posiciones_spawn_enemigos: 
    .db 0x04, 0x04
    .db 0x4A, 0x04

;;  Para hacer las colisiones tenemos en
;;  IX -> Entidad1 
;;  IY -> Entidad2

;; Colision Enemigo choca contra el Player
enemy_player:

    push ix
    push iy

    ;; Cambio de variables entre IX e IY (para destruir al enemigo y no al player)
    ld (registro_hl), ix    ;registroHL = enemigo
    ld (registro_aux), iy
    ld ix, (registro_aux)
    ld iy, (registro_hl)
    
    call entity_set4destruction ;; necesita en IX la entidad a destruir

    

    call cpct_getRandom_mxor_u8_asm ;; Destroys AF, BC, DE, HL
    ld a, l
    and #0x01   ; Me devuelve una de estas opciones --> 00 01 10 11 (0,1,2 o 3 en A)

    ld hl, #posiciones_spawn_enemigos

    comprueba_posicion:
    or a
    cp #0
    jr z, posicion_conseguida
        ;; Tenemos que actualizar HL
        inc hl
        inc hl
        dec a
        jr comprueba_posicion
    posicion_conseguida:

    ;; Cargamos la posicion en A,B 
    ld (registro_hl), hl
    ld ix, (registro_hl)
    ld a, 0(ix)
    ld b, 1(ix)

    ld de, #zombie
    call entity_set4creation ;; necesita en DE el template de entidad a crear, en A la X y en B la Y
    
    pop iy
    pop ix
ret

;; Colision Bala choca contra el Player
;bala_player:

;ret


;; Colision Player arcoiris
player_arcoiris:
    ld de, #0xC000
    ld a, #0x00
    ld c, e_w(iy)
    ld b, e_h(iy)
    call cpct_drawSolidBox_asm
ret


;; Tabla de colisiones
colisiones:
    .db e_type_zombie, e_type_player 
        .dw enemy_player

    .db e_type_player, e_type_arcoiris
        .dw player_arcoiris

    .dw 0

;; ======================================
;; COLISION ENTRE DOS ENTIDADES
;; Input: IX => Entidad Colisionable n1
;;        IY => Entidad Colisionable n2
;; ======================================
sys_collision_update_one_entity:
    
    ;; if (obs_x + obs_w <= player_x) --> no collision
    ;; if (obs_x + obs_w - player_x <= 0
    ld  a, e_x(iy)      ;; a = obs_X
    add e_w(iy)         ;; a = obs_X + obs_W
    sub e_x(ix)         ;; a = obs_X + obs_W - player_x
    jp m, no_collision  ;; salto si es menor que cero
    jr z, no_collision  ;; salto si es = 0 ( no modifica flags )


    ;; if (obsY + obsH <= PlayerY) --> no collision
    ;; if (obsY + obsH - PlayerY <= 0) --> no collision
    ld a, e_y(iy)
    add e_h(iy)
    sub e_y(ix)
    jp m, no_collision  ;; salto si es menor que cero
    jr z, no_collision  ;; salto si es = 0 ( no modifica flags )


    ; if (playerX + playerW <= obs_x) --> no collision
    ; playerX + playerW - obsX <= 0
    ld a, e_x(ix)           ; a = playerX
    add a, e_w(ix)          ; a = playerX +  playeW
    sub e_x(iy)
    jp m, no_collision
    jr z, no_collision


    ; if (playerY + playerH <= obs_y) --> no collision
    ; playerY + playerH - obs_y <= 0
    ld a, e_y(ix)
    add a, e_h(ix)
    sub e_y(iy)
    jp m, no_collision
    jr z, no_collision


    ;; Si IX == IY no hago nada
    ld (registro_aux), iy
    ld (registro_hl), ix
    ld a, (#registro_aux-#registro_hl)
    cp #0
    ret z



    ;; Collision
    ld hl, #colisiones-2

    recorrer_tabla:

        ;; HL += 2 (direccion de memoria)
        ld bc, #2
        add hl, bc

        ; registro_hl => HL (direccion de memoria de TablaColisiones[i])
        ld (registro_hl), hl

        ; DE => (el valor de ColisionTabla[i])
        push ix
        ld ix, (registro_hl)
        ld d, 0(ix)
        ld e, 1(ix)
        pop ix 

    
        ;; Comprobamos si hemos llegado al final de la tabla de colisiones (con el valor)
        ld a, d     ; A = L
        or e        ; A = L | H 
        ret z       ; if (key=NULL) ret
        
        ; Si todavia queda por mirar alguna fila,
        ld a, e_tipo(ix)    ;; / if( e_tipo(ix) == D )
        cp e                ;; \
        jr nz, recorrer_tabla

        ;; e_tipo(ix) = D --> Ahora comprobamos si ¿e_tipo(iy) == E?
        ld a, e_tipo(iy)    ;; / if( e_tipo(iy) == E )
        cp d                ;; \
        jr nz, recorrer_tabla

        ;; Mis 2 entidades de IX e IY coinciden con la fila de la tabla de colisiones
        ;; Ahora ejecutamos la funcion asociada
        ;; El puntero HL debe apuntar a la direccion de memoria siguiente (+= 2)
        inc hl
        inc hl

        ;; HL => PtrFuncion, pero queremos tener en HL SOLO la funcion (no el puntero). Entonces...
        push ix
        ld (registro_hl), hl
        ld ix, (registro_hl)    ; IX => HL
        ld l, 0(ix)             ; / HL => Funcion
        ld h, 1(ix)             ; \
        pop ix                  ; IX => Entidad1 (como antes)

        ld de, #funcion_colision_ya_ejecutada   ;; /  Meto en la pila la dirección a la que quiero que vuelva despues de que
        push de  

        jp (hl)     ;; Saltamps a la funcion
     
    ret

    no_collision:
        ld de, #0xC000
        ld a, #0x00
        ld c, #4
        ld b, #16
        call cpct_drawSolidBox_asm
  

    funcion_colision_ya_ejecutada:
ret


sys_collision_update:
    ld hl, #sys_collision_update_one_entity
    ld b, #e_cmp_collider
    call entity_doForAll_pairs_matching
ret 

