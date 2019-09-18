# color wandering

## description

This program is a generative art piece to be displayed at the Becton Center cafe on a Raspberry Pi. On start, a number of random brush strokes are placed in the various displays against a black background. These brush strokes have a random color and random config with different weights and velocities. The strokes wander over time, creating an intricate, colorful pattern. After a minute, the display is cleared and the generative art restarts, creating another unique pattern.
This piece is supposed to represent students' wanderings through university. Different students with different passions (different colors) wander through higher education looking for purpose. Every year, the cycle restarts as the composition of the university changes.

## running on Raspberry Pi

- install procesing-java
  - run: curl https://processing.org/download/install-arm.sh | sudo sh
- start program on boot
  - choose directory: `cd /etc/xdg/lxsession/LXDE-pi`
  - edit autostart script: `sudo nano autostart`
  - add following line: `@python ABSOLUTE_PATH_TO_THIS_DIR/start.py`

## video of program

- https://youtu.be/crYOjCqI8yY

## based on the following resources

- https://www.openprocessing.org/sketch/110105
- https://github.com/brycedbjork/mapping-display/blob/master/mapping/mapping_info.txt
