
.include "entity.h.s"
.include "sys/physics.h.s"

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

;; ===============================
;; EJECUTA PARA TODAS LAS ENTIDADES CON COMPROBACION
;; Input: HL -> Rutina a ejecutar
;;        B  -> Signature a comprobar
;; Output:
;; ===============================
entity_doForAll_matching:
    ld a, (num_entities)
    cp #0 
    jr z, noEntities

    ld ix, #entity_vector
    ld (metodo), hl
   
    bucle:
        push af

        ;;comprobamos si la entidad es valida o no
        ld a, e_status(ix) 
        cp #e_type_invalid
        jr z, noEntities
        
        ;; Comprobar que el estado de la entidad coincide con la mascara que pasan por el registro B
        and b
        cp b
        jr nz, no_matching

            metodo=.+1 ;;la direccion que quiero modificar (la actual mas 1)

            call physics_update_one

        no_matching:

        pop af
        ld bc, #k_size_entity
        add ix, bc ;;paso a la siguiente
        
        dec a
        jp nz, bucle

    noEntities:
ret


;; init, destroy, set4destruction, update, freespace, entity_doForAll_matching