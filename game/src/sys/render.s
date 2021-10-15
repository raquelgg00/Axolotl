.include "render.h.s"
.include "tilemaps/mazmorra.h.s"
.include "man/entity.h.s"

.globl _main_palette
.globl _tiles_00

;; ===============================
;; INICIALIZA LA PALETA
;; Destroy: AF, DE, BC, HL
;; Input: IX --> Pointers to the entity
;; ===============================
render_init:

    ;; Establecemos el Modo de video
    ld c, #0
    call cpct_setVideoMode_asm

    ;; Establecemos la paleta
    ld hl, #_main_palette
    ld de, #16
    call cpct_setPalette_asm

    ;; Ponemos el color del borde igual que el fondo
    ld l, #16    ;; color del borde en la paleta
    ld h, #20     ;; color del fondo
    call cpct_setPALColour_asm

ret

render_tilemap:
    ld b, #_tilemapM_H ;;height en tiles de la ventana
    ld c, #_tilemapM_W ;;width en tiles de la ventana

    ld de, #_tilemapM_W ;; width en tiles de todo el tilemap
    ld hl, #_tiles_00
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld hl, #0xC000
    ld de, #_tilemapM
    call cpct_etm_drawTilemap4x8_ag_asm
ret

;; ===============================
;; DIBUJA UNA ENTIDAD
;; Destroy: AF, DE, BC, HL
;; Input: IX --> Pointers to the entity
;; ===============================
render_draw_one:

    ld    de, #0xC000      ;; Starting adrees of screen
    ld    c, e_x(ix)       ;; C = entity_X
    ld    b, e_y(ix)       ;; B = entity_Y
    call  cpct_getScreenPtr_asm ;; returns the position in hl

    ex de, hl            ;; DrawSolidSprite needs the position in DE
    ld l, e_spriteL(ix)
    ld h, e_spriteH(ix)

    ld b,  e_h(ix)       ;; Height
    ld c,  e_w(ix)       ;; Width
    call cpct_drawSprite_asm

ret


;; ===============================
;; EJECUTA PARA TODAS LAS ENTIDADES
;; Input:
;; Output:
;; ===============================
render_update:
    ld hl, #render_draw_one
    ld b, #e_cmp_render
    call entity_doForAll_matching
ret


