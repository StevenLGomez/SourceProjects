
#     [OPTION...]    SRC                                  DEST
# rsync -av --progress /home/gomez/projects/vmShare/Videos/ /me3dia/gomez/Video_2/Videos

# The following copies 'contents of' src/Videos to dest/Videos, because of trailing slash on src
rsync -av --progress --delete /media/gomez/Seagate2TB-7200R/Videos/ /media/gomez/<volume name>

