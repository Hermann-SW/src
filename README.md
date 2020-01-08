Fork mission statement:
-----------------------

Only target of this fork is to get fbclock.c running under Raspbian.
Fixes compile errors, undefined constants, switches to a working font
(with matching magic value) and finally adds seconds output.

Build&run:  
cd bin  
gcc fbclock.c -o fbclock -lm -lz  
./fbclock  

This will display hour+minute+second time in right top corner of framebuffer.
fbclock acts on two environment variables (FONT, FRAMEBUFFER).
