.area _DATA
.area _CODE

obsX:    .db #80-1
obsY:    .db #82
obsW:    .db #1   ; 1 byte 
obsH:    .db #4   ; 4 bytes

.include "cpctelera.h.s"

; ================================================
; Usa la X y Y para dibujar al obstaculo
; ================================================
eraseObstacle::
    ld a, #0x00 
    call drawObstacle2
ret

drawObstacle::
    ld a, #0x0F;    pinto amarillo 
    call drawObstacle2
ret

drawObstacle2::

    push af ;; Save A in the stuck

    ; Calculate Screen Position
    ld de, #0xC000
    ld a, (obsX)  
    ld c, a       
    ld a, (obsY)  
    ld b, a   
    ld a, #0x0F 

    ; Me devuelve en HL la posicion de memoria a dibujar
    call cpct_getScreenPtr_asm

    ex de, hl           ; Necesita en DE la posicion de memoria a dibujar
    pop af
    ld bc, #0x0401      ; 4x4 pixeles
    
    call cpct_drawSolidBox_asm

ret

updateObstacle::

    ld a, (obsX)
    dec a
    jr nz, notResetPosition

        ; si la bala ha llegado a X = 0, restart
        ld a, #80-1

    notResetPosition:
        ld (obsX), a
    ret



; ================================================
; Checks collision between obstacle and another entity
;; Input
;;      HL: Points to the other entity
;; Return
;;      XXXXXXX
; ================================================
checkCollision::

    ;; if (obs_x + obs_w <= player_x) --> no collision
    ;; if (obs_x + obs_w - player_x <= 0
    ld  a, (obsX)       ;; a = obsX
    ld  c, a            ;; c = a
    ld  a, (obsW)       ;; a = obs_WIDHT
    add c               ;; a = a + c --> es lo mismo que add a, c
    sub (hl)            ;; a = a - (hl) 

    jr z, no_collision  ;; salto si es = 0 ( no modifica flags )
    jp m, no_collision  ;; salto si es menor que cero


    
    ; if (playerX + playerW <= obs_x) --> no collision
    ; playerX + playerW - obsX <= 0
    ld  a, (hl)             ; a =  playerX
    inc hl
    inc hl                  ; hl = playerW
    add (hl)                ; a = playerX +  playerW
    ld  c, a                ; c = playerX +  playerW
    ld  a, (obsX)           ; a = obsX
    ld  b, a                ; b = obsX
    ld  a, c                ; a = playerX + playerM
    sub b                   ; a = (playerX+playerM) - obsX
    jr z, no_collision
    jp m, no_collision

    ;; Collision
    ld a, #0xFF
    ret 

    ;; No Collision
    no_collision:
        ld a, #0x00
    ret