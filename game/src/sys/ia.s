.include "ia.h.s"
.include "man/entity.h.s"

;; IA 1
ia_mover_drcha_izq:
    ;; EN IX tenemos la entidad
    ld a, e_x(ix)
    cp #0
    jr nz, no_borde_izq
        ;; Cambia hacia la derecha
        ld e_vx(ix), #1
        ret
    no_borde_izq:

    ;cp #0x47
    cp #0x4F-#0x08 ;; borde drecha - tam_Enemigo

    jr nz, no_borde_drcha
        ;; Cambia hacia la izq
        ld e_vx(ix), #-1
        ret
    no_borde_drcha:


ret 

;; IA 2
ia_mover_arriba_abajo:

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