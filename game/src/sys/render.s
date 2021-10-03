.include "render.h.s"
.include "man/entity.h.s"


;; ===============================
;; DIBUJA UNA ENTIDAD
;; Destroy: AF, DE, BC, HL
;; Input: IX --> Pointers to the entity
;; ===============================
render_draw:
   ld    de, #0xC000      ;; Starting adrees of screen
   ld    c, e_x(ix)       ;; C = entity_X
   ld    b, e_y(ix)       ;; B = entity_Y
   call  cpct_getScreenPtr_asm ;; returns the position in hl

   ld a,  e_col(ix)     ;; Colour
   ld b,  e_h(ix)       ;; Height
   ld c,  e_w(ix)       ;; Width
   ex de, hl            ;; DrawSolidBox needs the position in DE
   call cpct_drawSolidBox_asm 
ret