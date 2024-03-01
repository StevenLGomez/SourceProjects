# worm.c

A simple C compile demo for testing mingw cross compile container.   
When compiling with Mingw64, currently has issues with POSIX signals:   
SIGTSTP   
SIGALRM   
SIGQUIT => which the mingw64 compiler asks "Did you mean SIGABRT?"   

### To build for local execution, use:
```
gcc -L/usr/include -lncurses worm.c -o worm
```

### To cross compile for Windoze execution, use:
```
$CC -I/usr/include/ncursesw -L/usr/include -lncursesw worm.c -o worm.exe
```
