.include "collision.h.s"
.include "man/entity.h.s"


registro_hl: .dw 0x000

;;  Para hacer las colisiones tenemos en
;;  IX -> Entidad1 
;;  IY -> Entidad2

;; Colision Enemigo choca contra el Player
enemy_player:
    ld de, #0xC000
    ld a, #0xF0 
    ld c, #4
    ld b, #16
    call cpct_drawSolidBox_asm
ret

;; Colision Bala choca contra el Player
;bala_player:

;ret



;; Tabla de colisiones
colisiones:
    .db e_type_enemy, e_type_player 
        .dw enemy_player

    ;.db e_type_bala, e_type_player 
    ;    .dw bala_player

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
    sub (hl)            ;; a = a - (hl) 
    jr z, no_collision  ;; salto si es = 0 ( no modifica flags )
    jp m, no_collision  ;; salto si es menor que cero


    ;; if (obsY + obsH <= PlayerY) --> no collision
    ;; if (obsY + obsH - PlayerY <= 0) --> no collision
    ld a, e_y(iy)
    add e_h(iy)
    sub e_y(ix)
    jr z, no_collision  ;; salto si es = 0 ( no modifica flags )
    jp m, no_collision  ;; salto si es menor que cero


    ; if (playerX + playerW <= obs_x) --> no collision
    ; playerX + playerW - obsX <= 0
    ld a, e_x(ix)           ; a = playerX
    add a, e_w(ix)          ; a = playerX +  playeW
    sub e_x(iy)
    jr z, no_collision
    jp m, no_collision


    ; if (playerY + playerH <= obs_y) --> no collision
    ; playerY + playerH - obs_y <= 0
    ld a, e_y(ix)
    add a, e_h(ix)
    sub e_y(iy)
    jr z, no_collision
    jp m, no_collision


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

