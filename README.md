# bashfunctions


## cd.sh

Redifines the change directory command /cd/. When using /cd/ without parameters, instead of changing to home directory, /cd/ will output the latest directories you visited and let you change directory using an index number.

```
/etc/X11/xkb$ cd
 1 /usr/include/linux/android
 2 /usr/include/linux/mmc
 3 /usr
 4 /usr/local
/etc/X11/xkb$ cd 4
/usr/local$ cd
 1 /etc/X11/xkb
 2 /usr/include/linux/android
 3 /usr/include/linux/mmc
 4 /usr
 5 /usr/local
```
