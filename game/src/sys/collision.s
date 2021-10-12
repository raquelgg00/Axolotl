.include "collision.h.s"
.include "man/entity.h.s"

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
        ld de, #0xC000
        ld a, #0xF0 
        ld c, #4
        ld b, #16
        call cpct_drawSolidBox_asm
    ret

    no_collision:
        ld de, #0xC000
        ld a, #0x00
        ld c, #4
        ld b, #16
        call cpct_drawSolidBox_asm
  
ret


sys_collision_update:
    ld hl, #sys_collision_update_one_entity
    ld b, #e_cmp_collider
    call entity_doForAll_pairs_matching
ret 

