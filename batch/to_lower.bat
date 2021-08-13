@rem Command I found in stackoverflow that renames DOS file names to lower case recursively.
@rem Changes file names only, directory names are not changed.
@rem Runs in standard DOS shell (cmd.exe)
@rem
@rem Useful for renaming header files from OLD compilers to lower case to allow
@rem static analysis on any platform.

for /r %D in (.) do @for /f "eol=: delims=" %F in ('dir /l/b/a-d "%D"') do @ren "%D\%F" "%F"
