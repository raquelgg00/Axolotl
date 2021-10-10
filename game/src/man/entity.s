
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
        ld a, e_tipo(ix) 
        cp #e_type_invalid
        jr z, noEntities
        
        ;; Comprobar que el estado de la entidad coincide con la mascara que pasan por el registro B
        ld a, e_cmps(ix) 
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


;; ===============================
;; MARCAR PARA DEDSTRUIR
;; Input: IX -> Entidad a marcar
;; ===============================
entity_set4destruction:
    ld e_tipo(ix), #e_type_dead
ret

;; ===============================
;; BORRAR TODAS LAS ENTIDADES QUE LE PASAN
;; Input: IX -> Entidad actual
;; Destroy: AF, DE, IY, HL
;; ===============================
entity_destroy_malo:
    ;; We point to the first entity
    ld ix, #entity_vector

    ;; Comprobamos si hay entidades
    ld a, (num_entities)
    cp #0 
    jr z, no_hay_entidades

    loop_status:

        push af

        ld a, e_tipo(ix)

        ;; Check Entity status
        cp #e_type_invalid
        jr nz, continueDeleting
            ; If status = 00 (invalid) --> break loop
            pop af
            ret

        ;; If status != 00 --> continue
        continueDeleting:
        cp #e_type_dead
        jr nz, doNotDelete
            ; if status == #0x11 --> DELETE ENTITY

            ;; Check if there is only one
            ld a, (num_entities)
            cp #1
            jr z, deleteOne

                ;; Do HL --> LastEntity
                ld hl, (next_entity)  ;; the one which doesnt exist yet

                ;; hl = hl - 8
                ld de, #-k_size_entity
                add hl, de

                ;; Next Entity = next_entity - sizeEntity
                ld (next_entity), hl

                ; Do DE --> IX (EntityDeleting)
                ld (registro_ix), ix
                ld de, (registro_ix)
                
                ; Copy last entity data into the deleting one
                call entity_copy

                ;; Point HL --> LastENtity
                ld hl, (next_entity)  ;; the one which doesnt exist yet
                
                ;ld iy, (next_entity)
                ld iy, (next_entity)

                ;; IY -> Last ENtity
                ld e_tipo(iy), #e_type_invalid

                ;; num_entities--
                ld a, (num_entities)
                dec a
                ld (num_entities), a

                ;; ix = ix - 8
                ld de, #-k_size_entity
                add ix, de

                pop af
                dec a

                jr nz, loop_status
                    

            deleteOne:
                ld e_tipo(ix), #e_type_invalid

                ;; num_entities--
                ld a, (num_entities)
                dec a
                ld (num_entities), a

                pop af
                ret



        doNotDelete:
            ; ix -> ix + k_size_entity (point to the next entity)
            ld bc, #k_size_entity
            add ix, bc

            ;; if nextEntity.tipo == invalid  --> breakLoop
        

        pop af
        dec a

    jr nz, loop_status

    no_hay_entidades:

ret

entity_destroy:
    ;; Do HL --> LastEntity
    ld hl, (next_entity)  ;; the one which doesnt exist yet

    ;; hl = hl - 8
    ld de, #-k_size_entity
    add hl, de

    ;; Next Entity = next_entity - sizeEntity
    ld (next_entity), hl

    ; Do DE --> IX (EntityDeleting)
    ld (registro_ix), ix
    ld de, (registro_ix)
                
    ; Copy last entity data into the deleting one (copia hl en de)
    call entity_copy
                
    ;ld iy, (next_entity)
    ld iy, (next_entity)

    ;; IY -> Last ENtity
    ld e_tipo(iy), #e_type_invalid

    ;; num_entities--
    ld a, (num_entities)
    dec a
    ld (num_entities), a

    ;; ix = ix - 8
    ld de, #-k_size_entity
    add ix, de

ret 


;; ===============================
;; VER SI LAS ENTIDADES SE TIENEN QUE BORRAR e_type_dead = 0x80
;; Input: 
;; Destroy: AF, IX, BC
;; ===============================
entity_update:
    ld a, (num_entities)
    cp #0 
    jr z, sinEntities

    ld ix, #entity_vector
    ld (metodo), hl
   
    buscarDead:
        push af

        ;;comprobamos si la entidad es valida o no
        ld a, e_tipo(ix) 
        cp #e_type_invalid
        jr z, sinEntities
        
        ;; Comprobar que el estado de la entidad coincide con la mascara que pasan por el registro B
        cp #e_type_dead
        jr nz, noDestroy
            call entity_destroy

        noDestroy:

        pop af
        ld bc, #k_size_entity
        add ix, bc ;;paso a la siguiente
        
        dec a
        jp nz, buscarDead

    sinEntities:
ret

;; freespace, entity_doForAll_matching



