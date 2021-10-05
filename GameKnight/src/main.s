.area _DATA
.area _CODE

.include "player.h.s"
.include "ground.h.s"
.include "obstaculo.h.s"
.include "cpctelera.h.s"

_main::

   ; Dibujamos un suelo estatico
   call drawGround

   resetPlayer::

      ; Borro (azul oscuro)
      call erasePlayer
      call eraseObstacle

      ; Update player
      call jumpControl
      call checkUserInput
      call updateObstacle

      call getPlayerPtr    ;; devuelve en HL el puntero
      call checkCollision  ;; devuelve a=FF si hay colision
      
      
      ; Dibujo al personaje (azul oscuro)
      call drawPlayer
      call drawObstacle

      ; Espera a que el raster este fuera de la pantalla
      call cpct_waitVSYNC_asm 

   jr resetPlayer
