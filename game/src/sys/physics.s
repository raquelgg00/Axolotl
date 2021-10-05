.include "keyboard/keyboard.h.s"
.include "physics.h.s"
.include "man/entity.h.s"


;; ===============================
;; INPUT TECLADO
;; Input:
;; Output:
;; ===============================
physics_keyboard:
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    call cpct_scanKeyboard_asm

    ;; Check if D is pressed
    ld hl, #Key_D
    call cpct_isKeyPressed_asm
    cp #0
    jr z, d_not_pressed

        ; D is pressed
        ld e_vx(ix), #1

    d_not_pressed::

    ;; Check if A is pressed
    ld hl, #Key_A
    call cpct_isKeyPressed_asm
    cp #0
    jr z, a_not_pressed

        ; A is pressed
        ld e_vx(ix), #-1

    a_not_pressed::

    ;; Check if W is pressed
    ld hl, #Key_W
    call cpct_isKeyPressed_asm
    cp #0
    jr z, w_not_pressed

        ; W is pressed
        ld e_vy(ix), #-4

    w_not_pressed::

    ;; Check if S is pressed
    ld hl, #Key_S
    call cpct_isKeyPressed_asm
    cp #0
    jr z, s_not_pressed

        ; S is pressed
        ld e_vy(ix), #4

    s_not_pressed::
ret



;PARA OPTIMIZAR
;comprueba_borde:

    ;ld a, e_x(ix)       ; A = playerX
    ;cp b
    ;jr nz, actualizaX ; if (x == borde) actulizaX
        ;; Estoy en X = borde
        ;ld a, e_vx(ix)      ;; a = vx
        ;cp #0               
        ;jp m, no_actualizaX ;; if (vx < 0)  no_actualizaX

;    actualizaX:
;        ld a, e_x(ix)
;        add e_vx(ix)
;        ld e_x(ix), a

;    no_actualizaX:
;ret

;; ===============================
;; ACTUALIZAR UNA ENTIDAD
;; Input:
;; Output:
;; ===============================
physics_update_one:
    ;; SI LA ENTIDAD TIENE INPUT COMPROBAR TECLADO 
    ld a, e_status(ix)
    and #e_type_input
    cp #e_type_input
    jr nz, no_input
        call physics_keyboard

    no_input:


    ; HACER PARA OPTIMIZAR --> Comprobamos movimiento en el borde izq
    ;ld b, #0x00
    ;call comprueba_borde

    ;; X - PARTE IZQUIERDA 
    ld a, e_x(ix)
    cp #0
    jr nz, actualizaXizq
        ;; Estoy en X = 0
        ld a, e_vx(ix)      ;; a = vx
        cp #0               
        jp m, no_actualizaX ;; if (vx < 0)  no_actualizaX
       
    ;; X = 0 y VX positiva
    actualizaXizq:



    ;; X - PARTE DERECHA
    ld a, e_x(ix)       ; A = playerX
    cp #0x47
    jr nz, actualizaXdrcha ; if (x == bordeDrcha-anchoSprite) actulizaDrcha
        ;; Estoy en X = bordeDrcha
        ld a, e_vx(ix)      ;; a = vx
        cp #0               
        jp p, no_actualizaX ;; if (vx > 0)  no_actualizaX

        actualizaXdrcha:
    ;;  x = x + vx
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a

    no_actualizaX:

    ;;; ---------------------

    ;; Y - PARTE ARRIBA 
    ld a, e_y(ix)
    cp #0

    jr nz, actualizaYarriba
        ;; Estoy en Y = 0
        ld a, e_vy(ix)      ;; a = vy
        cp #0               
        jp m, no_actualizaY ;; if (vy < 0)  no_actualizaX
       
    ;; X = 0 y VX positiva
    actualizaYarriba:


    ;; Y - PARTE ABAJO
    ld a, e_y(ix)       ; A = playerX
    cp #0xC8-#0x14
    jr nz, actualizaYabajo ; if (x == bordeDrcha-anchoSprite) actulizaDrcha
        ;; Estoy en X = bordeDrcha
        ld a, e_vy(ix)      ;; a = vx
        cp #0               
        jp p, no_actualizaY ;; if (vx > 0)  no_actualizaX

        actualizaYabajo:
    ;;  y = y + vy
    ld a, e_y(ix)
    add e_vy(ix)
    ld e_y(ix), a

    no_actualizaY:

ret

;; ===============================
;; EJECUTA PARA TODAS LAS ENTIDADES
;; Input:
;; Output:
;; ===============================
physics_update:
    ;; COMPROBAR SIGNATURE CON entity_doForAll_matching
    ld hl, #physics_update_one
    ld b, #e_type_movable
    call entity_doForAll_matching
ret