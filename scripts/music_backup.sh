
# Rsync command to backup SqueezeBox Server to locally attached USB drive.
# NOTE - There is not a forward slash at the end of the following command, therefore the MusicCollection
#        directory will be used instead of creating it.
sudo rsync --progress --archive --delete admin@apollo:/media/MusicCollection /media/gomez/MusicCollection

