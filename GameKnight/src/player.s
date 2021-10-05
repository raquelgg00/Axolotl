.area _DATA
.area _CODE


.macro defineEntity name, x, y
    name'Data:
        name'X:     .db x   ;;
        name'Y:     .db y   ;;
        name'W:     .db #3   ; 1 byte 
        name'H:     .db 24   ; 4 bytes
        name'Jump:  .db #-1 ; -1 when not jumping
.endm


;playerData:
    
    ;playerSprite: .db #0x1000

.equ Ent_x, 0   ;; constant Ent_x = 0
.equ Ent_y, 1   ;; constant Ent_y = 1
.equ Ent_w, 2   ;; constant Ent_w = 2
.equ Ent_h, 3
.equ Ent_jump, 4
;.equ Ent_sprite_l, 5
;.equ Ent_sprite_h, 6

defineEntity player, 60, 64
defineEntity player2, 60, 120

;playerData:
;    playerX:     .db #60
;    playerY:     .db #80
;    playerW:     .db #2   ; 1 byte 
;    playerH:     .db 8   ; 4 bytes
;    playerJump:  .db #-1 ; -1 when not jumping
    ;playerSprite: .db #0x1000


;playerData2:
;    p2X:     .db #60
;    p2Y:     .db #120
;    p2W:     .db #2   ; 1 byte 
;    p2H:     .db 8   ; 4 bytes
;    p2Jump:  .db #-1 ; -1 when not jumping
    ;playerSprite: .db #0x1000





;; Jump Table
jumptable:
    .db #-6, #-4, #-2, #-2
    .db #-2, #00, #00, #00
    .db #02, #04, #04, #06
    .db #0x80



.include "keyboard/keyboard.h.s"
.include "cpctelera.h.s"


; ================================================
;     Gets a pointer to player data in (hl)
;   RETURNS: 
;           HL : pointer to Player data
; ================================================
getPlayerPtr::
    ld hl, #playerX
ret 


; ================================================
;     Controls Jump movements
;   Destroys: 
; ================================================
jumpControl:
    ld a, (playerJump)
    cp #-1                  ;; ¿ A == -1 ?
    ret z                   ;; if A == -1, ret

    ;; Get jump value
    ld hl, #jumptable      ;;OJO
    ld c, a             ; metemos en c=a
    ld b, #0            ; b = 0
    add hl, bc          ; hl += BC

    ; Check End of Jumping
    ld a, (hl)
    cp #0x80
    jr z, end_of_jump

    ; Do jump
    ld  b, a
    ld  a, (playerY)
    add b
    ld (playerY), a

    ; Increment player_Jump Index
    ld a, (playerJump)
    inc a
    ld (playerJump), a   ;; playerJump++

ret

    end_of_jump:
        ld a, #-1
        ld (playerJump), a ; playerJump = -1
ret
        



; ================================================
;     Salto
; ================================================
startJump:
    ld a, (playerJump)

    cp #-1
    ret nz         ; si jump != -1 (estaba saltando antes), no hago nada

    ;;  Si no saltaba, activo salto
    ld a, #0       
    ld (playerJump), a

ret



; ================================================
;     Mueve al personaje a la drcha
; ================================================
moveRight:

    ld a, (playerX)

    cp #80-2 ; check against right limit (screenSize - playerSize)
    jr z, dont_go_right
        inc a  ; Move right

    dont_go_right:

    ld (playerX), a

    ; Otra forma de incrementarlo
    ;ld hl, playerX
    ;inc (hl)
ret



; ================================================
;     Mueve al personaje a la izq
; ================================================
moveLeft:
    ld a, (playerX)
    cp #0
    jr z, dont_go_left

        ; Move left
        dec a

    dont_go_left:
    ld (playerX), a
ret


; Se prepara para borrar al personaje
erasePlayer::
    ld a, #0x00 
    ld ix, #playerData
    call drawPlayer2

    ld a, #0x00 
    ld ix, #player2Data
    call drawPlayer2
ret


; Se prepara para dibujar al personaje
drawPlayer::
    ld a, #0xFF 
    ld ix, #playerData
    call drawPlayer2

    ld a, #0xFF 
    ld ix, #player2Data
    call drawPlayer2
ret

; ================================================
; Usa la playerX y playerY para dibujar al player
; INPUT
;       IX --> Pointer to entity data
;       A  --> Colour Pattern
; ================================================
drawPlayer2::

    push af ;; Save A in the stuck


    ; Calculate Screen Position
    ld de, #0xC000
    ld c, Ent_x(ix)      ; C = EntityX
    ld b, Ent_y(ix)      ; B = EntityY
    call cpct_getScreenPtr_asm ; Me devuelve en HL la posicion de memoria a dibujar

    ex de, hl           ; Necesita en DE la posicion de memoria a dibujar
    pop af
    ld b, Ent_h(ix)        ; B = EntityHeight
    ld c, Ent_w(ix)        ; C = EntityWidth

    ;; Draw Sprite
    ;ld h, Ent_h(ix)
    ;ld l, Ent_l(ix)
    ;call cpct_drawSprite_asm

    call cpct_drawSolidBox_asm

ret


; ================================================
; Usa la playerX y playerY para dibujar al player
; ================================================
checkUserInput::

    call cpct_scanKeyboard_asm

    ;; Check if D is pressed
    ld hl, #Key_D
    call cpct_isKeyPressed_asm
    cp #0
    jr z, d_not_pressed

        ; D is pressed
        call moveRight

    d_not_pressed::

    ;; Check if A is pressed
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    cp #0
    jr z, a_not_pressed

        ; A is pressed
        call moveLeft

    a_not_pressed::

    ;; Check if W is pressed
    ld hl, #Key_W
    call cpct_isKeyPressed_asm
    cp #0
    jr z, w_not_pressed

        ; W is pressed
        call startJump

    w_not_pressed::
ret


