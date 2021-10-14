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
    ld a, e_x(ix) ;; A = Enemigo_X
    sub a, e_x(iy) ;; a = enemy_x - player_x
    
    jr c, enemigo_derecha_player ;; Si la resta es negativa, -->  player_X  > enemigo_X
    jr z, misma_posicion_x
        ld e_vx(ix), #-1         ;; Por tanto, hay que mover el enemigo hacia la izq
        jr check_y               ;; Pasamos a comprobar la y

    enemigo_derecha_player:      ;; Si es positiva, la x del enemigo esta mas a la derecha que la del player
    ld e_vx(ix), #1              ;; Por tanto, hay que mover el enemigo hacia la drcha
    jr check_y

    misma_posicion_x:
    ld e_vx(ix), #0
    
    ;; COMPROBAMOS LA Y
    check_y:
    ld a, e_y(ix)  ;; A = Enemy_Y
    sub a, e_y(iy) ;; A = Enemy_Y - Player_Y
    
    jr c, enemigo_arriba_player ;; Si hay carry (EnemyY - PlayerY < 0 --> Hay carry)
    jr z, misma_posicion_y
        ; no hay carry y no es cero --> EnemyY > Player_Y --> Enemigo Abajo
        ld e_vy(ix), #-4        ;; ENEMIGO se mueve hacia ARRIBA
        ret                 

    enemigo_arriba_player:      ;; Si es positiva, la x del enemigo esta mas a la derecha que la del player
    ld e_vy(ix), #4             ;; Por tanto, hay que mover el enemigo hacia la izquierda restando posiciones
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