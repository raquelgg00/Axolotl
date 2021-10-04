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
    ;;actualizo x
    ld a, e_x(ix)
    add e_vx(ix)
    ld e_x(ix), a

    ;;actualizo y
    ld a, e_y(ix)
    add e_vy(ix)
    ld e_y(ix), a


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