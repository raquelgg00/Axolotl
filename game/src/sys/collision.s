.include "collision.h.s"
.include "man/entity.h.s"

;; ======================================
;; COLISION ENTRE DOS ENTIDADES
;; Input: IX => Entidad Colisionable n1
;;        IY => Entidad Colisionable n2
;; ======================================
sys_collision_update_one_entity:
    

    ld hl, #0xC000
    ld (hl), #0xF0
ret


sys_collision_update:
    ld hl, #sys_collision_update_one_entity
    ld b, #e_cmp_collider
    call entity_doForAll_pairs_matching
ret 