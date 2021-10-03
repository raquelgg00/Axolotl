
.include "entity.h.s"

entity_vector:
    DefineNEntities entity_vector k_max_num_entities


num_entities: .db 00            
next_entity : .dw entity_vector
registro_ix : .dw 0x0000

;; ===============================
;; REGISTRA UNA ENTIDAD
;; Output: HL --> Entidad creada 
;; Destroys: AF, BC, HL
;; ===============================
entity_register:
    ; Update the counter of num_entities (num_entities++)
    ld a, (num_entities)
    inc a
    ld (num_entities), a

    ; EntityVector points to the next entity
    ld hl, (next_entity)
    ld bc, #k_size_entity
    add hl, bc
    ld (next_entity), hl

    or a        ;; elimina el posible acarraeo
    sbc hl, bc  ;; resta con accarreo HL = HL - BC (deja HL como estaba antes --> CurrentEntity)

ret


;; ===============================
;; CREA UNA ENTIDAD
;; Output: HL, IX --> Entidad creada 
;; ===============================
entity_create:
    call entity_register

    ;; IX = HL (entidad creada)
    ld (registro_ix), hl
    ld ix, (registro_ix)

    ld e_status(ix), #e_type_alive
ret

;; ===============================
;; COPIA UNA ENTIDAD
;; Input: HL -> Entidad Origen (tmp)
;;        DE -> Entidad Destino (entidad creada)
;;
;; Output: HL -->Entidad Creada
;; ===============================
entity_copy:

    ld bc, #k_size_entity
    ldir    ;; copy from HL to DE, bc bytes
    
    ex de, hl       ;; HL -> Siguiente Entidad
    sbc hl, bc      ;; HL = HL - EntidadSize (Entidad Nueva)
    
ret