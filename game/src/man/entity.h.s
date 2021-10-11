.globl entity_create
.globl entity_copy
.globl entity_doForAll_matching
.globl entity_doForAll_pairs_matching
.globl entity_update
.globl entity_vector


; Constantes
e_tipo            = 0
e_cmps            = 1
e_x               = 2
e_y               = 3
e_vx              = 4
e_vy              = 5
e_w               = 6
e_h               = 7
e_spriteL         = 8
e_spriteH         = 9
e_iaL             = 10
e_iaH             = 11
e_collidesAgainst = 12


;; Tipos
e_type_invalid  = 0x00 
e_type_player   = 0x01
e_type_enemy    = 0x02
e_type_dead     = 0x80
e_type_default  = 0x7F

;; Components
e_cmp_render   = 0x01
e_cmp_movable  = 0x02
e_cmp_input    = 0x04
e_cmp_ia       = 0x08
e_cmp_animated = 0x10
e_cmp_collider = 0x20

k_max_num_entities = 15
k_size_entity      = 13



;; Define an entity 
.macro DefineEntity _name, _tipo, _cmps, _x, _y, _vx, _vy, _w, _h, _sprite, _ia, _collides
   _name:
      .db _tipo      ;; (Invalid 00, Player 01, Enemigo 02, Dead 80, Default 7F)
      .db _cmps      ;; ()
      .db _x,  _y    ;; x, y
      .db _vx, _vy   ;; Vx, Vy
      .db _w, _h     ;; Width, Height
      .dw _sprite    ;; sprite (puntero al sprite)
      .dw _ia        ;; IA     (puntero a funcion)
      .db _collides  ;; Collides Against
.endm

;; Define an entity with default values
.macro DefineEntityDefault _name, _suf
                        ;;  Tipo  cmps  x     y      vx   vy   width height  sprite   ia    collides
   DefineEntity _name'_suf, 0xDE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0000, 0x0000, 0xAD      ;;                   
.endm

;; Define N default entities (changing the names)
.macro DefineNEntities _name, _n
   _c = 0
   .rept _n
      DefineEntityDefault _name, \_c
      _c = _c + 1 
   .endm
.endm
