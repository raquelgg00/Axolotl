.include "keyboard/keyboard.h.s"
.include "physics.h.s"
.include "man/entity.h.s"

move_right:
    ld e_vx(ix), #1
ret 

move_left:
    ld e_vx(ix), #-1
ret 

move_up:
    ld e_vy(ix), #-4
ret 

move_down:
    ld e_vy(ix), #4    
ret

;; Tabla para las acciones del teclado
key_actions:
    .dw Key_D, move_right
    .dw Key_A, move_left
    .dw Key_W, move_up
    .dw Key_S, move_down
    .dw 0


;; ===============================
;; INPUT TECLADO
;; Input:
;; Output:
;; ===============================
physics_keyboard:
    ld e_vx(ix), #0
    ld e_vy(ix), #0

    ;; Comprueba el teclado
    call cpct_scanKeyboard_asm

    ;; Bucle para recorrer las acciones del teclado
    ld iy, #key_actions-4 ;; la primera vez que entro no hay que hacer el iy++, asi que al principio resto 4 para que al sumarle luego 4 se quede apuntando a la primera KEY

    loop_keys:

        ;; IY -> NextKey (iy++)
        ld bc, #4
        add iy, bc

        ;; HL = next key
        ld l, 0(iy)
        ld h, 1(iy)

        ;; Comprobamos si Key=NULL (hemos llegado al final de las acciones)
        ld a, l     ; A = L
        or h        ; A = L | H 
        ret z       ; if (key=NULL) ret

        ;; Comprobamos si Key estaba pulsada
        call cpct_isKeyPressed_asm
        jr z, loop_keys

        ;; Se esta pulsando la tecla
        ld hl, #loop_keys   ;; /  Meto en la pila la dirección a la que quiero que vuelva despues de que
        push hl            ;; \  se haga el ret, cuando voy a jp(hl) (porque no ponemos call)

        ;; HL = puntero a funcion de la accion
        ld l, 2(iy)        
        ld h, 3(iy)        
        
        jp (hl)            ;; Salto a la funcion de acción




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
    ld a, e_cmps(ix)
    and #e_cmp_input
    cp #e_cmp_input
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
    ld b, #e_cmp_movable
    call entity_doForAll_matching
ret