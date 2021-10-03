.globl entity_create
.globl entity_copy

.globl entity_vector


; Constantes
e_x             = 0
e_y             = 1
e_vx            = 2
e_vy            = 3
e_w             = 4
e_h             = 5
e_col           = 6
e_status        = 7

e_type_invalid  = 0x00 
e_type_alive    = 0x01 
e_type_dead     = 0x80
e_type_default  = 0x7F

k_max_num_entities = 20
k_size_entity      = 8



;; Define an entity 
.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _status
   _name:
      .db _x,  _y    ;; x, y
      .db _vx, _vy   ;; Vx, Vy
      .db _w, _h     ;; Width, Height
      .db _col       ;; Colour
      .db _status    ;; Status  (00-invalid // 01-alive // 80-delete // 7F-default)
.endm

;; Define an entity with default values
.macro DefineEntityDefault _name, _suf
   DefineEntity _name'_suf, 0x4F, 0x50, 0xFF, 0x00, 0x01, 0x04, 0xFF, e_type_default;;
                            
.endm

;; Define N default entities (changing the names)
.macro DefineNEntities _name, _n
   _c = 0
   .rept _n
      DefineEntityDefault _name, \_c
      _c = _c + 1 
   .endm
.endm
