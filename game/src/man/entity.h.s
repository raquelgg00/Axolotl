.globl entity_create
.globl entity_copy
.globl entity_doForAll_matching
.globl entity_update
.globl entity_vector


; Constantes
e_x             = 0
e_y             = 1
e_vx            = 2
e_vy            = 3
e_w             = 4
e_h             = 5
e_spriteL       = 6
e_spriteH       = 7
e_status        = 8
e_iaL           = 9
e_iaH           = 10

e_type_invalid  = 0x00 
e_type_render   = 0x01
e_type_movable  = 0x02
e_type_input    = 0x04
e_type_ia       = 0x08
e_type_animated = 0x10
e_type_dead     = 0x80
e_type_default  = 0x7F

k_max_num_entities = 20
k_size_entity      = 11



;; Define an entity 
.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _sprite, _status, _ia
   _name:
      .db _x,  _y    ;; x, y
      .db _vx, _vy   ;; Vx, Vy
      .db _w, _h     ;; Width, Height
      .dw _sprite    ;; sprite
      .db _status    ;; Status  (00-invalid // 01-alive // 80-delete // 7F-default)
      .dw _ia        ;; IA (puntero a funcion)
.endm

;; Define an entity with default values
.macro DefineEntityDefault _name, _suf
   DefineEntity _name'_suf, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0000, e_type_invalid, 0x0000;;                   
.endm

;; Define N default entities (changing the names)
.macro DefineNEntities _name, _n
   _c = 0
   .rept _n
      DefineEntityDefault _name, \_c
      _c = _c + 1 
   .endm
.endm
