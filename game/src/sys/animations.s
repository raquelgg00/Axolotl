.include "sys/animations.h.s"
.include "man/entity.h.s"
.include "man/animations.h.s"

registro_iy : .dw 0x0000


;; ===============================
;; CAMBIO PUNTERO A SPRITE Y ANIMACION
;; Input: IX --> Pointers to the entity
;; Output:
;; Destroy: HL, AF, IY
;; ===============================
animations_move_right:
    ;; cambio animacion
    ld hl, #mago_stop_right
    ld e_animL(ix), l
    ld e_animH(ix), h

    push iy
    ld (registro_iy), hl ;; cargo el frame en iy
    ld iy, (registro_iy)
        
    ld a, e_time(iy)
    ld e_animCounter(ix), a ;; cambio counter

    ld l, e_frameL(iy)
    ld h, e_frameH(iy)
    ld e_spriteL(ix), l ;; cambio sprite actual
    ld e_spriteH(ix), h
    pop iy

ret

animations_move_left:
    ;; cambio animacion
    ld hl, #mago_stop_left
    ld e_animL(ix), l
    ld e_animH(ix), h

    push iy
    ld (registro_iy), hl ;; cargo el frame en iy
    ld iy, (registro_iy)
        
    ld a, e_time(iy)
    ld e_animCounter(ix), a ;; cambio counter

    ld l, e_frameL(iy)
    ld h, e_frameH(iy)
    ld e_spriteL(ix), l ;; cambio sprite actual
    ld e_spriteH(ix), h
    pop iy
ret

animations_move_up:
    ;; cambio animacion
    ld hl, #mago_stop_up
    ld e_animL(ix), l
    ld e_animH(ix), h

    push iy
    ld (registro_iy), hl ;; cargo el frame en iy
    ld iy, (registro_iy)
        
    ld a, e_time(iy)
    ld e_animCounter(ix), a ;; cambio counter

    ld l, e_frameL(iy)
    ld h, e_frameH(iy)
    ld e_spriteL(ix), l ;; cambio sprite actual
    ld e_spriteH(ix), h
    pop iy
ret

animations_move_down:
    ;; cambio animacion
    ld hl, #mago_stop_down
    ld e_animL(ix), l
    ld e_animH(ix), h

    push iy
    ld (registro_iy), hl ;; cargo el frame en iy
    ld iy, (registro_iy)
        
    ld a, e_time(iy)
    ld e_animCounter(ix), a ;; cambio counter

    ld l, e_frameL(iy)
    ld h, e_frameH(iy)
    ld e_spriteL(ix), l ;; cambio sprite actual
    ld e_spriteH(ix), h
    pop iy
ret

;; ===============================
;; COMPRUEBO CONDICIONES PARA ANIMAR UNA ENTIDAD
;; Input: IX --> Pointers to the entity
;; Output:
;; Destroy: AF
;; ===============================
animations_update_one:
    ld a, e_vx(ix)
    cp #0
    jp nz, sinAnimacionStop
        ld a, e_vy(ix)
        cp #0
        jp nz, sinAnimacionStop
            call animation_paso_frame

    sinAnimacionStop:

ret

;; ===============================
;; PASA AL SIGUIENTE FRAME DE UNA ANIMACION
;; Input: IX --> Pointers to the entity
;; Output:
;; Destroy: AF, BC, HL, IY
;; ===============================
animation_paso_frame:
    ld a, e_animCounter(ix)
    dec a
    cp #0
    jp nz, noCambio

        ld l, e_animL(ix) ;; cargo direccion del frame actual en hl
        ld h, e_animH(ix)
        ld bc, #k_size_animation
        add hl, bc  ;; me muevo al siguiente frame

        ld (registro_iy), hl ;; cargo el frame en iy
        ld iy, (registro_iy)
        
        ld a, e_time(iy)
        cp #0
        jp nz, noUltimo 
            ;; es el frame de reinicio
            ld l, e_frameL(iy)
            ld h, e_frameH(iy)
            ld (registro_iy), hl ;; cargo el frame inicial en iy
            ld iy, (registro_iy)
            
        noUltimo:
            ;; actualizo valores de la entidad
            ld e_animL(ix), l ;; cambio puntero del frame actual
            ld e_animH(ix), h

            ld l, e_frameL(iy)
            ld h, e_frameH(iy)
            ld e_spriteL(ix), l ;; cambio sprite actual
            ld e_spriteH(ix), h

            ld a, e_time(iy)

    noCambio:
        ld e_animCounter(ix), a ;; modifico contador de animacion
ret


;; ===============================
;; EJECUTA PARA TODAS LAS ENTIDADES
;; Input:
;; Output:
;; ===============================
animations_update:
    ld hl, #animations_update_one
    ld b, #e_cmp_animated
    call entity_doForAll_matching
ret
