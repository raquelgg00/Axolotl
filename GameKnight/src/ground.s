.area _DATA

    groundY:    .db #88

    .globl cpct_drawSolidBox_asm
    .globl cpct_getScreenPtr_asm

.area _CODE
; ================================================
;           Dibuja el suelo
; ================================================
drawGround::
    
    ;; ----- Primera parte del suelo -------
    ;; Calculate Screen Position
    ld de, #0xC000
    ld a, #0x00         ; X = 0
    ld c, a          
    ld a, (groundY)     ; Y = yPlayer
    ld b, a   

    ; Me devuelve en HL la posicion de memoria a dibujar
    call cpct_getScreenPtr_asm

    ex de, hl   ; posicion de la memoria empieza (left-up)
    ld a, #0xF0 ; color cyan
    ;ld c, #80   ; width = 80
    ;ld b, #4    ; height = 4
    ld bc, #0x0428 

    call cpct_drawSolidBox_asm


    ;; ----- Segunda parte del suelo -------
    ;; Calculate Screen Position
    ld de, #0xC000
    ld a, #0x28       ; X = 0
    ld c, a          
    ld a, (groundY)     ; Y = yGround
    ld b, a   

    ; Me devuelve en HL la posicion de memoria a dibujar
    call cpct_getScreenPtr_asm

    ex de, hl   ; posicion de la memoria empieza (left-up)
    ld a, #0xF0 ; color cyan
    ;ld c, #80   ; width = 80
    ;ld b, #4    ; height = 4
    ld bc, #0x0428

    call cpct_drawSolidBox_asm
    
ret