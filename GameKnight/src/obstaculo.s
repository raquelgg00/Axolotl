.include "obstaculo.h.s"
.include "cpctelera.h.s"
;.globl cpct_drawSolidBox_asm
;.globl cpct_drawSprite_asm
;.globl cpct_getScreenPtr_asm
;.globl cpct_scanKeyboard_asm
;.globl cpct_isKeyPressed_asm
;.globl cpct_waitVSYNC_asm
.area _DATA

    _string: .asciz "DEATH"


.area _CODE

obsX:    .db #80-4
obsY:    .db #82
obsW:    .db #4   ; 1 byte 
obsH:    .db #4   ; 4 bytes



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
    ld bc, #0x0404

    
    call cpct_drawSolidBox_asm

ret

updateObstacle::

    ld a, (obsX)
    dec a
    jr nz, notResetPosition

        ; si la bala ha llegado a X = 0, restart
        ld a, #80-4

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

    dec hl
    dec hl


    ; if (playerY + playerH <= obs_y) --> no collision
    ; playerY + playerH - obs_y <= 0
    inc hl                  ; hl = PlayerY
    ld  a, (hl)             ; a =  playerY
    inc hl
    inc hl                  ; hl = playerH
    add (hl)                ; a = playerY +  playerH
    ld  c, a                ; c = playerY +  playerH
    ld  a, (obsY)           ; a = obsY
    ld  b, a                ; b = obsY
    ld  a, c                ; a = playerY + playerH
    sub b                   ; a = (playerY+playerH) - obs_y
    jr z, no_collision
    jp m, no_collision

    ;; Collision
    ld a, #0xFF
        string: .asciz "DEATH"
        ld d, #0
        ld e, #3
        call cpct_setDrawCharM1_asm

        ld de, #0xC000
        ld b, #24
        ld c, #16
        call cpct_getScreenPtr_asm

        ld iy, #string
        call cpct_drawStringM1_asm
    ret 

    ;; No Collision
    no_collision:
        string2: .asciz "....."
        ld d, #0
        ld e, #0
        call cpct_setDrawCharM1_asm

        ld de, #0xC000
        ld b, #24
        ld c, #16
        call cpct_getScreenPtr_asm

        ld iy, #string2
        call cpct_drawStringM1_asm
     
    ret