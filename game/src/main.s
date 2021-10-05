.include "main.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"


.area _DATA
.area _CODE

_main::
  
   call cpct_disableFirmware_asm
   

   call game_init
   call game_play

   

