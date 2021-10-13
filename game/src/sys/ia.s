.include "ia.h.s"
.include "man/entity.h.s"

;; IA 1
ia_mover_drcha_izq:
    ;; EN IX tenemos la entidad
    ld a, e_x(ix)
    cp #0
    jr nz, no_borde_izq
        ;; Cambia hacia la derecha
        ;;ld e_vx(ix), #1
        ret
    no_borde_izq:

    ;cp #0x47
    cp #0x4F-#0x08 ;; borde drecha - tam_Enemigo

    jr nz, no_borde_drcha
        ;; Cambia hacia la izq
        ;;ld e_vx(ix), #-1
        ret
    no_borde_drcha:


ret 

;; IA 2
ia_mover_arriba_abajo:

ret

;; IA 3: Seguimiento del player
ia_seguimiento_player:
    ld iy, #entity_vector ;; Cargamos los datos del jugador en iy

    ;; COMPROBAMOS LA X
    ld a, e_x(ix) ;; Cargamos en a la x del enemigo
    ld b, e_x(iy) ;; Cargamos en b la x del player
    cp b
    jp z, misma_posicion_x
    jp m, enemigo_derecha_player ;; Si la resta es negativa, quiere decir que la x del player es mayor que la del enemigo
        ld e_vx(ix), #-1         ;; Por tanto, hay que mover el enemigo hacia la derecha aumentando posiciones
        jp check_y               ;; Pasamos a comprobar la y

    enemigo_derecha_player:      ;; Si es positiva, la x del enemigo esta mas a la derecha que la del player
    ld e_vx(ix), #1              ;; Por tanto, hay que mover el enemigo hacia la izquierda restando posiciones
    jp check_y

    misma_posicion_x:
    ld e_vx(ix), #0
    
    ;; COMPROBAMOS LA Y
    check_y:
    ld a, e_y(ix) ;; Cargamos en a la y del enemigo
    ld b, e_y(iy) ;; Cargamos en b la y del player
    cp b          ;; a - b = EnemigoY - PlayerY
    ;sbc a, b
    jp z, misma_posicion_y
    jp m, enemigo_arriba_player ;; Si la resta es negativa, quiere decir que la x del player es mayor que la del enemigo
        ld e_vy(ix), #-2        ;; Por tanto, hay que mover el enemigo hacia la derecha aumentando posiciones
        ret                     ;; Pasamos a comprobar la y

    enemigo_arriba_player:      ;; Si es positiva, la x del enemigo esta mas a la derecha que la del player
    ld e_vy(ix), #2             ;; Por tanto, hay que mover el enemigo hacia la izquierda restando posiciones
    ret

    misma_posicion_y:
    ld e_vy(ix), #0
ret


ia_update_one:
    ld l, e_iaL(ix)
    ld h, e_iaH(ix)

    ;ld hl, e_ia(ix)
    ld (metodo_IA), hl
    metodo_IA = . + 1
    call ia_mover_drcha_izq
ret


ia_update:
    ;; COMPROBAR SIGNATURE CON entity_doForAll_matching
    ld hl, #ia_update_one
    ld b , #e_cmp_ia
    call entity_doForAll_matching
ret